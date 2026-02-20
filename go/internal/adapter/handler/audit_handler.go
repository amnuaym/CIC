package handler

import (
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/amnuaym/cic/go/internal/adapter/repository"
	"github.com/google/uuid"
	"github.com/gorilla/mux"
)

// AuditLogHandler handles read-only audit log endpoints
type AuditLogHandler struct {
	repo *repository.AuditRepository
}

func NewAuditLogHandler(repo *repository.AuditRepository) *AuditLogHandler {
	return &AuditLogHandler{repo: repo}
}

// ListAuditLogs returns paginated audit logs
// @Summary List audit logs
// @Description List audit logs with optional action filter
// @Tags audit-logs
// @Produce json
// @Param limit query int false "Limit" default(50)
// @Param offset query int false "Offset" default(0)
// @Param action query string false "Filter by action (CREATE, UPDATE, DELETE, RESTORE, ANONYMIZE)"
// @Success 200 {array} repository.AuditLog
// @Router /api/v1/audit-logs [get]
func (h *AuditLogHandler) ListAuditLogs(w http.ResponseWriter, r *http.Request) {
	limit, _ := strconv.Atoi(r.URL.Query().Get("limit"))
	if limit <= 0 {
		limit = 50
	}
	offset, _ := strconv.Atoi(r.URL.Query().Get("offset"))
	action := r.URL.Query().Get("action")

	logs, err := h.repo.List(r.Context(), limit, offset, action)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	if logs == nil {
		logs = []*repository.AuditLog{}
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(logs)
}

// GetAuditLog returns a single audit log by ID
// @Summary Get audit log
// @Description Get a single audit log entry by its ID
// @Tags audit-logs
// @Produce json
// @Param id path string true "Audit log ID"
// @Success 200 {object} repository.AuditLog
// @Router /api/v1/audit-logs/{id} [get]
func (h *AuditLogHandler) GetAuditLog(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, err := uuid.Parse(vars["id"])
	if err != nil {
		http.Error(w, "invalid ID", http.StatusBadRequest)
		return
	}

	log, err := h.repo.GetByID(r.Context(), id)
	if err != nil {
		http.Error(w, "not found", http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(log)
}
