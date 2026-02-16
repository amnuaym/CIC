import { Router } from 'express';
import { getCurrentUser } from '../controllers/user.controller';
import { jwtAuth } from '../middleware/auth';

const router = Router();

router.get('/me', jwtAuth, getCurrentUser);

export default router;
