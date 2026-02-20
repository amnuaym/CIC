# Data Dictionary

## Overview

**Database System**: PostgreSQL
**Schema Version**: 1.0

---

## Tables

### 1. `customers`

Stores the core profile information for both Personal and Juristic customers.

| Column Name             | Data Type                | Constraints                       | Description                                                                    |
| :---------------------- | :----------------------- | :-------------------------------- | :----------------------------------------------------------------------------- |
| `id`                    | UUID                     | PK, Default: `uuid_generate_v4()` | Unique identifier for the customer.                                            |
| `type`                  | ENUM                     | NOT NULL                          | Customer type: `PERSONAL` or `JURISTIC`.                                       |
| `first_name`            | VARCHAR(255)             |                                   | First name (Personal only).                                                    |
| `last_name`             | VARCHAR(255)             |                                   | Last name (Personal only).                                                     |
| `title`                 | VARCHAR(50)              |                                   | Prefix/Title (e.g., Mr., Mrs.) (Personal only).                                |
| `date_of_birth`         | DATE                     |                                   | Date of birth (Personal only).                                                 |
| `nationality`           | VARCHAR(50)              |                                   | Nationality (Personal only).                                                   |
| `company_name`          | VARCHAR(255)             |                                   | Registered company name (Juristic only).                                       |
| `registration_date`     | DATE                     |                                   | Company registration date (Juristic only).                                     |
| `industry_code`         | VARCHAR(50)              |                                   | Standard industry classification code (Juristic only).                         |
| `status`                | ENUM                     | Default: `ACTIVE`                 | Customer status: `ACTIVE`, `INACTIVE`, `SUSPENDED`, `DECEASED`, `BLACKLISTED`. |
| `membership_tier`       | VARCHAR(50)              |                                   | Loyalty tier.                                                                  |
| `points_balance`        | DECIMAL(15, 2)           | Default: 0                        | Current loyalty points balance.                                                |
| `clv`                   | DECIMAL(15, 2)           | Default: 0                        | Customer Lifetime Value.                                                       |
| `portfolio_size`        | DECIMAL(15, 2)           | Default: 0                        | Total value of assets/portfolio.                                               |
| `last_transaction_date` | TIMESTAMP WITH TIME ZONE |                                   | Timestamp of the last transaction.                                             |
| `preferred_channel`     | VARCHAR(50)              |                                   | Preferred communication channel.                                               |
| `is_high_value`         | BOOLEAN                  | Default: `FALSE`                  | Flag indicating high-net-worth individual.                                     |
| `created_at`            | TIMESTAMP WITH TIME ZONE | Default: `CURRENT_TIMESTAMP`      | Record creation timestamp.                                                     |
| `updated_at`            | TIMESTAMP WITH TIME ZONE | Default: `CURRENT_TIMESTAMP`      | Record last update timestamp.                                                  |
| `deleted_at`            | TIMESTAMP WITH TIME ZONE |                                   | Timestamp for soft deletion (PDPA).                                            |

### 2. `addresses`

Stores physical addresses associated with customers.

| Column Name     | Data Type                | Constraints                                     | Description                                   |
| :-------------- | :----------------------- | :---------------------------------------------- | :-------------------------------------------- |
| `id`            | UUID                     | PK, Default: `uuid_generate_v4()`               | Unique identifier for the address.            |
| `customer_id`   | UUID                     | FK `customers(id)`, NOT NULL, ON DELETE CASCADE | ID of the customer owning this address.       |
| `type`          | VARCHAR(50)              | NOT NULL                                        | Address type (e.g., Registered, Mailing, HQ). |
| `address_line1` | VARCHAR(255)             |                                                 | Street address, building, etc.                |
| `address_line2` | VARCHAR(255)             |                                                 | Additional address information.               |
| `city`          | VARCHAR(100)             |                                                 | City or district.                             |
| `state`         | VARCHAR(100)             |                                                 | State or province.                            |
| `district`      | VARCHAR(100)             |                                                 | District (Specific to Thai addresses).        |
| `sub_district`  | VARCHAR(100)             |                                                 | Sub-district (Specific to Thai addresses).    |
| `zip_code`      | VARCHAR(20)              |                                                 | Postal code.                                  |
| `country`       | VARCHAR(100)             | NOT NULL                                        | Country name.                                 |
| `created_at`    | TIMESTAMP WITH TIME ZONE | Default: `CURRENT_TIMESTAMP`                    | Record creation timestamp.                    |
| `updated_at`    | TIMESTAMP WITH TIME ZONE | Default: `CURRENT_TIMESTAMP`                    | Record last update timestamp.                 |

