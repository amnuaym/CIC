import { Router } from 'express';
import { listPosts, getPost, createPost, updatePost, deletePost } from '../controllers/post.controller';
import { jwtAuth, apiKeyAuth } from '../middleware/auth';

const router = Router();

// JWT protected routes
router.get('/', jwtAuth, listPosts);
router.get('/:id', jwtAuth, getPost);
router.post('/', jwtAuth, createPost);
router.put('/:id', jwtAuth, updatePost);
router.delete('/:id', jwtAuth, deletePost);

// API key protected alternative (can be used instead of JWT)
// router.get('/', apiKeyAuth, listPosts);

export default router;
