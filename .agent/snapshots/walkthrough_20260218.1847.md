# Customer Information Center (CIC) Walkthrough

This walkthrough guides you through the setup, verification, and usage of the CIC system.

## 1. Prerequisites

- **Docker & Docker Compose**: Ensure Docker Desktop is running.
- **Go 1.21+**: Installed locally (for running tests or local dev).
- **PostgreSQL**: Local instance running on port `5432`.
  - Database: `CIC`
  - User/Pass: `admin`/`admin123` (or matches .env)

## 2. Infrastructure Setup

The system consists of:

- **Go API**: Backend service (Port 8080).
- **React Admin**: Frontend service (Port 3000 -> 80).
- **Keycloak**: Identity Provider (Port 8081).
- **Nginx**: API Gateway (Port 80).

### Start Services

Run the following command in the project root:

```bash
docker-compose up --build -d
```

Verify services are running:

```bash
docker-compose ps
```

You should see `cic-api`, `cic-react-admin`, `cic-keycloak`, and `cic-nginx` as `Up`.

### Database Migrations

Run the migration scripts to initialize the database schema:

```bash
cd go/migrations
# Use your preferred migration tool (e.g., golang-migrate) or execute SQL manually
# Example using psql:
psql -h localhost -U admin -d CIC -f 000001_init_schema.up.sql
```

### User Management (Internal Staff)

The system uses a dedicated `users` table for **Internal Staff** to log in to the React Admin dashboard and access the API.

> **Important**: This is distinct from `customers` (the people whose data is stored), who do not have login access to this system to prevent unauthorized data exposure.

**Default Credentials:**

| Role               | Username         | Password            | Purpose                        |
| :----------------- | :--------------- | :------------------ | :----------------------------- |
| **Super Admin**    | `superadmin`     | `Super!Secret.2024` | Full System Access             |
| **Contact Admin**  | `contact_admin`  | `Contact#Admin.99`  | Manage Addresses/Relationships |
| **Consent Admin**  | `consent_admin`  | `ConsentAdmin.88!`  | Manage PDPA/Consents           |
| **Identity Admin** | `identity_admin` | `Identity$Admin.88` | Manage Passports/IDs           |

**Seeding Users:**
If these users do not exist, run the seeding script:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/seed_users.ps1
```

## 3. Manual Verification

### Flow 1: Access Frontend (React Admin)

1. Open your browser to `http://localhost`.
2. You should see the React Admin dashboard.
3. Login (if authentication is enabled, or use the default provider if mocked).

### Flow 2: Customer Management

1. **Navigate to Customers**: Click on "Customers" in the sidebar.
2. **Create Customer**:
   - Click "Create".
   - Select Type: "Personal".
   - Fill in "John", "Doe".
   - Click "Save".
3. **Verify List**: The new customer should appear in the list.
4. **Edit Customer**:
   - Click on the customer.
   - Go to "Addresses" tab.
   - (Note: Adding addresses currently requires API calls or implementing the sub-resource UI fully).

### Flow 3: Anonymization (Right to be Forgotten)

1. Open a Customer detail view.
2. Click the "Anonymize (PDPA)" button (red trash icon).
3. Confirm the action.
4. The customer name should change to `Deleted_User_...` and status to `Blacklisted`.
5. Check Database `audit_logs` table to see the "ANONYMIZE" action logged.

## 4. API Verification (Direct Protocol)

You can use `curl` or Postman to test the implementation directly.

**Health Check:**

```bash
curl http://localhost/health
```

**Create Customer:**

```bash
curl -X POST http://localhost/api/v1/customers \
  -H "Content-Type: application/json" \
  -d '{"type": "PERSONAL", "first_name": "Jane", "last_name": "Doe", "status": "ACTIVE"}'
```

**Anonymize Customer:**

```bash
curl -X POST http://localhost/api/v1/customers/{ID}/anonymize
```

**Manage Consent:**

```bash
curl -X POST http://localhost/api/v1/customers/{ID}/consents \
  -H "Content-Type: application/json" \
  -d '{"topic": "Marketing", "version": "1.0", "is_granted": true}'
```

**Add Relationship:**

```bash
curl -X POST http://localhost/api/v1/customers/{ID}/relationships \
  -H "Content-Type: application/json" \
  -d '{"to_customer_id": "{ANOTHER_ID}", "role": "Director"}'
```

## 5. Development Notes

- **Backend**: Located in `go/`. Uses Hexagonal Architecture.
- **Frontend**: Located in `react-admin/`. Uses Vite + React Admin.
- **Config**: Environment variables in `docker-compose.yml` and `.env` files.

> [!NOTE]
> Ensure your local PostgreSQL is accessible from Docker containers via `host.docker.internal`.

## 6. API Documentation

The API documentation is now available via Swagger UI.

- **URL**: [http://localhost/swagger/index.html](http://localhost/swagger/index.html)
- **Features**:
  - Interactive API testing ("Try it out").
  - Detailed request/response schemas.
  - Authentication status (currently Public/No Auth for development).

## 7. User Journey Guide

For a complete step-by-step guide on testing the full customer lifecycle (Onboarding -> Linking -> Anonymization), please refer to:
👉 **[User Journey Guide](user_journey.md)**

## 8. Data Dictionary

For a detailed reference of the database schema, tables, and columns, please refer to:
👉 **[Data Dictionary](../documentation/data_dictionary.md)**

## 9. Test Strategy

For information on how to run Unit Tests (Go) and E2E Tests (PowerShell), please refer to:
👉 **[Test Strategy](../documentation/test_strategy.md)**
