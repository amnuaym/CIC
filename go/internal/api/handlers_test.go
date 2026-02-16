package api

import (
	"bytes"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestHealthCheck(t *testing.T) {
	handler := &Handler{}
	req := httptest.NewRequest("GET", "/health", nil)
	w := httptest.NewRecorder()

	handler.HealthCheck(w, req)

	resp := w.Result()
	if resp.StatusCode != http.StatusOK {
		t.Fatalf("Expected status 200, got %d", resp.StatusCode)
	}

	var result map[string]string
	json.NewDecoder(resp.Body).Decode(&result)

	if result["status"] != "healthy" {
		t.Fatalf("Expected status 'healthy', got '%s'", result["status"])
	}

	if result["service"] != "go-api" {
		t.Fatalf("Expected service 'go-api', got '%s'", result["service"])
	}
}

func TestRespondJSON(t *testing.T) {
	w := httptest.NewRecorder()
	data := map[string]string{"key": "value"}

	respondJSON(w, http.StatusOK, data)

	resp := w.Result()
	if resp.StatusCode != http.StatusOK {
		t.Fatalf("Expected status 200, got %d", resp.StatusCode)
	}

	contentType := resp.Header.Get("Content-Type")
	if contentType != "application/json" {
		t.Fatalf("Expected Content-Type 'application/json', got '%s'", contentType)
	}

	var result map[string]string
	json.NewDecoder(resp.Body).Decode(&result)

	if result["key"] != "value" {
		t.Fatalf("Expected key 'value', got '%s'", result["key"])
	}
}

func TestRespondError(t *testing.T) {
	w := httptest.NewRecorder()
	message := "Test error message"

	respondError(w, http.StatusBadRequest, message)

	resp := w.Result()
	if resp.StatusCode != http.StatusBadRequest {
		t.Fatalf("Expected status 400, got %d", resp.StatusCode)
	}

	var result map[string]string
	json.NewDecoder(resp.Body).Decode(&result)

	if result["error"] != message {
		t.Fatalf("Expected error '%s', got '%s'", message, result["error"])
	}
}

func TestLoginInvalidJSON(t *testing.T) {
	handler := &Handler{}
	req := httptest.NewRequest("POST", "/api/auth/login", bytes.NewBufferString("invalid json"))
	w := httptest.NewRecorder()

	handler.Login(w, req)

	resp := w.Result()
	if resp.StatusCode != http.StatusBadRequest {
		t.Fatalf("Expected status 400, got %d", resp.StatusCode)
	}
}

func TestRegisterInvalidJSON(t *testing.T) {
	handler := &Handler{}
	req := httptest.NewRequest("POST", "/api/auth/register", bytes.NewBufferString("invalid json"))
	w := httptest.NewRecorder()

	handler.Register(w, req)

	resp := w.Result()
	if resp.StatusCode != http.StatusBadRequest {
		t.Fatalf("Expected status 400, got %d", resp.StatusCode)
	}
}
