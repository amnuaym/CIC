import { test, expect } from '@playwright/test';

const API_URL = process.env.API_URL || 'http://localhost:3000';

test.describe('API Health Checks', () => {
  test('TypeScript API health check', async ({ request }) => {
    const response = await request.get(`${API_URL}/health`);
    expect(response.ok()).toBeTruthy();
    
    const data = await response.json();
    expect(data.status).toBe('healthy');
  });

  test('Go API health check', async ({ request }) => {
    const goApiUrl = process.env.GO_API_URL || 'http://localhost:8080';
    const response = await request.get(`${goApiUrl}/health`);
    expect(response.ok()).toBeTruthy();
    
    const data = await response.json();
    expect(data.status).toBe('healthy');
  });
});

test.describe('Authentication API', () => {
  const testUser = {
    username: `testuser_${Date.now()}`,
    email: `test_${Date.now()}@example.com`,
    password: 'TestPassword123!',
  };

  test('Register new user', async ({ request }) => {
    const response = await request.post(`${API_URL}/api/auth/register`, {
      data: testUser,
    });
    
    expect(response.status()).toBe(201);
    const data = await response.json();
    expect(data).toHaveProperty('token');
    expect(data).toHaveProperty('user');
    expect(data.user.username).toBe(testUser.username);
  });

  test('Login with credentials', async ({ request }) => {
    // First register
    await request.post(`${API_URL}/api/auth/register`, {
      data: testUser,
    });

    // Then login
    const response = await request.post(`${API_URL}/api/auth/login`, {
      data: {
        username: testUser.username,
        password: testUser.password,
      },
    });
    
    expect(response.ok()).toBeTruthy();
    const data = await response.json();
    expect(data).toHaveProperty('token');
    expect(data.user.username).toBe(testUser.username);
  });

  test('Reject invalid credentials', async ({ request }) => {
    const response = await request.post(`${API_URL}/api/auth/login`, {
      data: {
        username: 'nonexistent',
        password: 'wrongpassword',
      },
    });
    
    expect(response.status()).toBe(401);
  });
});

test.describe('Posts API', () => {
  let authToken: string;
  let postId: string;

  test.beforeAll(async ({ request }) => {
    // Register and login to get token
    const testUser = {
      username: `testuser_${Date.now()}`,
      email: `test_${Date.now()}@example.com`,
      password: 'TestPassword123!',
    };

    const registerResponse = await request.post(`${API_URL}/api/auth/register`, {
      data: testUser,
    });
    
    const data = await registerResponse.json();
    authToken = data.token;
  });

  test('Create a post', async ({ request }) => {
    const response = await request.post(`${API_URL}/api/posts`, {
      headers: {
        'Authorization': `Bearer ${authToken}`,
      },
      data: {
        title: 'Test Post',
        content: 'This is a test post',
        status: 'draft',
      },
    });
    
    expect(response.status()).toBe(201);
    const data = await response.json();
    expect(data).toHaveProperty('id');
    postId = data.id;
  });

  test('Get posts list', async ({ request }) => {
    const response = await request.get(`${API_URL}/api/posts`, {
      headers: {
        'Authorization': `Bearer ${authToken}`,
      },
    });
    
    expect(response.ok()).toBeTruthy();
    const data = await response.json();
    expect(Array.isArray(data)).toBeTruthy();
  });

  test('Reject unauthorized access', async ({ request }) => {
    const response = await request.get(`${API_URL}/api/posts`);
    expect(response.status()).toBe(401);
  });
});
