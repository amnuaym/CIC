package handler

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/amnuaym/cic/go/internal/auth"
	"github.com/amnuaym/cic/go/internal/core/domain"
	"github.com/amnuaym/cic/go/internal/core/ports"
	"github.com/amnuaym/cic/go/internal/middleware"
	"github.com/google/uuid"
	"github.com/gorilla/mux"
)

type CustomerHandler struct {
	service ports.CustomerService
}

func NewCustomerHandler(service ports.CustomerService) *CustomerHandler {
	return &CustomerHandler{service: service}
}

// @Summary List customers
// @Description List customers with pagination
// @Tags customers
// @Produce  json
// @Success 200 {array} domain.Customer
// @Router /api/v1/customers [get]
func (h *CustomerHandler) ListCustomers(w http.ResponseWriter, r *http.Request) {
	// Parse pagination from query params (React Admin sends ?_end=10&_order=DESC&_sort=id&_start=0)
	// Or just simple limits if we want strict compliance.
	// React Admin Simple Rest uses: range=[0,9] (Content-Range header response)
	// BUT ra-data-simple-rest expects X-Total-Count usually.

	// Let's implement basic limit/offset parsing
	// limit := 10
	// offset := 0
	// ... logic to parse query ...
	// For MVP, hardcode/default or parse simple params.

	// limit := 10 (omitted for now)
	// offset := 0 (omitted for now)

	// React Admin ra-data-simple-rest sends: ?filter={}&range=[0,9]&sort=["id","ASC"]
	// We need to support this or just standard limit/offset.
	// Let's assume standard for now or parse "range".

	// Check for 'deleted' query param
	showDeleted := r.URL.Query().Get("deleted") == "true"

	var customers []*domain.Customer
	var err error

	if showDeleted {
		customers, err = h.service.ListDeletedCustomers(r.Context(), 100, 0)
	} else {
		customers, err = h.service.ListCustomers(r.Context(), 100, 0)
	}
	if err != nil {
		log.Printf("ERROR ListCustomers: %v", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("X-Total-Count", "100") // Mock total count for pagination to work
	w.Header().Set("Access-Control-Expose-Headers", "X-Total-Count")
	json.NewEncoder(w).Encode(customers)
}

// @Summary Create a new customer
// @Description Create a new customer with the input payload
// @Tags customers
// @Accept  json
// @Produce  json
// @Success 201 {object} domain.Customer
// @Router /api/v1/customers [post]
func (h *CustomerHandler) CreateCustomer(w http.ResponseWriter, r *http.Request) {
	var c domain.Customer
	if err := json.NewDecoder(r.Body).Decode(&c); err != nil {
		http.Error(w, "Invalid request payload", http.StatusBadRequest)
		return
	}

	if err := h.service.CreateCustomer(r.Context(), &c); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(c)
}

// @Summary Get a customer
// @Description Get a customer by ID
// @Tags customers
// @Produce  json
// @Success 200 {object} domain.Customer
// @Router /api/v1/customers/{id} [get]
func (h *CustomerHandler) GetCustomer(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "Invalid customer ID", http.StatusBadRequest)
		return
	}

	c, err := h.service.GetCustomer(r.Context(), id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(c)
}

// @Summary Update a customer
// @Description Update a customer by ID
// @Tags customers
// @Accept  json
// @Produce  json
// @Success 200 {object} domain.Customer
// @Router /api/v1/customers/{id} [patch]
func (h *CustomerHandler) UpdateCustomer(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "Invalid customer ID", http.StatusBadRequest)
		return
	}

	var c domain.Customer
	if err := json.NewDecoder(r.Body).Decode(&c); err != nil {
		http.Error(w, "Invalid request payload", http.StatusBadRequest)
		return
	}
	c.ID = id

	if err := h.service.UpdateCustomer(r.Context(), &c); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(c)
}

// @Summary Delete a customer
// @Description Soft delete a customer by ID
// @Tags customers
// @Produce  json
// @Success 200 {object} map[string]string
// @Router /api/v1/customers/{id} [delete]
func (h *CustomerHandler) DeleteCustomer(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "Invalid customer ID", http.StatusBadRequest)
		return
	}

	// Security Check: Only Admin can delete
	claims, ok := r.Context().Value(middleware.UserContextKey).(*auth.JWTClaims)
	if !ok {
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		return
	}
	if claims.Role != "admin" {
		http.Error(w, "Forbidden: Only admins can delete customers", http.StatusForbidden)
		return
	}

	userID, err := uuid.Parse(claims.UserID)
	if err != nil {
		http.Error(w, "Invalid user ID in token", http.StatusUnauthorized)
		return
	}

	if err := h.service.DeleteCustomer(r.Context(), id, userID); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{"message": "Customer deleted successfully"})
}

