import { Response } from 'express';
import { getCurrentUser } from '../../src/controllers/user.controller';
import { query } from '../../src/config/database';
import { AuthRequest } from '../../src/middleware/auth';

jest.mock('../../src/config/database', () => ({
  query: jest.fn(),
}));

describe('User Controller', () => {
  let mockRequest: Partial<AuthRequest>;
  let mockResponse: Partial<Response>;
  let jsonMock: jest.Mock;
  let statusMock: jest.Mock;

  beforeEach(() => {
    jsonMock = jest.fn();
    statusMock = jest.fn().mockReturnValue({ json: jsonMock });
    mockRequest = {};
    mockResponse = {
      status: statusMock,
      json: jsonMock,
    };
    jest.clearAllMocks();
  });

  describe('getCurrentUser', () => {
    it('should return 401 if user is not authenticated', async () => {
      await getCurrentUser(mockRequest as AuthRequest, mockResponse as Response);
      
      expect(statusMock).toHaveBeenCalledWith(401);
      expect(jsonMock).toHaveBeenCalledWith({ error: 'Unauthorized' });
    });

    it('should return user details if found', async () => {
      mockRequest.user = { userId: '1', username: 'test', email: 'test@test.com' };
      (query as jest.Mock).mockResolvedValue({
        rows: [{ id: '1', email: 'test@test.com', username: 'test' }],
      });

      await getCurrentUser(mockRequest as AuthRequest, mockResponse as Response);

      expect(query).toHaveBeenCalledWith(expect.stringContaining('SELECT'), ['1']);
      expect(jsonMock).toHaveBeenCalledWith({ id: '1', email: 'test@test.com', username: 'test' });
    });

    it('should return 404 if user not found', async () => {
      mockRequest.user = { userId: '1', username: 'test', email: 'test@test.com' };
      (query as jest.Mock).mockResolvedValue({ rows: [] });

      await getCurrentUser(mockRequest as AuthRequest, mockResponse as Response);

      expect(statusMock).toHaveBeenCalledWith(404);
      expect(jsonMock).toHaveBeenCalledWith({ error: 'User not found' });
    });

    it('should return 500 on database error', async () => {
      mockRequest.user = { userId: '1', username: 'test', email: 'test@test.com' };
      (query as jest.Mock).mockRejectedValue(new Error('DB Error'));

      await getCurrentUser(mockRequest as AuthRequest, mockResponse as Response);

      expect(statusMock).toHaveBeenCalledWith(500);
      expect(jsonMock).toHaveBeenCalledWith({ error: 'Failed to fetch user' });
    });
  });
});
