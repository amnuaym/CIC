package service

import (
	"context"
	"testing"

	"github.com/amnuaym/cic/go/internal/core/domain"
	"github.com/amnuaym/cic/go/internal/models"
	"github.com/google/uuid"
)

// Mock CustomerRepository
type mockCustomerRepo struct {
	createFunc  func(ctx context.Context, c *domain.Customer) error
	getByIDFunc func(ctx context.Context, id uuid.UUID) (*domain.Customer, error)
	updateFunc  func(ctx context.Context, c *domain.Customer) error
	deleteFunc  func(ctx context.Context, id, userID uuid.UUID) error
	restoreFunc func(ctx context.Context, id uuid.UUID) error
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
func (m *mockCustomerRepo) Delete(ctx context.Context, id, userID uuid.UUID) error {
	return m.deleteFunc(ctx, id, userID)
}
func (m *mockCustomerRepo) Restore(ctx context.Context, id uuid.UUID) error {
	if m.restoreFunc != nil {
		return m.restoreFunc(ctx, id)
	}
	return nil
}
func (m *mockCustomerRepo) Search(ctx context.Context, query string) ([]*domain.Customer, error) {
	return m.searchFunc(ctx, query)
}
func (m *mockCustomerRepo) List(ctx context.Context, limit, offset int) ([]*domain.Customer, error) {
	return nil, nil
}
func (m *mockCustomerRepo) ListDeleted(ctx context.Context, limit, offset int) ([]*domain.Customer, error) {
	return nil, nil
}

// Mock AuditService
type mockAuditService struct {
	logFunc func(ctx context.Context, entityID uuid.UUID, entityType, action, performedBy, changes, ip string)
}

func (m *mockAuditService) Log(ctx context.Context, entityID uuid.UUID, entityType, action, performedBy, changes, ip string) {
	if m.logFunc != nil {
		m.logFunc(ctx, entityID, entityType, action, performedBy, changes, ip)
	}
}

// Mock AddressRepo
type mockAddressRepo struct {
	deleteFunc func(ctx context.Context, id uuid.UUID) error
}

func (m *mockAddressRepo) Create(ctx context.Context, a *domain.Address) error { return nil }
func (m *mockAddressRepo) ListByCustomerID(ctx context.Context, id uuid.UUID) ([]*domain.Address, error) {
	return nil, nil
}
func (m *mockAddressRepo) Delete(ctx context.Context, id uuid.UUID) error {
	return m.deleteFunc(ctx, id)
}

// Mock IdentityRepo
type mockIdentityRepo struct{}

func (m *mockIdentityRepo) Create(ctx context.Context, i *domain.Identity) error { return nil }
func (m *mockIdentityRepo) ListByCustomerID(ctx context.Context, id uuid.UUID) ([]*domain.Identity, error) {
	return nil, nil
}
func (m *mockIdentityRepo) GetByNumber(ctx context.Context, number string) (*domain.Identity, error) {
	return nil, nil
}
func (m *mockIdentityRepo) Delete(ctx context.Context, id uuid.UUID) error { return nil }

// Mock RelationshipRepo
type mockRelationshipRepo struct{}

func (m *mockRelationshipRepo) Create(ctx context.Context, r *domain.Relationship) error { return nil }
func (m *mockRelationshipRepo) ListByCustomerID(ctx context.Context, id uuid.UUID) ([]*domain.Relationship, error) {
	return nil, nil
}
func (m *mockRelationshipRepo) Delete(ctx context.Context, id uuid.UUID) error { return nil }

// Mock ConsentRepo
type mockConsentRepo struct{}

func (m *mockConsentRepo) Create(ctx context.Context, c *domain.Consent) error { return nil }
func (m *mockConsentRepo) ListByCustomerID(ctx context.Context, id uuid.UUID) ([]*domain.Consent, error) {
	return nil, nil
}

// Mock UserRepo
type mockUserRepo struct {
	getByIDFunc func(ctx context.Context, id uuid.UUID) (*models.User, error)
}

func (m *mockUserRepo) GetByID(ctx context.Context, id uuid.UUID) (*models.User, error) {
	if m.getByIDFunc != nil {
		return m.getByIDFunc(ctx, id)
	}
	return nil, nil
}

// --- Tests ---

func TestCreateCustomer(t *testing.T) {
	mockRepo := &mockCustomerRepo{
		createFunc: func(ctx context.Context, c *domain.Customer) error {
			c.ID = uuid.New()
			return nil
		},
	}
	mockAudit := &mockAuditService{
		logFunc: func(ctx context.Context, entityID uuid.UUID, entityType, action, performedBy, changes, ip string) {
			if action != "CREATE" {
				t.Errorf("Expected action CREATE, got %s", action)
			}
		},
	}

	svc := NewCustomerService(mockRepo, nil, nil, nil, nil, nil, mockAudit)

	c := &domain.Customer{FirstName: "John", LastName: "Doe", Type: domain.TypePersonal}
	err := svc.CreateCustomer(context.Background(), c)
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

	svc := NewCustomerService(mockRepo, mockAddress, nil, nil, nil, nil, mockAudit)

	err := svc.AnonymizeCustomer(context.Background(), cid)
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

	svc := NewCustomerService(mockRepo, nil, nil, nil, nil, nil, nil)

	err := svc.AnonymizeCustomer(context.Background(), cid)
	if err == nil {
		t.Errorf("Expected error for active portfolio")
	}
	if err.Error() != "cannot anonymize customer with active portfolio" {
		t.Errorf("Expected specific error message, got %s", err.Error())
	}
}
