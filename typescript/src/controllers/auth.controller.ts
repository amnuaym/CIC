import { Response } from 'express';
import { query } from '../config/database';
import { hashPassword, comparePassword, generateJWT } from '../utils/auth';
import { AuthRequest } from '../middleware/auth';

export const register = async (req: AuthRequest, res: Response): Promise<void> => {
  try {
    const { email, username, password } = req.body;

    if (!email || !username || !password) {
      res.status(400).json({ error: 'Missing required fields' });
      return;
    }

    const passwordHash = await hashPassword(password);

    const result = await query(
      'INSERT INTO users (email, username, password_hash) VALUES ($1, $2, $3) RETURNING id, email, username',
      [email, username, passwordHash]
    );

    const user = result.rows[0];
    const token = generateJWT({
      userId: user.id,
      username: user.username,
      email: user.email,
    });

    res.status(201).json({ token, user });
  } catch (error: any) {
    if (error.code === '23505') {
      res.status(409).json({ error: 'User already exists' });
    } else {
      res.status(500).json({ error: 'Failed to register user' });
    }
  }
};

export const login = async (req: AuthRequest, res: Response): Promise<void> => {
  try {
    const { username, password } = req.body;

    if (!username || !password) {
      res.status(400).json({ error: 'Missing required fields' });
      return;
    }

    const result = await query(
      'SELECT id, email, username, password_hash FROM users WHERE username = $1 AND is_active = true',
      [username]
    );

    if (result.rows.length === 0) {
      res.status(401).json({ error: 'Invalid credentials' });
      return;
    }

    const user = result.rows[0];
    const isValid = await comparePassword(password, user.password_hash);

    if (!isValid) {
      res.status(401).json({ error: 'Invalid credentials' });
      return;
    }

    const token = generateJWT({
      userId: user.id,
      username: user.username,
      email: user.email,
    });

    res.json({
      token,
      user: {
        id: user.id,
        email: user.email,
        username: user.username,
      },
    });
  } catch (error) {
    res.status(500).json({ error: 'Failed to login' });
  }
};

export const oauthGoogle = async (req: AuthRequest, res: Response): Promise<void> => {
  res.status(501).json({
    message: 'OAuth implementation depends on your provider configuration',
    note: 'Configure OAUTH_CLIENT_ID, OAUTH_CLIENT_SECRET, and OAUTH_REDIRECT_URL in .env',
  });
};

export const oauthCallback = async (req: AuthRequest, res: Response): Promise<void> => {
  res.status(501).json({
    message: 'OAuth callback implementation depends on your provider configuration',
  });
};
