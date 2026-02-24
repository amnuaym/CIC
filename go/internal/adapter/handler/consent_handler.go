package handler

import (
	"context"
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/amnuaym/cic/go/internal/core/domain"
	"github.com/google/uuid"
	"github.com/gorilla/mux"
)

// consentLister is the interface for listing all consents
type consentLister interface {
	ListAll(ctx context.Context, limit, offset int) ([]*domain.Consent, error)
}

// ConsentHandler handles top-level consent endpoints (cross-customer)
type ConsentHandler struct {
	repo consentLister
}

func NewConsentHandler(repo consentLister) *ConsentHandler {
	return &ConsentHandler{repo: repo}
}

// ListConsents returns all consents across all customers
// @Summary List all consents
// @Description List all consent records across all customers with pagination
// @Tags consents
// @Produce json
// @Param limit query int false "Limit" default(50)
// @Param offset query int false "Offset" default(0)
// @Success 200 {array} domain.Consent
// @Router /api/v1/consents [get]
func (h *ConsentHandler) ListConsents(w http.ResponseWriter, r *http.Request) {
	// Parse pagination from query params
	limit, _ := strconv.Atoi(r.URL.Query().Get("limit"))
	if limit <= 0 {
		limit = 50
	}
	offset, _ := strconv.Atoi(r.URL.Query().Get("offset"))

	// Check for 'q' query param (search term)
	searchQuery := r.URL.Query().Get("q")

	var consents []*domain.Consent
	var err error

	if searchQuery == "" {
		// No search query => return empty list (search-first UX)
		consents = []*domain.Consent{}
	} else if searchQuery == "*" {
		// Wildcard => return all
		consents, err = h.repo.ListAll(r.Context(), limit, offset)
	} else {
		// Topic search/filter (simple implementation for now using ListAll as placeholder)
		// In a real scenario, this would call h.repo.Search(searchQuery)
		consents, err = h.repo.ListAll(r.Context(), limit, offset)
	}

	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	if consents == nil {
		consents = []*domain.Consent{}
	}

	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("X-Total-Count", strconv.Itoa(len(consents)))
	w.Header().Set("Access-Control-Expose-Headers", "X-Total-Count")
	json.NewEncoder(w).Encode(consents)
}

// GetConsent returns a single consent by ID
// @Summary Get consent
// @Description Get a single consent record by its ID
// @Tags consents
// @Produce json
// @Param id path string true "Consent ID"
// @Success 200 {object} domain.Consent
// @Router /api/v1/consents/{id} [get]
func (h *ConsentHandler) GetConsent(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	_, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "invalid ID", http.StatusBadRequest)
		return
	}

	// Placeholder — GetByID for consents to be added in Phase 2
	http.Error(w, "not implemented yet", http.StatusNotImplemented)
}
