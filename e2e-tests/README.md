# End-to-End Tests

Playwright-based end-to-end tests for the Backend Template.

## Features

- API endpoint testing
- Admin dashboard UI testing
- Authentication flow testing
- Cross-browser testing (Chrome, Firefox, Safari)
- Automatic retries on CI
- HTML test reports

## Setup

### Prerequisites

- Node.js 18+
- Running backend API and React Admin dashboard
- Playwright browsers installed

### Installation

1. Install dependencies:
```bash
npm install
```

2. Install Playwright browsers:
```bash
npx playwright install
```

## Running Tests

### Basic Test Execution

```bash
# Run all tests
npm test

# Run tests in headed mode (see browser)
npm run test:headed

# Run tests in UI mode (interactive)
npm run test:ui

# Run tests in debug mode
npm run test:debug

# Run specific test file
npx playwright test tests/api.spec.ts

# Run tests in specific browser
npx playwright test --project=chromium
```

### Environment Configuration

Set environment variables to configure test URLs:

```bash
# API URL (default: http://localhost:3000)
export API_URL=http://localhost:3000

# Go API URL (default: http://localhost:8080)
export GO_API_URL=http://localhost:8080

# React Admin URL (default: http://localhost:3001)
export BASE_URL=http://localhost:3001

# Test credentials (optional, for authenticated tests)
export TEST_USERNAME=testuser
export TEST_PASSWORD=testpass123

# Run tests
npm test
```

### Test Reports

```bash
# View last test report
npm run report
```

The HTML report will open in your browser showing test results, screenshots, and traces.

## Test Structure

```
e2e-tests/
├── tests/
│   ├── api.spec.ts        # API endpoint tests
│   └── admin.spec.ts      # React Admin UI tests
├── playwright.config.ts   # Playwright configuration
├── package.json
└── README.md
```

## Test Scenarios

### API Tests (`api.spec.ts`)

- Health check endpoints (TypeScript & Go APIs)
- User registration
- User login
- Authentication rejection
- Post creation
- Post listing
- Unauthorized access rejection

### Admin Tests (`admin.spec.ts`)

- Login page loading
- Invalid login rejection
- Dashboard navigation
- Post management (create, edit, delete)

## Writing New Tests

### API Test Example

```typescript
import { test, expect } from '@playwright/test';

test('My API test', async ({ request }) => {
  const response = await request.get('http://localhost:3000/api/endpoint');
  expect(response.ok()).toBeTruthy();
  
  const data = await response.json();
  expect(data).toHaveProperty('field');
});
```

### UI Test Example

```typescript
import { test, expect } from '@playwright/test';

test('My UI test', async ({ page }) => {
  await page.goto('http://localhost:3001');
  await expect(page.locator('h1')).toHaveText('Expected Text');
  await page.click('button');
  await expect(page).toHaveURL(/.*success.*/);
});
```

## CI/CD Integration

The tests are configured to work in CI environments:

- Automatic retries on failure (2 retries in CI)
- Single worker in CI to avoid race conditions
- Forbidden-only mode to prevent `.only` tests
- Screenshots on failure
- Traces on first retry

### GitHub Actions Example

```yaml
- name: Install dependencies
  run: |
    cd e2e-tests
    npm ci
    npx playwright install --with-deps

- name: Run E2E tests
  run: |
    cd e2e-tests
    npm test
  env:
    API_URL: http://localhost:3000
    BASE_URL: http://localhost:3001
```

## Debugging Tests

### Debug Mode

```bash
npm run test:debug
```

This opens Playwright Inspector where you can:
- Step through tests
- Inspect DOM
- See network requests
- View console logs

### UI Mode

```bash
npm run test:ui
```

Interactive mode with:
- Time travel debugging
- Watch mode
- Pick locators
- View traces

### Screenshots and Videos

Configure in `playwright.config.ts`:

```typescript
use: {
  screenshot: 'only-on-failure',
  video: 'retain-on-failure',
  trace: 'on-first-retry',
}
```

## Best Practices

1. **Isolate Tests**: Each test should be independent
2. **Use Test Fixtures**: Create test data in `beforeAll`/`beforeEach`
3. **Clean Up**: Remove test data in `afterAll`/`afterEach`
4. **Wait Properly**: Use `waitFor` instead of `setTimeout`
5. **Use Data Attributes**: Add `data-testid` to elements for stable selectors
6. **Run Locally**: Test locally before CI to catch issues early

## Troubleshooting

### Tests Fail Locally

1. Ensure all services are running:
   - PostgreSQL database
   - Backend API (TypeScript or Go)
   - React Admin dashboard

2. Check environment variables are set correctly

3. Clear test data if needed

### Tests Fail in CI

1. Check CI logs for errors
2. View test report artifacts
3. Ensure services start properly
4. Check for timing issues (increase timeouts if needed)

## License

See LICENSE file in the root directory.
