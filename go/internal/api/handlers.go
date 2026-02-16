package api

import (
	"database/sql"
	"encoding/json"
	"net/http"

	"github.com/amnuaym/be-template/go/internal/auth"
	"github.com/amnuaym/be-template/go/internal/middleware"
	"github.com/amnuaym/be-template/go/internal/models"
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
	protected.HandleFunc("/posts", h.ListPosts).Methods("GET")
	protected.HandleFunc("/posts", h.CreatePost).Methods("POST")
	protected.HandleFunc("/posts/{id}", h.GetPost).Methods("GET")
	protected.HandleFunc("/posts/{id}", h.UpdatePost).Methods("PUT")
	protected.HandleFunc("/posts/{id}", h.DeletePost).Methods("DELETE")

	// API Key protected routes
	apiKeyRouter := router.PathPrefix("/api/v1").Subrouter()
	apiKeyRouter.Use(middleware.APIKeyAuth(db))
	
	apiKeyRouter.HandleFunc("/posts", h.ListPosts).Methods("GET")
}

// HealthCheck returns the API health status
func (h *Handler) HealthCheck(w http.ResponseWriter, r *http.Request) {
	respondJSON(w, http.StatusOK, map[string]string{
		"status": "healthy",
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
	query := `SELECT id, email, username, password_hash FROM users WHERE username = $1 AND is_active = true`
	err := h.DB.QueryRow(query, req.Username).Scan(&user.ID, &user.Email, &user.Username, &passwordHash)
	if err != nil {
		respondError(w, http.StatusUnauthorized, "Invalid credentials")
		return
	}

	if !auth.CheckPasswordHash(req.Password, passwordHash) {
		respondError(w, http.StatusUnauthorized, "Invalid credentials")
		return
	}

	token, err := auth.GenerateJWT(user.ID, user.Username, user.Email)
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
	query := `INSERT INTO users (email, username, password_hash) VALUES ($1, $2, $3) RETURNING id`
	err = h.DB.QueryRow(query, req.Email, req.Username, passwordHash).Scan(&userID)
	if err != nil {
		respondError(w, http.StatusConflict, "User already exists")
		return
	}

	token, err := auth.GenerateJWT(userID, req.Username, req.Email)
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

// Helper functions
func respondJSON(w http.ResponseWriter, status int, data interface{}) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	json.NewEncoder(w).Encode(data)
}

func respondError(w http.ResponseWriter, status int, message string) {
	respondJSON(w, status, map[string]string{"error": message})
}
