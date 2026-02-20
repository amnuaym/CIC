package handler

import (
	"context"
	"encoding/json"
	"errors"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/amnuaym/cic/go/internal/core/domain"
	"github.com/google/uuid"
	"github.com/gorilla/mux"
)

// Mock CustomerService
type mockCustomerService struct {
	createFunc            func(ctx context.Context, c *domain.Customer) error
	getFunc               func(ctx context.Context, id uuid.UUID) (*domain.Customer, error)
	updateFunc            func(ctx context.Context, c *domain.Customer) error
	deleteFunc            func(ctx context.Context, id uuid.UUID) error
	searchFunc            func(ctx context.Context, query string) ([]*domain.Customer, error)
	listFunc              func(ctx context.Context, limit, offset int) ([]*domain.Customer, error)
	anonymizeFunc         func(ctx context.Context, id uuid.UUID) error
	addAddressFunc        func(ctx context.Context, a *domain.Address) error
	getAddressesFunc      func(ctx context.Context, id uuid.UUID) ([]*domain.Address, error)
	removeAddressFunc     func(ctx context.Context, id uuid.UUID) error
	addIdentityFunc       func(ctx context.Context, i *domain.Identity) error
	getIdentitiesFunc     func(ctx context.Context, id uuid.UUID) ([]*domain.Identity, error)
	removeIdentityFunc    func(ctx context.Context, id uuid.UUID) error
	addRelationshipFunc   func(ctx context.Context, r *domain.Relationship) error
	getRelationshipsFunc  func(ctx context.Context, id uuid.UUID) ([]*domain.Relationship, error)
	removeRelationshipFunc func(ctx context.Context, id uuid.UUID) error
	manageConsentFunc     func(ctx context.Context, c *domain.Consent) error
	getConsentsFunc       func(ctx context.Context, id uuid.UUID) ([]*domain.Consent, error)
}

// Implement interface methods
func (m *mockCustomerService) CreateCustomer(ctx context.Context, c *domain.Customer) error { return m.createFunc(ctx, c) }
func (m *mockCustomerService) GetCustomer(ctx context.Context, id uuid.UUID) (*domain.Customer, error) { return m.getFunc(ctx, id) }
func (m *mockCustomerService) UpdateCustomer(ctx context.Context, c *domain.Customer) error { return m.updateFunc(ctx, c) }
func (m *mockCustomerService) DeleteCustomer(ctx context.Context, id uuid.UUID) error { return m.deleteFunc(ctx, id) }
func (m *mockCustomerService) SearchCustomers(ctx context.Context, query string) ([]*domain.Customer, error) { return m.searchFunc(ctx, query) }
func (m *mockCustomerService) ListCustomers(ctx context.Context, limit, offset int) ([]*domain.Customer, error) { return m.listFunc(ctx, limit, offset) }
func (m *mockCustomerService) AnonymizeCustomer(ctx context.Context, id uuid.UUID) error { return m.anonymizeFunc(ctx, id) }
// Sub-resources (minimal implementation for now)
func (m *mockCustomerService) AddAddress(ctx context.Context, a *domain.Address) error { return nil }
func (m *mockCustomerService) GetAddresses(ctx context.Context, id uuid.UUID) ([]*domain.Address, error) { return nil, nil }
func (m *mockCustomerService) RemoveAddress(ctx context.Context, id uuid.UUID) error { return nil }
func (m *mockCustomerService) AddIdentity(ctx context.Context, i *domain.Identity) error { return nil }
func (m *mockCustomerService) GetIdentities(ctx context.Context, id uuid.UUID) ([]*domain.Identity, error) { return nil, nil }
func (m *mockCustomerService) RemoveIdentity(ctx context.Context, id uuid.UUID) error { return nil }
func (m *mockCustomerService) AddRelationship(ctx context.Context, r *domain.Relationship) error { return nil }
func (m *mockCustomerService) GetRelationships(ctx context.Context, id uuid.UUID) ([]*domain.Relationship, error) { return nil, nil }
func (m *mockCustomerService) RemoveRelationship(ctx context.Context, id uuid.UUID) error { return nil }
func (m *mockCustomerService) ManageConsent(ctx context.Context, c *domain.Consent) error { return nil }
func (m *mockCustomerService) GetConsents(ctx context.Context, id uuid.UUID) ([]*domain.Consent, error) { return nil, nil }


func TestListCustomers(t *testing.T) {
	mockService := &mockCustomerService{
		listFunc: func(ctx context.Context, limit, offset int) ([]*domain.Customer, error) {
			return []*domain.Customer{
				{FirstName: "John", LastName: "Doe"},
				{FirstName: "Jane", LastName: "Smith"},
			}, nil
		},
	}

	handler := NewCustomerHandler(mockService)

	req, _ := http.NewRequest("GET", "/api/v1/customers", nil)
	rr := httptest.NewRecorder()

	handler.ListCustomers(rr, req)

	if status := rr.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v",
			status, http.StatusOK)
	}

	var customers []*domain.Customer
	if err := json.NewDecoder(rr.Body).Decode(&customers); err != nil {
		t.Errorf("handler returned invalid body: %v", err)
	}

	if len(customers) != 2 {
		t.Errorf("handler returned wrong number of customers: got %v want %v",
			len(customers), 2)
	}
}

func TestDeleteCustomer(t *testing.T) {
	mockService := &mockCustomerService{
		deleteFunc: func(ctx context.Context, id uuid.UUID) error {
			return nil
		},
	}

	handler := NewCustomerHandler(mockService)

	id := uuid.New()
	req, _ := http.NewRequest("DELETE", "/api/v1/customers/"+id.String(), nil)
	req = mux.SetURLVars(req, map[string]string{"id": id.String()})
	
	rr := httptest.NewRecorder()

	handler.DeleteCustomer(rr, req)

	if status := rr.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v",
			status, http.StatusOK)
	}
}

func TestDeleteCustomer_NotFound(t *testing.T) {
	mockService := &mockCustomerService{
		deleteFunc: func(ctx context.Context, id uuid.UUID) error {
			return errors.New("customer not found")
		},
	}

	handler := NewCustomerHandler(mockService)

	id := uuid.New()
	req, _ := http.NewRequest("DELETE", "/api/v1/customers/"+id.String(), nil)
	req = mux.SetURLVars(req, map[string]string{"id": id.String()})
	
	rr := httptest.NewRecorder()

	handler.DeleteCustomer(rr, req)

	if status := rr.Code; status != http.StatusInternalServerError { // Handler returns 500 on error currently
		t.Errorf("handler returned wrong status code: got %v want %v",
			status, http.StatusInternalServerError)
	}
}
