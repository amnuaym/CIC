---
description: How to ensure code quality and test coverage
---

# Quality Assurance Workflow

Before submitting any changes, you must ensure the following quality gates are passed:

## 1. Unit Test Coverage

**Requirement:** 100% Line Coverage for backend code.

Run the following command in the `typescript` directory:

```bash
npm run test:coverage
```

- Verify that `Stmts`, `Branch`, `Funcs`, and `Lines` are all at or near 100%.
- If coverage drops, add necessary unit tests.

## 2. E2E Test Coverage

**Requirement:** Critical user journeys must be covered by E2E tests.

Run the E2E tests:

```bash
cd e2e-tests
npm run test
```

**Critical Journeys:**

- **Authentication:** Login, Logout, Protected Route Access
- **Dashboard:** Widget visibility, Navigation
- **Core Features:**
  - Post creation, editing, deletion
  - User profile viewing/editing

## 3. Linting and Formatting

Ensure code is clean and follows project standards:

```bash
npm run lint
```

// turbo-all
