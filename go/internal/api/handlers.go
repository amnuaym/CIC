package api

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"
	"strings"

	"github.com/amnuaym/cic/go/internal/adapter/handler"
	"github.com/amnuaym/cic/go/internal/adapter/repository"
	"github.com/amnuaym/cic/go/internal/auth"
	"github.com/amnuaym/cic/go/internal/core/service"
	"github.com/amnuaym/cic/go/internal/middleware"
	"github.com/amnuaym/cic/go/internal/models"
	"github.com/google/uuid"
	"github.com/gorilla/mux"
)

type Handler struct {
	DB *sql.DB
}

// SetupRoutes configures all API routes
func SetupRoutes(router *mux.Router, db *sql.DB) {
	h := &Handler{DB: db}

	// Public routes
	router.HandleFunc("/health", h.HealthCheck).Methods("GET")
	router.HandleFunc("/api/auth/login", h.Login).Methods("POST")
	router.HandleFunc("/api/auth/register", h.Register).Methods("POST")
	router.HandleFunc("/api/auth/oauth/google", h.OAuthGoogle).Methods("GET")
	router.HandleFunc("/api/auth/oauth/callback", h.OAuthCallback).Methods("GET")

	// Protected routes with JWT
	protected := router.PathPrefix("/api").Subrouter()
	protected.Use(middleware.JWTAuth)

	protected.HandleFunc("/users/me", h.GetCurrentUser).Methods("GET")

	// CIC Dependencies
	auditRepo := repository.NewAuditRepository(db)
	auditService := service.NewAuditService(auditRepo) // Pass as struct pointer, but interface expects? Check signature

	customerRepo := repository.NewCustomerRepository(db)
	userRepo := repository.NewUserRepository(db)
	addressRepo := repository.NewAddressRepository(db)
	identityRepo := repository.NewIdentityRepository(db)
	relationshipRepo := repository.NewRelationshipRepository(db)
	consentRepo := repository.NewConsentRepository(db)

	customerService := service.NewCustomerService(customerRepo, addressRepo, identityRepo, relationshipRepo, consentRepo, userRepo, auditService)
	customerHandler := handler.NewCustomerHandler(customerService)
	auditLogHandler := handler.NewAuditLogHandler(auditRepo)
	consentHandler := handler.NewConsentHandler(consentRepo)

	// CIC Routes (v1) — JWT required for all
	v1 := router.PathPrefix("/api/v1").Subrouter()
	v1.Use(middleware.JWTAuth)

	// === Read-only routes (all authenticated users: VIEWER+) ===
	v1.HandleFunc("/customers", customerHandler.ListCustomers).Methods("GET")
	v1.HandleFunc("/customers/search", customerHandler.SearchCustomers).Methods("GET")
	v1.HandleFunc("/customers/{id}", customerHandler.GetCustomer).Methods("GET")
	v1.HandleFunc("/customers/{id}/addresses", customerHandler.GetAddresses).Methods("GET")
	v1.HandleFunc("/customers/{id}/identities", customerHandler.GetIdentities).Methods("GET")
	v1.HandleFunc("/customers/{id}/relationships", customerHandler.GetRelationships).Methods("GET")
	v1.HandleFunc("/customers/{id}/consents", customerHandler.GetConsents).Methods("GET")
	v1.HandleFunc("/audit-logs", auditLogHandler.ListAuditLogs).Methods("GET")
	v1.HandleFunc("/audit-logs/{id}", auditLogHandler.GetAuditLog).Methods("GET")
	v1.HandleFunc("/consents", consentHandler.ListConsents).Methods("GET")
	v1.HandleFunc("/consents/{id}", consentHandler.GetConsent).Methods("GET")

	// === Write routes (OPERATOR+) ===
	operatorRoutes := v1.PathPrefix("").Subrouter()
	operatorRoutes.Use(middleware.RequireRole(middleware.RoleSuperAdmin, middleware.RoleAdmin, middleware.RoleOperator))
	operatorRoutes.HandleFunc("/customers", customerHandler.CreateCustomer).Methods("POST")
	operatorRoutes.HandleFunc("/customers/{id}", customerHandler.UpdateCustomer).Methods("PATCH", "PUT")
	operatorRoutes.HandleFunc("/customers/{id}/addresses", customerHandler.AddAddress).Methods("POST")
	operatorRoutes.HandleFunc("/customers/{id}/identities", customerHandler.AddIdentity).Methods("POST")
	operatorRoutes.HandleFunc("/customers/{id}/relationships", customerHandler.AddRelationship).Methods("POST")
	operatorRoutes.HandleFunc("/customers/{id}/consents", customerHandler.ManageConsent).Methods("POST")

	// === Admin routes (ADMIN+): delete, restore, anonymize ===
	adminRoutes := v1.PathPrefix("").Subrouter()
	adminRoutes.Use(middleware.RequireRole(middleware.RoleSuperAdmin, middleware.RoleAdmin))
	adminRoutes.HandleFunc("/customers/{id}", customerHandler.DeleteCustomer).Methods("DELETE")
	adminRoutes.HandleFunc("/customers/{id}/restore", customerHandler.RestoreCustomer).Methods("POST")
	adminRoutes.HandleFunc("/customers/{id}/anonymize", customerHandler.AnonymizeCustomer).Methods("POST")
	adminRoutes.HandleFunc("/users", h.ListUsers).Methods("GET")
	adminRoutes.HandleFunc("/users/{id}", h.GetUser).Methods("GET")

	// === Super Admin routes: user management ===
	superAdminRoutes := v1.PathPrefix("").Subrouter()
	superAdminRoutes.Use(middleware.RequireRole(middleware.RoleSuperAdmin))
	superAdminRoutes.HandleFunc("/users", h.CreateUser).Methods("POST")
	superAdminRoutes.HandleFunc("/users/{id}", h.UpdateUser).Methods("PUT")
	superAdminRoutes.HandleFunc("/users/{id}", h.DeactivateUser).Methods("DELETE")

	// API Key protected routes
	apiKeyRouter := router.PathPrefix("/api/v1").Subrouter()
	apiKeyRouter.Use(middleware.APIKeyAuth(db))
	apiKeyRouter.HandleFunc("/customers", customerHandler.ListCustomers).Methods("GET")
}