### 3. `identities`

Stores official identification documents.

| Column Name        | Data Type                | Constraints                                     | Description                                          |
| :----------------- | :----------------------- | :---------------------------------------------- | :--------------------------------------------------- |
| `id`               | UUID                     | PK, Default: `uuid_generate_v4()`               | Unique identifier for the identity document.         |
| `customer_id`      | UUID                     | FK `customers(id)`, NOT NULL, ON DELETE CASCADE | ID of the customer owning this document.             |
| `type`             | VARCHAR(50)              | NOT NULL                                        | Document type (e.g., Passport, National ID, Tax ID). |
| `number`           | VARCHAR(100)             | NOT NULL                                        | Document number.                                     |
| `issuance_country` | VARCHAR(100)             |                                                 | Country that issued the document.                    |
| `expiry_date`      | DATE                     |                                                 | Expiration date of the document.                     |
| `created_at`       | TIMESTAMP WITH TIME ZONE | Default: `CURRENT_TIMESTAMP`                    | Record creation timestamp.                           |
| `updated_at`       | TIMESTAMP WITH TIME ZONE | Default: `CURRENT_TIMESTAMP`                    | Record last update timestamp.                        |

**Indexes/Constraints**:

- `UNIQUE(type, number, issuance_country)`: Prevents duplicate identity records.

### 4. `relationships`

Defines links between two customers.

| Column Name        | Data Type                | Constraints                                     | Description                                                                           |
| :----------------- | :----------------------- | :---------------------------------------------- | :------------------------------------------------------------------------------------ |
| `id`               | UUID                     | PK, Default: `uuid_generate_v4()`               | Unique identifier for the relationship.                                               |
| `from_customer_id` | UUID                     | FK `customers(id)`, NOT NULL, ON DELETE CASCADE | The "source" customer in the relationship.                                            |
| `to_customer_id`   | UUID                     | FK `customers(id)`, NOT NULL, ON DELETE CASCADE | The "target" customer in the relationship.                                            |
| `role`             | VARCHAR(50)              | NOT NULL                                        | The role of the target customer relative to the source (e.g., Director, Shareholder). |
| `created_at`       | TIMESTAMP WITH TIME ZONE | Default: `CURRENT_TIMESTAMP`                    | Record creation timestamp.                                                            |

### 5. `consents`

Tracks PDPA/GDPR consent status for various topics.

| Column Name   | Data Type                | Constraints                                     | Description                                                |
| :------------ | :----------------------- | :---------------------------------------------- | :--------------------------------------------------------- |
| `id`          | UUID                     | PK, Default: `uuid_generate_v4()`               | Unique identifier for the consent record.                  |
| `customer_id` | UUID                     | FK `customers(id)`, NOT NULL, ON DELETE CASCADE | ID of the customer the consent belongs to.                 |
| `topic`       | VARCHAR(100)             | NOT NULL                                        | Consent topic (e.g., Marketing, Analytics).                |
| `version`     | VARCHAR(20)              | NOT NULL                                        | Version of the consent terms.                              |
| `is_granted`  | BOOLEAN                  | Default: `FALSE`                                | Whether consent is granted (`TRUE`) or withheld (`FALSE`). |
| `timestamp`   | TIMESTAMP WITH TIME ZONE | Default: `CURRENT_TIMESTAMP`                    | Time when the consent status changed.                      |
| `created_at`  | TIMESTAMP WITH TIME ZONE | Default: `CURRENT_TIMESTAMP`                    | Record creation timestamp.                                 |

