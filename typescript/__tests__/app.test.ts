import request from 'supertest';
import app from '../src/app';

describe('App Error Handling', () => {
  it('should handle JSON parse errors', async () => {
    const response = await request(app)
      .post('/api/auth/login') // Any route that uses body parser
      .set('Content-Type', 'application/json')
      .send('{"invalid": json'); // Malformed JSON
    
    // body-parser creates a 400 error for invalid JSON
    expect(response.status).toBe(400); 
    // The error message comes from body-parser ("Unexpected token ...")
    expect(response.body).toHaveProperty('error');
  });

  it('should return health check', async () => {
      const response = await request(app).get('/health');
      expect(response.status).toBe(200);
      expect(response.body).toEqual({ status: 'healthy', service: 'typescript-api' });
  });
});
