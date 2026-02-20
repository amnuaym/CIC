package middleware

import (
	"context"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/amnuaym/cic/go/internal/auth"
)

func TestRequireRole_AllowsMatchingRole(t *testing.T) {
	handler := RequireRole(RoleSuperAdmin, RoleAdmin)(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
	}))

	req := httptest.NewRequest("GET", "/", nil)
	claims := &auth.JWTClaims{Role: RoleAdmin}
	ctx := context.WithValue(req.Context(), UserContextKey, claims)
	req = req.WithContext(ctx)

	rr := httptest.NewRecorder()
	handler.ServeHTTP(rr, req)

	if rr.Code != http.StatusOK {
		t.Errorf("expected 200, got %d", rr.Code)
	}
}

func TestRequireRole_RejectsWrongRole(t *testing.T) {
	handler := RequireRole(RoleSuperAdmin)(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
	}))

	req := httptest.NewRequest("GET", "/", nil)
	claims := &auth.JWTClaims{Role: RoleOperator}
	ctx := context.WithValue(req.Context(), UserContextKey, claims)
	req = req.WithContext(ctx)

	rr := httptest.NewRecorder()
	handler.ServeHTTP(rr, req)

	if rr.Code != http.StatusForbidden {
		t.Errorf("expected 403, got %d", rr.Code)
	}
}

func TestRequireRole_RejectsNoClaims(t *testing.T) {
	handler := RequireRole(RoleSuperAdmin)(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
	}))

	req := httptest.NewRequest("GET", "/", nil)
	rr := httptest.NewRecorder()
	handler.ServeHTTP(rr, req)

	if rr.Code != http.StatusUnauthorized {
		t.Errorf("expected 401, got %d", rr.Code)
	}
}

func TestRequireRole_ViewerCannotAccessAdminRoute(t *testing.T) {
	handler := RequireRole(RoleSuperAdmin, RoleAdmin)(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
	}))

	req := httptest.NewRequest("DELETE", "/customers/123", nil)
	claims := &auth.JWTClaims{Role: RoleViewer}
	ctx := context.WithValue(req.Context(), UserContextKey, claims)
	req = req.WithContext(ctx)

	rr := httptest.NewRecorder()
	handler.ServeHTTP(rr, req)

	if rr.Code != http.StatusForbidden {
		t.Errorf("expected 403 for VIEWER on admin route, got %d", rr.Code)
	}
}
