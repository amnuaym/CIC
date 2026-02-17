package service

import (
	"context"
	"errors"
	"testing"
	"time"

	"github.com/amnuaym/cic/go/internal/core/domain"
	"github.com/google/uuid"
)

// Mock CustomerRepository
type mockCustomerRepo struct {
	createFunc  func(ctx context.Context, c *domain.Customer) error
	getByIDFunc func(ctx context.Context, id uuid.UUID) (*domain.Customer, error)
	updateFunc  func(ctx context.Context, c *domain.Customer) error
	deleteFunc  func(ctx context.Context, id uuid.UUID) error
	searchFunc  func(ctx context.Context, query string) ([]*domain.Customer, error)
}

func (m *mockCustomerRepo) Create(ctx context.Context, c *domain.Customer) error {
	return m.createFunc(ctx, c)
}
func (m *mockCustomerRepo) GetByID(ctx context.Context, id uuid.UUID) (*domain.Customer, error) {
	return m.getByIDFunc(ctx, id)
}
func (m *mockCustomerRepo) Update(ctx context.Context, c *domain.Customer) error {
	return m.updateFunc(ctx, c)
}
func (m *mockCustomerRepo) Delete(ctx context.Context, id uuid.UUID) error {
	return m.deleteFunc(ctx, id)
}
func (m *mockCustomerRepo) Search(ctx context.Context, query string) ([]*domain.Customer, error) {
	return m.searchFunc(ctx, query)
}
func (m *mockCustomerRepo) List(ctx context.Context, limit, offset int) ([]*domain.Customer, error) {
	return nil, nil // Not used in test
}

// Mock AuditService
type mockAuditService struct {
	logFunc func(ctx context.Context, entityID uuid.UUID, entityType, action, performedBy, changes, ip string)
}

func (m *mockAuditService) Log(ctx context.Context, entityID uuid.UUID, entityType, action, performedBy, changes, ip string) {
	m.logFunc(ctx, entityID, entityType, action, performedBy, changes, ip)
}

// Mock other repos (nil for now as not testing sub-resources)
type mockSubRepo struct{}
func (m *mockSubRepo) Create(ctx context.Context, a interface{}) error { return nil }
// ... implement interfaces if needed, but for now passing nil might panic if service calls them.
// Service only calls them in specific methods. We are testing CreateCustomer and AnonymizeCustomer.
// CreateCustomer calls customerRepo.Create.
// AnonymizeCustomer calls customerRepo.GetByID, Update, and addressRepo.Delete.
// So we need mockAddressRepo.

type mockAddressRepo struct {
	deleteFunc func(ctx context.Context, id uuid.UUID) error
}
func (m *mockAddressRepo) Create(ctx context.Context, a *domain.Address) error { return nil }
func (m *mockAddressRepo) ListByCustomerID(ctx context.Context, id uuid.UUID) ([]*domain.Address, error) { return nil, nil }
func (m *mockAddressRepo) GetByID(ctx context.Context, id uuid.UUID) (*domain.Address, error) { return nil, nil }
func (m *mockAddressRepo) Update(ctx context.Context, a *domain.Address) error { return nil }
func (m *mockAddressRepo) Delete(ctx context.Context, id uuid.UUID) error { return m.deleteFunc(ctx, id) }


func TestCreateCustomer(t *testing.T) {
	mockRepo := &mockCustomerRepo{
		createFunc: func(ctx context.Context, c *domain.Customer) error {
			c.ID = uuid.New()
			return nil
		},
	}
	mockAudit := &mockAuditService{
		logFunc: func(ctx context.Context, entityID uuid.UUID, entityType, action, performedBy, changes, ip string) {
			// Verify log call
			if action != "CREATE" {
				t.Errorf("Expected action CREATE, got %s", action)
			}
		},
	}

	service := NewCustomerService(mockRepo, nil, nil, nil, nil, mockAudit)
	
	c := &domain.Customer{FirstName: "John", LastName: "Doe", Type: domain.CustomerTypePersonal}
	err := service.CreateCustomer(context.Background(), c)
	if err != nil {
		t.Errorf("Unexpected error: %v", err)
	}
	if c.ID == uuid.Nil {
		t.Errorf("Expected ID to be generated")
	}
}

func TestAnonymizeCustomer(t *testing.T) {
	cid := uuid.New()
	mockRepo := &mockCustomerRepo{
		getByIDFunc: func(ctx context.Context, id uuid.UUID) (*domain.Customer, error) {
			return &domain.Customer{ID: cid, FirstName: "John", LastName: "Doe", PortfolioSize: 0}, nil
		},
		updateFunc: func(ctx context.Context, c *domain.Customer) error {
			if c.FirstName == "John" {
				t.Errorf("Expected FirstName to be masked")
			}
			return nil
		},
	}
	mockAddress := &mockAddressRepo{
		deleteFunc: func(ctx context.Context, id uuid.UUID) error {
			return nil
		},
	}
	mockAudit := &mockAuditService{
		logFunc: func(ctx context.Context, entityID uuid.UUID, entityType, action, performedBy, changes, ip string) {
			if action != "ANONYMIZE" {
				t.Errorf("Expected action ANONYMIZE, got %s", action)
			}
		},
	}

	service := NewCustomerService(mockRepo, mockAddress, nil, nil, nil, mockAudit)

	err := service.AnonymizeCustomer(context.Background(), cid)
	if err != nil {
		t.Errorf("Unexpected error: %v", err)
	}
}

func TestAnonymizeCustomer_ActivePortfolio(t *testing.T) {
	cid := uuid.New()
	mockRepo := &mockCustomerRepo{
		getByIDFunc: func(ctx context.Context, id uuid.UUID) (*domain.Customer, error) {
			return &domain.Customer{ID: cid, PortfolioSize: 5}, nil
		},
	}

	service := NewCustomerService(mockRepo, nil, nil, nil, nil, nil)

	err := service.AnonymizeCustomer(context.Background(), cid)
	if err == nil {
		t.Errorf("Expected error for active portfolio")
	}
	if err.Error() != "cannot anonymize customer with active portfolio" {
		t.Errorf("Expected specific error message, got %s", err.Error())
	}
}
