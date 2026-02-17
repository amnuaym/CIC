# Customer Information Center (CIC) Implementation Plan

## Goal Description
Implement a centralized Customer Information Center (CIC) to serve as a Single Source of Truth for all customer data (Personal and Juristic). The system will support secure access via mTLS (internal) and OAuth 2.0 (external/staff), manage customer profiles, relationships, and ensure PDPA compliance.

## User Review Required
> [!IMPORTANT]
> - Confirm the use of Go (Hexagonal Architecture) and React Admin as the primary tech stack.
> - Review the data retention and anonymization policies for PDPA compliance.
> - Confirm the rate limiting strategy (20 TPS for all traffic).

## Proposed Changes

### Backend (Go)
The backend will be built using Go with a Hexagonal Architecture pattern.
- **Core Domain**: Define entities `Customer`, `Address`, `Identity`, `BusinessProfile`, `Relationship`, `Consent`.
- **Ports & Adapters**: 
    - **Handlers**: HTTP REST handlers (Gin/Echo/Standard Lib).
    - **Repositories**: PostgreSQL implementation using standard `database/sql` or `pgx`.
- **Services**:
    - `CustomerService`: CRUD, Search, Logic for Types (Personal/Juristic).
    - `SecurityService`: mTLS validation, JWT verification.
    - `AuditService`: Async logging of changes.
    - `PDPAService`: Consent management, Anonymization logic (Soft delete -> Hard delete after retention).

### Database (PostgreSQL)
- **Schema Design**:
    - `customers`: ID, Type, Basic Info.
    - `customer_attributes`: Key-value pairs or specific tables for extended attributes (No JSONB).
    - `addresses`: Linked to Customer, with specific columns for components (No JSONB).
    - `identities`: Linked to Customer (Type, Number, Country).
    - `relationships`: Links two Customers with a Role.
    - `consents`: Topics, Versions, Status.
    - `audit_logs`: Immutable log of changes.

### Configuration
    - Connect to existing local PostgreSQL (`localhost:5432`).
    - Database Name: `CIC`.
    - Credentials configured via Environment Variables.

### PDPA Strategy
- **Data Retention**:
    - Inactive customers marked as "Soft Deleted".
    - Hard delete/Purge after legal retention period (e.g., 10 years).
- **Anonymization**:
    - PII fields (Name, ID Card) masked (e.g., `Deleted_User_123`).
    - Foreign keys preserved to maintain financial transaction integrity.

### Frontend (React Admin)
- **Dashboard**: Overview of key metrics.
- **Customer Resource**:
    - List View: Searchable/Filterable grid.
    - Create/Edit View: Tabbed interface for Details, Addresses, IDs, Relationships, Consents.
    - Show View: Read-only profile view involving sub-resources.
- **Relationship Resource**: Diagram or List view for managing connections.

### Infrastructure
- **Docker Compose**: Setup containers for:
    - `cic-api` (Go) - Configured via Env Vars (DB_HOST, DB_USER, etc.)
    - `keycloak` (Identity Provider)
    - `kong` or `nginx` (API Gateway)
    - `react-admin` (Frontend dev server)

## Verification Plan

### Automated Tests
- **Unit Tests**: Cover core business logic for Customer creation/updates and validation rules.
- **Integration Tests**: Test API endpoints with a test database.

### Manual Verification
- **Flow 1**: Create a Personal Customer via API and verify in Dashboard.
- **Flow 2**: Create a Juristic Customer and link a Person as "Director".
- **Flow 3**: Test mTLS connection from a mock internal service.
- **Flow 4**: Verify Audit Logs are generated for updates.
- **Flow 5**: Test "Right to be Forgotten" - verify anonymization while keeping financial aggregations.
