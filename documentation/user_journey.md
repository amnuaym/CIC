# CIC API User Journey: End-to-End Test Script

This document provides a step-by-step guide to testing the Customer Information Center (CIC) API. It follows a complete lifecycle of a customer "John Doe" and his company "Acme Corp".

## Prerequisites

- API running at `http://localhost`
- `curl` installed (or use Git Bash/PowerShell)
- `jq` installed (optional, for pretty printing JSON)

> [!TIP]
> **Automated Testing**: A PowerShell script is available at `scripts/test_journey.ps1` that automates this entire flow for verification.

---

## 🏗️ Scenario: Onboarding & Management

### 1. Create a Personal Customer (John Doe)

First, we onboard a new individual customer.

**Request:**

```bash
curl -X POST http://localhost/api/v1/customers \
  -H "Content-Type: application/json" \
  -d '{
    "type": "PERSONAL",
    "first_name": "John",
    "last_name": "Doe",
    "title": "Mr.",
    "status": "ACTIVE",
    "date_of_birth": "1990-01-01T00:00:00Z",
    "nationality": "Thai"
  }'
```

**Expected Output:** JSON object with a new `id` (e.g., `uuid-john`). **Save this ID.**

---

### 2. Add an Address

John lives in Bangkok. We add his registered address.

**Request:**
_(Replace `{JOHN_ID}` with the ID from Step 1)_

```bash
curl -X POST http://localhost/api/v1/customers/{JOHN_ID}/addresses \
  -H "Content-Type: application/json" \
  -d '{
    "type": "Registered",
    "address_line1": "123 Sukhumvit Road",
    "city": "Bangkok",
    "zip_code": "10110",
    "country": "Thailand"
  }'
```

---

### 3. Add an Identity Document

We verify John's identity with his National ID.

**Request:**

```bash
curl -X POST http://localhost/api/v1/customers/{JOHN_ID}/identities \
  -H "Content-Type: application/json" \
  -d '{
    "type": "National ID",
    "number": "1-2345-67890-12-3",
    "issuance_country": "Thailand",
    "expiry_date": "2030-12-31T00:00:00Z"
  }'
```

---

### 4. Grant PDPA Consent

John agrees to receive marketing material.

**Request:**

```bash
curl -X POST http://localhost/api/v1/customers/{JOHN_ID}/consents \
  -H "Content-Type: application/json" \
  -d '{
    "topic": "Marketing",
    "version": "1.0",
    "is_granted": true
  }'
```

---

### 5. Create a Juristic Customer (Acme Corp)

John owns a company. Let's create the business profile.

**Request:**

```bash
curl -X POST http://localhost/api/v1/customers \
  -H "Content-Type: application/json" \
  -d '{
    "type": "JURISTIC",
    "company_name": "Acme Corp Ltd.",
    "status": "ACTIVE",
    "registration_date": "2020-05-20T00:00:00Z",
    "industry_code": "TECH001"
  }'
```

**Expected Output:** JSON object with a new `id` (e.g., `uuid-acme`). **Save this ID.**

---

### 6. Link Relationship (Director)

John is the Director of Acme Corp.

**Request:**
_(Replace `{JOHN_ID}` and `{ACME_ID}`)_

```bash
curl -X POST http://localhost/api/v1/customers/{JOHN_ID}/relationships \
  -H "Content-Type: application/json" \
  -d '{
    "to_customer_id": "{ACME_ID}",
    "role": "Director"
  }'
```

---

### 7. View Full Profile

Verify that John is linked to Acme Corp.

**Request:**

```bash
curl http://localhost/api/v1/customers/{JOHN_ID}/relationships
```

---

## 🗑️ Scenario: Right to be Forgotten (PDPA)

### 8. Anonymize John Doe

John requests to delete his data.

**Request:**

```bash
curl -X POST http://localhost/api/v1/customers/{JOHN_ID}/anonymize
```

**Verification:**

1. Fetch John's profile again:
   ```bash
   curl http://localhost/api/v1/customers/{JOHN_ID}
   ```
2. **Check:** `first_name` should be something like `Deleted_User_...`, and `status` should be `BLACKLISTED` (or similar anonymized status).