// @Summary Restore a customer
// @Description Restore a soft-deleted customer by ID
// @Tags customers
// @Produce  json
// @Success 200 {object} map[string]string
// @Router /api/v1/customers/{id}/restore [post]
func (h *CustomerHandler) RestoreCustomer(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "Invalid customer ID", http.StatusBadRequest)
		return
	}

	claims, ok := r.Context().Value(middleware.UserContextKey).(*auth.JWTClaims)
	if !ok {
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		return
	}

	userID, err := uuid.Parse(claims.UserID)
	if err != nil {
		http.Error(w, "Invalid user ID in token", http.StatusUnauthorized)
		return
	}

	if err := h.service.RestoreCustomer(r.Context(), id, userID); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{"message": "Customer restored successfully"})
}

// @Summary Search customers
// @Description Search customers by query parms
// @Tags customers
// @Produce  json
// @Success 200 {array} domain.Customer
// @Router /api/v1/customers/search [get]
func (h *CustomerHandler) SearchCustomers(w http.ResponseWriter, r *http.Request) {
	query := r.URL.Query().Get("q")
	customers, err := h.service.SearchCustomers(r.Context(), query)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(customers)
}

// --- Sub-Resources ---

func (h *CustomerHandler) AddAddress(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	customerID, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "Invalid customer ID", http.StatusBadRequest)
		return
	}

	var a domain.Address
	if err := json.NewDecoder(r.Body).Decode(&a); err != nil {
		http.Error(w, "Invalid request payload", http.StatusBadRequest)
		return
	}
	a.CustomerID = customerID

	if err := h.service.AddAddress(r.Context(), &a); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(a)
}

func (h *CustomerHandler) GetAddresses(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	customerID, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "Invalid customer ID", http.StatusBadRequest)
		return
	}

	addresses, err := h.service.GetAddresses(r.Context(), customerID)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(addresses)
}

// Similar handlers for Identity, Relationship, Consent...
// I'll add Identity handlers here to show the pattern

func (h *CustomerHandler) AddIdentity(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	customerID, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "Invalid customer ID", http.StatusBadRequest)
		return
	}

	var i domain.Identity
	if err := json.NewDecoder(r.Body).Decode(&i); err != nil {
		http.Error(w, "Invalid request payload", http.StatusBadRequest)
		return
	}
	i.CustomerID = customerID

	if err := h.service.AddIdentity(r.Context(), &i); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(i)
}

func (h *CustomerHandler) GetIdentities(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	customerID, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "Invalid customer ID", http.StatusBadRequest)
		return
	}

	identities, err := h.service.GetIdentities(r.Context(), customerID)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(identities)
}

// @Summary Anonymize a customer
// @Description Anonymize a customer by ID (Right to be Forgotten)
// @Tags customers
// @Produce  json
// @Success 204 "No Content"
// @Router /api/v1/customers/{id}/anonymize [post]
func (h *CustomerHandler) AnonymizeCustomer(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "Invalid customer ID", http.StatusBadRequest)
		return
	}

	if err := h.service.AnonymizeCustomer(r.Context(), id); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}

// --- Relationships ---

// @Summary Add a relationship
// @Description Add a relationship between customers
// @Tags relationships
// @Accept  json
// @Produce  json
// @Success 201 {object} domain.Relationship
// @Router /api/v1/customers/{id}/relationships [post]
func (h *CustomerHandler) AddRelationship(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	customerID, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "Invalid customer ID", http.StatusBadRequest)
		return
	}

	var rel domain.Relationship
	if err := json.NewDecoder(r.Body).Decode(&rel); err != nil {
		http.Error(w, "Invalid request payload", http.StatusBadRequest)
		return
	}
	rel.FromCustomerID = customerID

	if err := h.service.AddRelationship(r.Context(), &rel); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(rel)
}

// @Summary Get customer relationships
// @Description Get all relationships for a customer
// @Tags relationships
// @Produce  json
// @Success 200 {array} domain.Relationship
// @Router /api/v1/customers/{id}/relationships [get]
func (h *CustomerHandler) GetRelationships(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	customerID, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "Invalid customer ID", http.StatusBadRequest)
		return
	}

	relationships, err := h.service.GetRelationships(r.Context(), customerID)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(relationships)
}

// --- Consents ---

// @Summary Manage consent
// @Description Grant or update consent for a topic
// @Tags consents
// @Accept  json
// @Produce  json
// @Success 201 {object} domain.Consent
// @Router /api/v1/customers/{id}/consents [post]
func (h *CustomerHandler) ManageConsent(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	customerID, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "Invalid customer ID", http.StatusBadRequest)
		return
	}

	var consent domain.Consent
	if err := json.NewDecoder(r.Body).Decode(&consent); err != nil {
		http.Error(w, "Invalid request payload", http.StatusBadRequest)
		return
	}
	consent.CustomerID = customerID

	if err := h.service.ManageConsent(r.Context(), &consent); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(consent)
}

// @Summary Get consents
// @Description Get all consents for a customer
// @Tags consents
// @Produce  json
// @Success 200 {array} domain.Consent
// @Router /api/v1/customers/{id}/consents [get]
func (h *CustomerHandler) GetConsents(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	customerID, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "Invalid customer ID", http.StatusBadRequest)
		return
	}

	consents, err := h.service.GetConsents(r.Context(), customerID)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(consents)
}