// HealthCheck returns the API health status
// @Summary Check API Health
// @Description Returns the status of the API
// @Tags health
// @Produce  json
// @Success 200 {object} map[string]string
// @Router /health [get]
func (h *Handler) HealthCheck(w http.ResponseWriter, r *http.Request) {
	respondJSON(w, http.StatusOK, map[string]string{
		"status":  "healthy",
		"service": "go-api",
	})
}

// Login handles user login
func (h *Handler) Login(w http.ResponseWriter, r *http.Request) {
	var req struct {
		Username string `json:"username"`
		Password string `json:"password"`
	}

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	var user models.User
	var passwordHash string
	query := `SELECT id, email, username, password_hash, role FROM users WHERE username = $1 AND is_active = true`
	err := h.DB.QueryRow(query, req.Username).Scan(&user.ID, &user.Email, &user.Username, &passwordHash, &user.Role)
	if err != nil {
		respondError(w, http.StatusUnauthorized, "Invalid credentials")
		return
	}

	if !auth.CheckPasswordHash(req.Password, passwordHash) {
		respondError(w, http.StatusUnauthorized, "Invalid credentials")
		return
	}

	token, err := auth.GenerateJWT(user.ID, user.Username, user.Email, user.Role)
	if err != nil {
		respondError(w, http.StatusInternalServerError, "Failed to generate token")
		return
	}

	respondJSON(w, http.StatusOK, map[string]interface{}{
		"token": token,
		"user":  user,
	})
}

// Register handles user registration
func (h *Handler) Register(w http.ResponseWriter, r *http.Request) {
	var req struct {
		Email    string `json:"email"`
		Username string `json:"username"`
		Password string `json:"password"`
	}

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	passwordHash, err := auth.HashPassword(req.Password)
	if err != nil {
		respondError(w, http.StatusInternalServerError, "Failed to hash password")
		return
	}

	var userID uuid.UUID
	defaultRole := "OPERATOR"
	query := `INSERT INTO users (email, username, password_hash, role) VALUES ($1, $2, $3, $4) RETURNING id`
	err = h.DB.QueryRow(query, req.Email, req.Username, passwordHash, defaultRole).Scan(&userID)
	if err != nil {
		respondError(w, http.StatusConflict, "User already exists")
		return
	}

	token, err := auth.GenerateJWT(userID, req.Username, req.Email, defaultRole)
	if err != nil {
		respondError(w, http.StatusInternalServerError, "Failed to generate token")
		return
	}

	respondJSON(w, http.StatusCreated, map[string]interface{}{
		"token": token,
		"user": map[string]interface{}{
			"id":       userID,
			"email":    req.Email,
			"username": req.Username,
			"role":     defaultRole,
		},
	})
}

