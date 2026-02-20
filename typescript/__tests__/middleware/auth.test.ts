import { Response } from 'express';
import { jwtAuth, apiKeyAuth, AuthRequest } from '../../src/middleware/auth';
import { verifyJWT, hashAPIKey } from '../../src/utils/auth';
import { query } from '../../src/config/database';

jest.mock('../../src/utils/auth', () => ({
  verifyJWT: jest.fn(),
  hashAPIKey: jest.fn(),
}));

jest.mock('../../src/config/database', () => ({
  query: jest.fn(),
}));

describe('Auth Middleware', () => {
  let mockRequest: Partial<AuthRequest>;
  let mockResponse: Partial<Response>;
  let nextFunction: jest.Mock;
  let jsonMock: jest.Mock;
  let statusMock: jest.Mock;

  beforeEach(() => {
    jsonMock = jest.fn();
    statusMock = jest.fn().mockReturnValue({ json: jsonMock });
    nextFunction = jest.fn();
    mockRequest = { headers: {} };
    mockResponse = {
      status: statusMock,
      json: jsonMock,
    };
    jest.clearAllMocks();
  });

  describe('jwtAuth', () => {
    it('should return 401 if header missing', () => {
      jwtAuth(mockRequest as AuthRequest, mockResponse as Response, nextFunction);
      expect(statusMock).toHaveBeenCalledWith(401);
      expect(jsonMock).toHaveBeenCalledWith({ error: 'Missing authorization header' });
    });

    it('should return 401 if header format invalid', () => {
      mockRequest.headers = { authorization: 'Token 123' };
      jwtAuth(mockRequest as AuthRequest, mockResponse as Response, nextFunction);
      expect(statusMock).toHaveBeenCalledWith(401);
      expect(jsonMock).toHaveBeenCalledWith({ error: 'Invalid authorization header format' });
    });

    it('should return 401 if length invalid', () => {
       mockRequest.headers = { authorization: 'Bearer' }; // split length 1
       jwtAuth(mockRequest as AuthRequest, mockResponse as Response, nextFunction);
       expect(statusMock).toHaveBeenCalledWith(401);
    });

    it('should return 401 if token invalid', () => {
      mockRequest.headers = { authorization: 'Bearer invalid' };
      (verifyJWT as jest.Mock).mockImplementation(() => { throw new Error('Invalid'); });
      jwtAuth(mockRequest as AuthRequest, mockResponse as Response, nextFunction);
      expect(statusMock).toHaveBeenCalledWith(401);
      expect(jsonMock).toHaveBeenCalledWith({ error: 'Invalid token' });
    });

    it('should call next if token valid', () => {
      mockRequest.headers = { authorization: 'Bearer valid' };
      (verifyJWT as jest.Mock).mockReturnValue({ userId: '1' });
      jwtAuth(mockRequest as AuthRequest, mockResponse as Response, nextFunction);
      expect(nextFunction).toHaveBeenCalled();
      expect(mockRequest.user).toEqual({ userId: '1' });
    });
  });

  describe('apiKeyAuth', () => {
    it('should return 401 if api key missing', async () => {
      await apiKeyAuth(mockRequest as AuthRequest, mockResponse as Response, nextFunction);
      expect(statusMock).toHaveBeenCalledWith(401);
      expect(jsonMock).toHaveBeenCalledWith({ error: 'Missing API key' });
    });
    
    it('should return 401 if api key invalid in DB', async () => {
       mockRequest.headers = { 'x-api-key': 'key' };
       (hashAPIKey as jest.Mock).mockReturnValue('hash');
       (query as jest.Mock).mockResolvedValue({ rows: [] });
       await apiKeyAuth(mockRequest as AuthRequest, mockResponse as Response, nextFunction);
       expect(statusMock).toHaveBeenCalledWith(401);
    });
    
    it('should return 401 if api key inactive', async () => {
       mockRequest.headers = { 'x-api-key': 'key' };
       (hashAPIKey as jest.Mock).mockReturnValue('hash');
       (query as jest.Mock).mockResolvedValue({ rows: [{ is_active: false }] });
       await apiKeyAuth(mockRequest as AuthRequest, mockResponse as Response, nextFunction);
       expect(statusMock).toHaveBeenCalledWith(401);
    });

    it('should call next if valid', async () => {
       mockRequest.headers = { 'x-api-key': 'key' };
       (hashAPIKey as jest.Mock).mockReturnValue('hash');
       (query as jest.Mock).mockResolvedValue({ rows: [{ user_id: '1', is_active: true }] });
       await apiKeyAuth(mockRequest as AuthRequest, mockResponse as Response, nextFunction);
       expect(nextFunction).toHaveBeenCalled();
       expect(mockRequest.user).toEqual({ userId: '1', username: '', email: '' });
    });

    it('should return 401 on error', async () => {
        mockRequest.headers = { 'x-api-key': 'key' };
        (query as jest.Mock).mockRejectedValue(new Error('DB Error'));
        await apiKeyAuth(mockRequest as AuthRequest, mockResponse as Response, nextFunction);
        expect(statusMock).toHaveBeenCalledWith(401);
    });
  });
});
