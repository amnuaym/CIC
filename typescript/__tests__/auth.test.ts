import { hashPassword, comparePassword, generateJWT, verifyJWT, hashAPIKey, generateAPIKey } from '../src/utils/auth';

describe('Auth Utils', () => {
  describe('hashPassword and comparePassword', () => {
    it('should hash a password', async () => {
      const password = 'test_password_123';
      const hash = await hashPassword(password);
      
      expect(hash).toBeDefined();
      expect(hash).not.toBe(password);
      expect(hash.length).toBeGreaterThan(0);
    });

    it('should validate correct password', async () => {
      const password = 'test_password_123';
      const hash = await hashPassword(password);
      
      const isValid = await comparePassword(password, hash);
      expect(isValid).toBe(true);
    });

    it('should reject incorrect password', async () => {
      const password = 'test_password_123';
      const hash = await hashPassword(password);
      
      const isValid = await comparePassword('wrong_password', hash);
      expect(isValid).toBe(false);
    });
  });

  describe('generateJWT and verifyJWT', () => {
    it('should generate a JWT token', () => {
      const payload = {
        userId: '123',
        username: 'testuser',
        email: 'test@example.com',
      };

      const token = generateJWT(payload);
      expect(token).toBeDefined();
      expect(token.length).toBeGreaterThan(0);
    });

    it('should verify a valid JWT token', () => {
      const payload = {
        userId: '123',
        username: 'testuser',
        email: 'test@example.com',
      };

      const token = generateJWT(payload);
      const decoded = verifyJWT(token);

      expect(decoded.userId).toBe(payload.userId);
      expect(decoded.username).toBe(payload.username);
      expect(decoded.email).toBe(payload.email);
    });

    it('should throw error for invalid token', () => {
      expect(() => verifyJWT('invalid_token')).toThrow();
    });
  });

  describe('API Key utilities', () => {
    it('should hash API key consistently', () => {
      const apiKey = 'test-api-key-123';
      const hash1 = hashAPIKey(apiKey);
      const hash2 = hashAPIKey(apiKey);

      expect(hash1).toBe(hash2);
      expect(hash1).not.toBe(apiKey);
    });

    it('should generate unique API keys', () => {
      const key1 = generateAPIKey();
      const key2 = generateAPIKey();

      expect(key1).toBeDefined();
      expect(key2).toBeDefined();
      expect(key1).not.toBe(key2);
    });
  });
});
