import { Response } from 'express';
import { query } from '../config/database';
import { AuthRequest } from '../middleware/auth';

export const listPosts = async (req: AuthRequest, res: Response): Promise<void> => {
  try {
    const result = await query(
      'SELECT id, user_id, title, content, status, created_at, updated_at FROM posts ORDER BY created_at DESC'
    );

    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch posts' });
  }
};

export const getPost = async (req: AuthRequest, res: Response): Promise<void> => {
  try {
    const { id } = req.params;

    const result = await query(
      'SELECT id, user_id, title, content, status, created_at, updated_at FROM posts WHERE id = $1',
      [id]
    );

    if (result.rows.length === 0) {
      res.status(404).json({ error: 'Post not found' });
      return;
    }

    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch post' });
  }
};

export const createPost = async (req: AuthRequest, res: Response): Promise<void> => {
  try {
    if (!req.user) {
      res.status(401).json({ error: 'Unauthorized' });
      return;
    }

    const { title, content, status } = req.body;

    if (!title) {
      res.status(400).json({ error: 'Title is required' });
      return;
    }

    const result = await query(
      'INSERT INTO posts (user_id, title, content, status) VALUES ($1, $2, $3, $4) RETURNING id',
      [req.user.userId, title, content || null, status || 'draft']
    );

    res.status(201).json({ id: result.rows[0].id });
  } catch (error) {
    res.status(500).json({ error: 'Failed to create post' });
  }
};

export const updatePost = async (req: AuthRequest, res: Response): Promise<void> => {
  try {
    if (!req.user) {
      res.status(401).json({ error: 'Unauthorized' });
      return;
    }

    const { id } = req.params;
    const { title, content, status } = req.body;

    const result = await query(
      'UPDATE posts SET title = $1, content = $2, status = $3, updated_at = NOW() WHERE id = $4 AND user_id = $5',
      [title, content, status, id, req.user.userId]
    );

    if (result.rowCount === 0) {
      res.status(404).json({ error: 'Post not found or unauthorized' });
      return;
    }

    res.json({ message: 'Post updated successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to update post' });
  }
};

export const deletePost = async (req: AuthRequest, res: Response): Promise<void> => {
  try {
    if (!req.user) {
      res.status(401).json({ error: 'Unauthorized' });
      return;
    }

    const { id } = req.params;

    const result = await query(
      'DELETE FROM posts WHERE id = $1 AND user_id = $2',
      [id, req.user.userId]
    );

    if (result.rowCount === 0) {
      res.status(404).json({ error: 'Post not found or unauthorized' });
      return;
    }

    res.json({ message: 'Post deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete post' });
  }
};
