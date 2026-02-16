import { Request, Response, NextFunction } from 'express';
import { verifyJWT, hashAPIKey } from '../utils/auth';
import { query } from '../config/database';

export interface AuthRequest extends Request {
  user?: {
    userId: string;
    username: string;
    email: string;
  };
}

export const jwtAuth = (req: AuthRequest, res: Response, next: NextFunction): void => {
  try {
    const authHeader = req.headers.authorization;
    
    if (!authHeader) {
      res.status(401).json({ error: 'Missing authorization header' });
      return;
    }

    const parts = authHeader.split(' ');
    if (parts.length !== 2 || parts[0] !== 'Bearer') {
      res.status(401).json({ error: 'Invalid authorization header format' });
      return;
    }

    const token = parts[1];
    const payload = verifyJWT(token);
    
    req.user = payload;
    next();
  } catch (error) {
    res.status(401).json({ error: 'Invalid token' });
  }
};

export const apiKeyAuth = async (req: AuthRequest, res: Response, next: NextFunction): Promise<void> => {
  try {
    const apiKey = req.headers['x-api-key'] as string;
    
    if (!apiKey) {
      res.status(401).json({ error: 'Missing API key' });
      return;
    }

    const keyHash = hashAPIKey(apiKey);
    
    const result = await query(
      'SELECT user_id, is_active FROM api_keys WHERE key_hash = $1 AND (expires_at IS NULL OR expires_at > NOW())',
      [keyHash]
    );

    if (result.rows.length === 0 || !result.rows[0].is_active) {
      res.status(401).json({ error: 'Invalid API key' });
      return;
    }

    req.user = { userId: result.rows[0].user_id, username: '', email: '' };
    next();
  } catch (error) {
    res.status(401).json({ error: 'Invalid API key' });
  }
};
