import { Router, RequestHandler } from 'express';
import { getCurrentUser } from '../controllers/user.controller';
import { jwtAuth } from '../middleware/auth';

const router = Router();

router.get('/me', jwtAuth as RequestHandler, getCurrentUser as RequestHandler);

export default router;
