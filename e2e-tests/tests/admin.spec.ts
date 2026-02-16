import { test, expect } from '@playwright/test';

const ADMIN_URL = process.env.BASE_URL || 'http://localhost:3001';

test.describe('React Admin Dashboard', () => {
  test('Should load login page', async ({ page }) => {
    await page.goto(ADMIN_URL);
    
    // Should redirect to login if not authenticated
    await expect(page).toHaveURL(/.*login.*/);
    await expect(page.locator('input[name="username"]')).toBeVisible();
    await expect(page.locator('input[name="password"]')).toBeVisible();
  });

  test('Should reject invalid login', async ({ page }) => {
    await page.goto(ADMIN_URL);
    
    await page.fill('input[name="username"]', 'invalid');
    await page.fill('input[name="password"]', 'invalid');
    await page.click('button[type="submit"]');
    
    // Should show error message or stay on login page
    await page.waitForTimeout(1000);
    await expect(page).toHaveURL(/.*login.*/);
  });

  test('Should navigate through dashboard after login', async ({ page }) => {
    // This test requires a valid user account
    // For a real implementation, you would:
    // 1. Create a test user via API
    // 2. Login with that user
    // 3. Test navigation
    
    // Skip this test if we don't have test credentials
    test.skip(!process.env.TEST_USERNAME, 'Requires test credentials');
    
    await page.goto(ADMIN_URL);
    
    await page.fill('input[name="username"]', process.env.TEST_USERNAME || '');
    await page.fill('input[name="password"]', process.env.TEST_PASSWORD || '');
    await page.click('button[type="submit"]');
    
    // Should redirect to dashboard
    await expect(page).toHaveURL(ADMIN_URL);
    
    // Check for main navigation elements
    await expect(page.locator('text=Posts')).toBeVisible();
    await expect(page.locator('text=Users')).toBeVisible();
  });
});

test.describe('Posts Management', () => {
  test.skip('Should create a new post', async ({ page }) => {
    // This would be implemented with proper authentication
    test.skip(!process.env.TEST_USERNAME, 'Requires test credentials');
    
    // Login, navigate to posts, create new post
    // This is a placeholder for the actual implementation
  });
});
