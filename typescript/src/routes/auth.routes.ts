import { Router, RequestHandler } from 'express';
import { register, login, oauthGoogle, oauthCallback } from '../controllers/auth.controller';

const router = Router();

router.post('/register', register as RequestHandler);
router.post('/login', login as RequestHandler);
router.get('/oauth/google', oauthGoogle as RequestHandler);
router.get('/oauth/callback', oauthCallback as RequestHandler);

export default router;
