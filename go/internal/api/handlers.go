package api

import (
	"database/sql"
	"encoding/json"
	"net/http"

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

	// CIC Routes (v1)
	v1 := router.PathPrefix("/api/v1").Subrouter()
	v1.Use(middleware.JWTAuth)

	// Customers
	v1.HandleFunc("/customers", customerHandler.ListCustomers).Methods("GET")
	v1.HandleFunc("/customers", customerHandler.CreateCustomer).Methods("POST")
	v1.HandleFunc("/customers/search", customerHandler.SearchCustomers).Methods("GET")
	v1.HandleFunc("/customers/{id}", customerHandler.GetCustomer).Methods("GET")
	v1.HandleFunc("/customers/{id}", customerHandler.UpdateCustomer).Methods("PATCH", "PUT")
	v1.HandleFunc("/customers/{id}", customerHandler.DeleteCustomer).Methods("DELETE")
	v1.HandleFunc("/customers/{id}/restore", customerHandler.RestoreCustomer).Methods("POST")
	v1.HandleFunc("/customers/{id}/anonymize", customerHandler.AnonymizeCustomer).Methods("POST")

	// Sub-resources: Addresses
	v1.HandleFunc("/customers/{id}/addresses", customerHandler.AddAddress).Methods("POST")
	v1.HandleFunc("/customers/{id}/addresses", customerHandler.GetAddresses).Methods("GET")

	// Sub-resources: Identities
	v1.HandleFunc("/customers/{id}/identities", customerHandler.AddIdentity).Methods("POST")
	v1.HandleFunc("/customers/{id}/identities", customerHandler.GetIdentities).Methods("GET")

	// Sub-resources: Relationships
	v1.HandleFunc("/customers/{id}/relationships", customerHandler.AddRelationship).Methods("POST")
	v1.HandleFunc("/customers/{id}/relationships", customerHandler.GetRelationships).Methods("GET")

	// Sub-resources: Consents
	v1.HandleFunc("/customers/{id}/consents", customerHandler.ManageConsent).Methods("POST")
	v1.HandleFunc("/customers/{id}/consents", customerHandler.GetConsents).Methods("GET")

	// Top-level: Audit Logs (read-only)
	v1.HandleFunc("/audit-logs", auditLogHandler.ListAuditLogs).Methods("GET")
	v1.HandleFunc("/audit-logs/{id}", auditLogHandler.GetAuditLog).Methods("GET")

	// Top-level: Consents (cross-customer)
	v1.HandleFunc("/consents", consentHandler.ListConsents).Methods("GET")
	v1.HandleFunc("/consents/{id}", consentHandler.GetConsent).Methods("GET")

	// Top-level: Users (staff management)
	v1.HandleFunc("/users", h.ListUsers).Methods("GET")
	v1.HandleFunc("/users/{id}", h.GetUser).Methods("GET")

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
	defaultRole := "user"
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
	query := `SELECT id, email, username, is_active, created_at, updated_at FROM users WHERE id = $1`
	err := h.DB.QueryRow(query, claims.UserID).Scan(
		&user.ID, &user.Email, &user.Username, &user.IsActive, &user.CreatedAt, &user.UpdatedAt,
	)
	if err != nil {
		respondError(w, http.StatusNotFound, "User not found")
		return
	}

	respondJSON(w, http.StatusOK, user)
}

// ListPosts returns all posts
func (h *Handler) ListPosts(w http.ResponseWriter, r *http.Request) {
	rows, err := h.DB.Query(`
		SELECT id, user_id, title, content, status, created_at, updated_at 
		FROM posts 
		ORDER BY created_at DESC
	`)
	if err != nil {
		respondError(w, http.StatusInternalServerError, "Failed to fetch posts")
		return
	}
	defer rows.Close()

	var posts []models.Post
	for rows.Next() {
		var post models.Post
		err := rows.Scan(&post.ID, &post.UserID, &post.Title, &post.Content, &post.Status, &post.CreatedAt, &post.UpdatedAt)
		if err != nil {
			continue
		}
		posts = append(posts, post)
	}

	respondJSON(w, http.StatusOK, posts)
}

// CreatePost creates a new post
func (h *Handler) CreatePost(w http.ResponseWriter, r *http.Request) {
	claims, ok := r.Context().Value(middleware.UserContextKey).(*auth.JWTClaims)
	if !ok {
		respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	var req struct {
		Title   string  `json:"title"`
		Content *string `json:"content"`
		Status  string  `json:"status"`
	}

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	var postID uuid.UUID
	query := `INSERT INTO posts (user_id, title, content, status) VALUES ($1, $2, $3, $4) RETURNING id`
	err := h.DB.QueryRow(query, claims.UserID, req.Title, req.Content, req.Status).Scan(&postID)
	if err != nil {
		respondError(w, http.StatusInternalServerError, "Failed to create post")
		return
	}

	respondJSON(w, http.StatusCreated, map[string]interface{}{"id": postID})
}

// GetPost returns a specific post
func (h *Handler) GetPost(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	var post models.Post
	query := `SELECT id, user_id, title, content, status, created_at, updated_at FROM posts WHERE id = $1`
	err := h.DB.QueryRow(query, id).Scan(
		&post.ID, &post.UserID, &post.Title, &post.Content, &post.Status, &post.CreatedAt, &post.UpdatedAt,
	)
	if err != nil {
		respondError(w, http.StatusNotFound, "Post not found")
		return
	}

	respondJSON(w, http.StatusOK, post)
}

// UpdatePost updates a post
func (h *Handler) UpdatePost(w http.ResponseWriter, r *http.Request) {
	claims, ok := r.Context().Value(middleware.UserContextKey).(*auth.JWTClaims)
	if !ok {
		respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	vars := mux.Vars(r)
	id := vars["id"]

	var req struct {
		Title   string  `json:"title"`
		Content *string `json:"content"`
		Status  string  `json:"status"`
	}

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	query := `UPDATE posts SET title = $1, content = $2, status = $3, updated_at = NOW() WHERE id = $4 AND user_id = $5`
	result, err := h.DB.Exec(query, req.Title, req.Content, req.Status, id, claims.UserID)
	if err != nil {
		respondError(w, http.StatusInternalServerError, "Failed to update post")
		return
	}

	rowsAffected, _ := result.RowsAffected()
	if rowsAffected == 0 {
		respondError(w, http.StatusNotFound, "Post not found or unauthorized")
		return
	}

	respondJSON(w, http.StatusOK, map[string]string{"message": "Post updated successfully"})
}

// DeletePost deletes a post
func (h *Handler) DeletePost(w http.ResponseWriter, r *http.Request) {
	claims, ok := r.Context().Value(middleware.UserContextKey).(*auth.JWTClaims)
	if !ok {
		respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	vars := mux.Vars(r)
	id := vars["id"]

	query := `DELETE FROM posts WHERE id = $1 AND user_id = $2`
	result, err := h.DB.Exec(query, id, claims.UserID)
	if err != nil {
		respondError(w, http.StatusInternalServerError, "Failed to delete post")
		return
	}

	rowsAffected, _ := result.RowsAffected()
	if rowsAffected == 0 {
		respondError(w, http.StatusNotFound, "Post not found or unauthorized")
		return
	}

	respondJSON(w, http.StatusOK, map[string]string{"message": "Post deleted successfully"})
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