### 6. `audit_logs`

Immutable log of important system actions.

| Column Name    | Data Type                | Constraints                       | Description                                                 |
| :------------- | :----------------------- | :-------------------------------- | :---------------------------------------------------------- |
| `id`           | UUID                     | PK, Default: `uuid_generate_v4()` | Unique identifier for the log entry.                        |
| `entity_id`    | UUID                     | NOT NULL                          | ID of the entity being affected (e.g., customer_id).        |
| `entity_type`  | VARCHAR(50)              | NOT NULL                          | Type of entity affected (e.g., CUSTOMER, ADDRESS).          |
| `action`       | VARCHAR(50)              | NOT NULL                          | Action performed (e.g., CREATE, UPDATE, DELETE, ANONYMIZE). |
| `performed_by` | VARCHAR(100)             | NOT NULL                          | User ID or System component that performed the action.      |
| `timestamp`    | TIMESTAMP WITH TIME ZONE | Default: `CURRENT_TIMESTAMP`      | Time the action occurred.                                   |
| `changes`      | TEXT                     |                                   | JSON or text representation of the changes (diff).          |
| `ip_address`   | VARCHAR(50)              |                                   | IP address of the requester.                                |

### 7. `users`

Stores **Internal Staff** accounts for system access (API & Admin Dashboard).
**Note**: This table is NOT for end customers (who are in `customers`).

| Column Name     | Data Type                | Constraints                       | Description                                                    |
| :-------------- | :----------------------- | :-------------------------------- | :------------------------------------------------------------- |
| `id`            | UUID                     | PK, Default: `uuid_generate_v4()` | Unique identifier for the staff user.                          |
| `username`      | VARCHAR(100)             | UNIQUE, NOT NULL                  | Login username.                                                |
| `email`         | VARCHAR(255)             | UNIQUE, NOT NULL                  | Staff email address.                                           |
| `password_hash` | VARCHAR(255)             | NOT NULL                          | Hashed password (Bcrypt).                                      |
| `role`          | VARCHAR(50)              | DEFAULT: 'STAFF'                  | Role for RBAC (e.g., `SUPER_ADMIN`, `CUSTOMER_CONTACT_ADMIN`). |
| `is_active`     | BOOLEAN                  | Default: `TRUE`                   | Login status.                                                  |
| `created_at`    | TIMESTAMP WITH TIME ZONE | Default: `CURRENT_TIMESTAMP`      | Record creation timestamp.                                     |
| `updated_at`    | TIMESTAMP WITH TIME ZONE | Default: `CURRENT_TIMESTAMP`      | Record last update timestamp.                                  |

## Enums

### `customer_type`

- `PERSONAL`
- `JURISTIC`

### `customer_status`

- `ACTIVE`
- `INACTIVE`
- `SUSPENDED`
- `DECEASED`
- `BLACKLISTED`

## API Endpoints (v1)

### Customers

| Method   | Endpoint                           | Description                                      | Auth Required |
| :------- | :--------------------------------- | :----------------------------------------------- | :------------ |
| `POST`   | `/api/v1/customers`                | Create a new customer profile.                   | Yes (JWT)     |
| `GET`    | `/api/v1/customers`                | List customers with pagination.                  | Yes (JWT)     |
| `GET`    | `/api/v1/customers/search?q=...`   | Search customers by name or company.             | Yes (JWT)     |
| `GET`    | `/api/v1/customers/{id}`           | Get detailed customer profile.                   | Yes (JWT)     |
| `PUT`    | `/api/v1/customers/{id}`           | Update customer profile (Full).                  | Yes (JWT)     |
| `PATCH`  | `/api/v1/customers/{id}`           | Update customer profile (Partial).               | Yes (JWT)     |
| `DELETE` | `/api/v1/customers/{id}`           | Soft delete a customer (Archive).                | Yes (JWT)     |
| `POST`   | `/api/v1/customers/{id}/anonymize` | Anonymize customer data (Right to be Forgotten). | Yes (JWT)     |
