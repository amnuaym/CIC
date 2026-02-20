package auth

import (
	"testing"

	"github.com/google/uuid"
)

func TestHashPassword(t *testing.T) {
	password := "test_password_123"
	hash, err := HashPassword(password)
	if err != nil {
		t.Fatalf("HashPassword failed: %v", err)
	}

	if hash == "" {
		t.Fatal("Hash should not be empty")
	}

	if hash == password {
		t.Fatal("Hash should not equal the original password")
	}
}

func TestCheckPasswordHash(t *testing.T) {
	password := "test_password_123"
	hash, err := HashPassword(password)
	if err != nil {
		t.Fatalf("HashPassword failed: %v", err)
	}

	if !CheckPasswordHash(password, hash) {
		t.Fatal("CheckPasswordHash should return true for correct password")
	}

	if CheckPasswordHash("wrong_password", hash) {
		t.Fatal("CheckPasswordHash should return false for incorrect password")
	}
}

func TestGenerateJWT(t *testing.T) {
	userID := uuid.New()
	username := "testuser"
	email := "test@example.com"

	token, err := GenerateJWT(userID, username, email, "user")
	if err != nil {
		t.Fatalf("GenerateJWT failed: %v", err)
	}

	if token == "" {
		t.Fatal("Token should not be empty")
	}
}

func TestValidateJWT(t *testing.T) {
	userID := uuid.New()
	username := "testuser"
	email := "test@example.com"

	token, err := GenerateJWT(userID, username, email, "user")
	if err != nil {
		t.Fatalf("GenerateJWT failed: %v", err)
	}

	claims, err := ValidateJWT(token)
	if err != nil {
		t.Fatalf("ValidateJWT failed: %v", err)
	}

	if claims.UserID != userID.String() {
		t.Fatalf("Expected UserID %s, got %s", userID.String(), claims.UserID)
	}

	if claims.Username != username {
		t.Fatalf("Expected Username %s, got %s", username, claims.Username)
	}

	if claims.Email != email {
		t.Fatalf("Expected Email %s, got %s", email, claims.Email)
	}
}

func TestValidateJWTInvalidToken(t *testing.T) {
	_, err := ValidateJWT("invalid_token")
	if err == nil {
		t.Fatal("ValidateJWT should fail for invalid token")
	}
}

func TestHashAPIKey(t *testing.T) {
	apiKey := "test-api-key-123"
	hash1 := HashAPIKey(apiKey)
	hash2 := HashAPIKey(apiKey)

	if hash1 != hash2 {
		t.Fatal("HashAPIKey should produce consistent hashes")
	}

	if hash1 == apiKey {
		t.Fatal("Hash should not equal the original API key")
	}
}

func TestGenerateAPIKey(t *testing.T) {
	key1 := GenerateAPIKey()
	key2 := GenerateAPIKey()

	if key1 == "" || key2 == "" {
		t.Fatal("GenerateAPIKey should not return empty strings")
	}

	if key1 == key2 {
		t.Fatal("GenerateAPIKey should generate unique keys")
	}
}