// GetCurrentUser returns the current authenticated user
func (h *Handler) GetCurrentUser(w http.ResponseWriter, r *http.Request) {
	claims, ok := r.Context().Value(middleware.UserContextKey).(*auth.JWTClaims)
	if !ok {
		respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	var user models.User
	query := `SELECT id, email, username, role, is_active, created_at, updated_at FROM users WHERE id = $1`
	err := h.DB.QueryRow(query, claims.UserID).Scan(
		&user.ID, &user.Email, &user.Username, &user.Role, &user.IsActive, &user.CreatedAt, &user.UpdatedAt,
	)
	if err != nil {
		respondError(w, http.StatusNotFound, "User not found")
		return
	}

	respondJSON(w, http.StatusOK, user)
}

// CreateUser creates a new user account (SUPER_ADMIN only)
// @Summary Create user
// @Tags users
// @Accept json
// @Produce json
// @Router /api/v1/users [post]
func (h *Handler) CreateUser(w http.ResponseWriter, r *http.Request) {
	var req struct {
		Email        string  `json:"email"`
		Username     string  `json:"username"`
		Password     string  `json:"password"`
		Role         string  `json:"role"`
		SupervisorID *string `json:"supervisor_id,omitempty"`
	}

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	// Validate role
	validRoles := map[string]bool{
		middleware.RoleSuperAdmin: true,
		middleware.RoleAdmin:      true,
		middleware.RoleOperator:   true,
		middleware.RoleViewer:     true,
	}
	if !validRoles[req.Role] {
		respondError(w, http.StatusBadRequest, "Invalid role. Must be: SUPER_ADMIN, ADMIN, OPERATOR, or VIEWER")
		return
	}

	passwordHash, err := auth.HashPassword(req.Password)
	if err != nil {
		respondError(w, http.StatusInternalServerError, "Failed to hash password")
		return
	}

	var userID uuid.UUID
	query := `INSERT INTO users (email, username, password_hash, role, supervisor_id) VALUES ($1, $2, $3, $4, $5) RETURNING id`
	err = h.DB.QueryRow(query, req.Email, req.Username, passwordHash, req.Role, req.SupervisorID).Scan(&userID)
	if err != nil {
		respondError(w, http.StatusConflict, "User already exists or invalid supervisor")
		return
	}

	respondJSON(w, http.StatusCreated, map[string]interface{}{
		"id":       userID,
		"email":    req.Email,
		"username": req.Username,
		"role":     req.Role,
	})
}

// UpdateUser updates a user account (SUPER_ADMIN only)
// @Summary Update user
// @Tags users
// @Accept json
// @Produce json
// @Param id path string true "User ID"
// @Router /api/v1/users/{id} [put]
func (h *Handler) UpdateUser(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	var req struct {
		Email        *string `json:"email,omitempty"`
		Role         *string `json:"role,omitempty"`
		IsActive     *bool   `json:"is_active,omitempty"`
		SupervisorID *string `json:"supervisor_id,omitempty"`
	}

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	// Validate role if provided
	if req.Role != nil {
		validRoles := map[string]bool{
			middleware.RoleSuperAdmin: true,
			middleware.RoleAdmin:      true,
			middleware.RoleOperator:   true,
			middleware.RoleViewer:     true,
		}
		if !validRoles[*req.Role] {
			respondError(w, http.StatusBadRequest, "Invalid role")
			return
		}
	}

	// Build dynamic update query
	setClauses := []string{"updated_at = NOW()"}
	args := []interface{}{}
	argIdx := 1

	if req.Email != nil {
		setClauses = append(setClauses, fmt.Sprintf("email = $%d", argIdx))
		args = append(args, *req.Email)
		argIdx++
	}
	if req.Role != nil {
		setClauses = append(setClauses, fmt.Sprintf("role = $%d", argIdx))
		args = append(args, *req.Role)
		argIdx++
	}
	if req.IsActive != nil {
		setClauses = append(setClauses, fmt.Sprintf("is_active = $%d", argIdx))
		args = append(args, *req.IsActive)
		argIdx++
	}
	if req.SupervisorID != nil {
		setClauses = append(setClauses, fmt.Sprintf("supervisor_id = $%d", argIdx))
		args = append(args, *req.SupervisorID)
		argIdx++
	}

	args = append(args, id)
	query := fmt.Sprintf("UPDATE users SET %s WHERE id = $%d", strings.Join(setClauses, ", "), argIdx)

	result, err := h.DB.Exec(query, args...)
	if err != nil {
		respondError(w, http.StatusInternalServerError, "Failed to update user")
		return
	}

	rowsAffected, _ := result.RowsAffected()
	if rowsAffected == 0 {
		respondError(w, http.StatusNotFound, "User not found")
		return
	}

	respondJSON(w, http.StatusOK, map[string]string{"message": "User updated successfully"})
}

// DeactivateUser soft-disables a user account (SUPER_ADMIN only)
// @Summary Deactivate user
// @Tags users
// @Produce json
// @Param id path string true "User ID"
// @Router /api/v1/users/{id} [delete]
func (h *Handler) DeactivateUser(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	// Prevent self-deactivation
	claims, ok := r.Context().Value(middleware.UserContextKey).(*auth.JWTClaims)
	if ok && claims.UserID == id {
		respondError(w, http.StatusBadRequest, "Cannot deactivate your own account")
		return
	}

	query := `UPDATE users SET is_active = false, updated_at = NOW() WHERE id = $1`
	result, err := h.DB.Exec(query, id)
	if err != nil {
		respondError(w, http.StatusInternalServerError, "Failed to deactivate user")
		return
	}

	rowsAffected, _ := result.RowsAffected()
	if rowsAffected == 0 {
		respondError(w, http.StatusNotFound, "User not found")
		return
	}

	respondJSON(w, http.StatusOK, map[string]string{"message": "User deactivated successfully"})
}

// OAuthGoogle initiates Google OAuth flow
func (h *Handler) OAuthGoogle(w http.ResponseWriter, r *http.Request) {
	// This is a placeholder - implement actual OAuth flow based on your needs
	respondJSON(w, http.StatusNotImplemented, map[string]string{
		"message": "OAuth implementation depends on your provider configuration",
		"note":    "Configure OAUTH_CLIENT_ID, OAUTH_CLIENT_SECRET, and OAUTH_REDIRECT_URL in .env",
	})
}

// OAuthCallback handles OAuth callback
func (h *Handler) OAuthCallback(w http.ResponseWriter, r *http.Request) {
	// This is a placeholder - implement actual OAuth callback based on your needs
	respondJSON(w, http.StatusNotImplemented, map[string]string{
		"message": "OAuth callback implementation depends on your provider configuration",
	})
}

// ListUsers returns all users (staff management)
// @Summary List users
// @Description Returns all registered users for staff management
// @Tags users
// @Produce json
// @Success 200 {array} models.User
// @Router /api/v1/users [get]
func (h *Handler) ListUsers(w http.ResponseWriter, r *http.Request) {
	rows, err := h.DB.Query(`
		SELECT id, email, username, role, is_active, created_at, updated_at
		FROM users
		ORDER BY created_at DESC
	`)
	if err != nil {
		respondError(w, http.StatusInternalServerError, "Failed to fetch users")
		return
	}
	defer rows.Close()

	var users []models.User
	for rows.Next() {
		var user models.User
		err := rows.Scan(&user.ID, &user.Email, &user.Username, &user.Role, &user.IsActive, &user.CreatedAt, &user.UpdatedAt)
		if err != nil {
			continue
		}
		users = append(users, user)
	}

	if users == nil {
		users = []models.User{}
	}

	respondJSON(w, http.StatusOK, users)
}

// GetUser returns a single user by ID
// @Summary Get user
// @Description Returns a single user by ID
// @Tags users
// @Produce json
// @Param id path string true "User ID"
// @Success 200 {object} models.User
// @Router /api/v1/users/{id} [get]
func (h *Handler) GetUser(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	var user models.User
	query := `SELECT id, email, username, role, is_active, created_at, updated_at FROM users WHERE id = $1`
	err := h.DB.QueryRow(query, id).Scan(
		&user.ID, &user.Email, &user.Username, &user.Role, &user.IsActive, &user.CreatedAt, &user.UpdatedAt,
	)
	if err != nil {
		respondError(w, http.StatusNotFound, "User not found")
		return
	}

	respondJSON(w, http.StatusOK, user)
}

// Helper functions
func respondJSON(w http.ResponseWriter, status int, data interface{}) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	json.NewEncoder(w).Encode(data)
}

func respondError(w http.ResponseWriter, status int, message string) {
	respondJSON(w, status, map[string]string{"error": message})
}
