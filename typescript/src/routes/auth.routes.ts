import { Router } from 'express';
import { register, login, oauthGoogle, oauthCallback } from '../controllers/auth.controller';

const router = Router();

router.post('/register', register);
router.post('/login', login);
router.get('/oauth/google', oauthGoogle);
router.get('/oauth/callback', oauthCallback);

export default router;
