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
	limit, _ := strconv.Atoi(r.URL.Query().Get("limit"))
	if limit <= 0 {
		limit = 50
	}
	offset, _ := strconv.Atoi(r.URL.Query().Get("offset"))

	consents, err := h.repo.ListAll(r.Context(), limit, offset)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	if consents == nil {
		consents = []*domain.Consent{}
	}

	w.Header().Set("Content-Type", "application/json")
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
