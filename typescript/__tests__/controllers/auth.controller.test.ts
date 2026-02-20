import { Response } from 'express';
import { register, login, oauthGoogle, oauthCallback } from '../../src/controllers/auth.controller';
import { query } from '../../src/config/database';
import { hashPassword, comparePassword, generateJWT } from '../../src/utils/auth';
import { AuthRequest } from '../../src/middleware/auth';

jest.mock('../../src/config/database', () => ({
  query: jest.fn(),
}));

jest.mock('../../src/utils/auth', () => ({
  hashPassword: jest.fn(),
  comparePassword: jest.fn(),
  generateJWT: jest.fn(),
}));

describe('Auth Controller', () => {
  let mockRequest: Partial<AuthRequest>;
  let mockResponse: Partial<Response>;
  let jsonMock: jest.Mock;
  let statusMock: jest.Mock;

  beforeEach(() => {
    jsonMock = jest.fn();
    statusMock = jest.fn().mockReturnValue({ json: jsonMock });
    mockRequest = { body: {} };
    mockResponse = {
      status: statusMock,
      json: jsonMock,
    };
    jest.clearAllMocks();
  });

  describe('register', () => {
    it('should return 400 if fields are missing', async () => {
      mockRequest.body = { email: 'test@test.com' }; // missing username/password
      await register(mockRequest as AuthRequest, mockResponse as Response);
      expect(statusMock).toHaveBeenCalledWith(400);
      expect(jsonMock).toHaveBeenCalledWith({ error: 'Missing required fields' });
    });

    it('should register a new user successfully', async () => {
      mockRequest.body = { email: 'test@test.com', username: 'test', password: 'password' };
      (hashPassword as jest.Mock).mockResolvedValue('hashed_password');
      (query as jest.Mock).mockResolvedValue({
        rows: [{ id: '1', email: 'test@test.com', username: 'test' }],
      });
      (generateJWT as jest.Mock).mockReturnValue('token');

      await register(mockRequest as AuthRequest, mockResponse as Response);

      expect(query).toHaveBeenCalled();
      expect(statusMock).toHaveBeenCalledWith(201);
      expect(jsonMock).toHaveBeenCalledWith({
        token: 'token',
        user: { id: '1', email: 'test@test.com', username: 'test' },
      });
    });

    it('should return 409 if user already exists', async () => {
      mockRequest.body = { email: 'test@test.com', username: 'test', password: 'password' };
      (hashPassword as jest.Mock).mockResolvedValue('hashed_password');
      const error: any = new Error('User exists');
      error.code = '23505';
      (query as jest.Mock).mockRejectedValue(error);

      await register(mockRequest as AuthRequest, mockResponse as Response);

      expect(statusMock).toHaveBeenCalledWith(409);
      expect(jsonMock).toHaveBeenCalledWith({ error: 'User already exists' });
    });

    it('should return 500 on database error', async () => {
      mockRequest.body = { email: 'test@test.com', username: 'test', password: 'password' };
      (hashPassword as jest.Mock).mockResolvedValue('hashed_password');
      (query as jest.Mock).mockRejectedValue(new Error('DB Error'));

      await register(mockRequest as AuthRequest, mockResponse as Response);

      expect(statusMock).toHaveBeenCalledWith(500);
      expect(jsonMock).toHaveBeenCalledWith({ error: 'Failed to register user' });
    });
  });

  describe('login', () => {
    it('should return 400 if fields are missing', async () => {
      mockRequest.body = { username: 'test' }; // missing password
      await login(mockRequest as AuthRequest, mockResponse as Response);
      expect(statusMock).toHaveBeenCalledWith(400);
    });

    it('should return 401 if user not found', async () => {
      mockRequest.body = { username: 'test', password: 'password' };
      (query as jest.Mock).mockResolvedValue({ rows: [] });

      await login(mockRequest as AuthRequest, mockResponse as Response);
      expect(statusMock).toHaveBeenCalledWith(401);
      expect(jsonMock).toHaveBeenCalledWith({ error: 'Invalid credentials' });
    });

    it('should return 401 if password invalid', async () => {
      mockRequest.body = { username: 'test', password: 'password' };
      (query as jest.Mock).mockResolvedValue({
        rows: [{ id: '1', email: 'test@test.com', username: 'test', password_hash: 'hashed' }],
      });
      (comparePassword as jest.Mock).mockResolvedValue(false);

      await login(mockRequest as AuthRequest, mockResponse as Response);
      expect(statusMock).toHaveBeenCalledWith(401);
      expect(jsonMock).toHaveBeenCalledWith({ error: 'Invalid credentials' });
    });

    it('should login successfully', async () => {
      mockRequest.body = { username: 'test', password: 'password' };
      (query as jest.Mock).mockResolvedValue({
        rows: [{ id: '1', email: 'test@test.com', username: 'test', password_hash: 'hashed' }],
      });
      (comparePassword as jest.Mock).mockResolvedValue(true);
      (generateJWT as jest.Mock).mockReturnValue('token');

      await login(mockRequest as AuthRequest, mockResponse as Response);

      expect(jsonMock).toHaveBeenCalledWith({
        token: 'token',
        user: { id: '1', email: 'test@test.com', username: 'test' },
      });
    });

    it('should return 500 on server error', async () => {
        mockRequest.body = { username: 'test', password: 'password' };
        (query as jest.Mock).mockRejectedValue(new Error('DB Error'));
  
        await login(mockRequest as AuthRequest, mockResponse as Response);
  
        expect(statusMock).toHaveBeenCalledWith(500);
      });
  });

  describe('oauth', () => {
    it('oauthGoogle should return 501', async () => {
        await oauthGoogle(mockRequest as AuthRequest, mockResponse as Response);
        expect(statusMock).toHaveBeenCalledWith(501);
    });

    it('oauthCallback should return 501', async () => {
        await oauthCallback(mockRequest as AuthRequest, mockResponse as Response);
        expect(statusMock).toHaveBeenCalledWith(501);
    });
  });
});
