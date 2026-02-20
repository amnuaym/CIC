package middleware

import (
	"net/http"

	"github.com/amnuaym/cic/go/internal/auth"
)

// Role constants for CIC RBAC
const (
	RoleSuperAdmin = "SUPER_ADMIN"
	RoleAdmin      = "ADMIN"
	RoleOperator   = "OPERATOR"
	RoleViewer     = "VIEWER"
)

// RequireRole returns middleware that restricts access to users with one of the allowed roles.
// Must be applied AFTER JWTAuth middleware so claims are available in context.
func RequireRole(allowedRoles ...string) func(http.Handler) http.Handler {
	roleSet := make(map[string]bool, len(allowedRoles))
	for _, r := range allowedRoles {
		roleSet[r] = true
	}

	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			claims, ok := r.Context().Value(UserContextKey).(*auth.JWTClaims)
			if !ok || claims == nil {
				http.Error(w, "Unauthorized", http.StatusUnauthorized)
				return
			}

			if !roleSet[claims.Role] {
				http.Error(w, "Forbidden: insufficient permissions", http.StatusForbidden)
				return
			}

			next.ServeHTTP(w, r)
		})
	}
}
