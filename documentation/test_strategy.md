# Test Strategy

This document outlines the testing strategy for the Customer Information Center (CIC) project, covering Unit Tests (Backend) and End-to-End (E2E) Tests.

## 1. Unit Tests (Backend)

**Scope:** Business logic, service layer, and utility functions.
**Tooling:** Standard Go `testing` package.
**Location:** Co-located with the source code (e.g., `service_test.go` next to `service.go`).

### Philosophy

- **Fast & Isolated**: Unit tests should run quickly and mock external dependencies (Database, API calls).
- **Core Logic**: Focus on testing domain rules (e.g., Thai ID validation, Customer types).
- **Coverage**: Aim for high coverage in `core/service` and `utils` packages.

### How to Run

Run all unit tests in the project:

```bash
cd go
go test ./... -v
```

Run a specific package (e.g., Validation utils):

```bash
go test ./internal/utils/validation -v
```

### Writing a New Unit Test

Create a `*_test.go` file next to your code.

```go
func TestValidateThaiID(t *testing.T) {
    err := ValidateThaiID("1234567890121")
    if err != nil {
        t.Errorf("Expected valid ID, got error: %v", err)
    }
}
```

---

## 2. End-to-End (E2E) Tests

**Scope:** Full system verification (API -> Database -> API).
**Tooling:** PowerShell Scripts + `curl` (or `Invoke-RestMethod`).
**Location:** `/scripts` folder.

### Philosophy

- **Black Box**: Implementation details don't matter; input/output does.
- **User Journey**: Tests usually follow a scenario (e.g., Create -> Link -> Anonymize).
- **Real Dependencies**: Runs against the actual running Docker containers (`cic-api`, `postgres`).

### How to Run

**Prerequisites:** Ensure the system is running (`docker-compose up -d`).

1. **Full User Journey:**
   Verifies the complete lifecycle of a customer.

   ```powershell
   powershell -File scripts/test_journey.ps1
   ```

2. **Specific Feature Tests:**
   Verifies specific complex logic like Validation.
   ```powershell
   powershell -File scripts/test_thai_id_validation.ps1
   ```

### Writing a New E2E Test

Create a `.ps1` script in `scripts/`. Use `Invoke-RestMethod` to call the API.

```powershell
$BaseUrl = "http://localhost/api/v1"
try {
    $res = Invoke-RestMethod -Method Get -Uri "$BaseUrl/health"
    if ($res.status -eq "healthy") { Write-Host "PASS" }
} catch {
    Write-Host "FAIL"
}
```

---

## 3. CI/CD Integration (Future)

- **Unit Tests**: Run on every Pull Request.
- **E2E Tests**: Run on deployment to Staging environment.
