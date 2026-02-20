---
description: How to update API endpoints, documentation, and tests
---

# API Update Workflow

Follow this workflow when adding, modifying, or deleting API endpoints.

## 1. Code Implementation

- [ ] Update **Service Interface** (`go/internal/core/ports/services.go`)
- [ ] Implement method in **Service** (`go/internal/core/service/`)
- [ ] Implement method in **Handler** (`go/internal/adapter/handler/`)
  - [ ] Add Swagger comments (`// @Summary`, `// @Router`, etc.)
- [ ] Register route in **Router** (`go/internal/api/handlers.go`)

## 2. Documentation Update

- [ ] Run `swag init` using Docker (if local `swag` is missing):

  ```bash
  # From project root
  docker run --rm -v ${PWD}/go:/code -w /code ghcr.io/swaggo/swag:latest init -g main.go -o docs
  ```

  _Note: Ensure `go/docs` folder exists and is writable._

- [ ] Verify `go/docs/swagger.json` and `go/docs/docs.go` are updated.
- [ ] Update `documentation/data_dictionary.md` if schema changed

## 3. Testing

- [ ] Update **Unit Tests** (`go/internal/adapter/handler/*_test.go`)
  - [ ] Add test cases for new/modified endpoints
- [ ] Update **E2E Tests** (`scripts/test_api_access.ps1`)
  - [ ] Verify the endpoint is accessible and behaves as expected

## 4. Build & Verify

- [ ] Rebuild API container to apply changes
  ```bash
  docker-compose up -d --build cic-api
  ```
- [ ] Verify Swagger UI (usually at `/swagger/index.html` or similar)
- [ ] Test with Frontend (React Admin)

## 5. Commit

- [ ] Commit all changes including generated docs
