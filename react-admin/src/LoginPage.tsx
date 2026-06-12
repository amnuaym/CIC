import { useState } from 'react';
import { useLogin, useNotify } from 'react-admin';
import { ThemeProvider } from '@mui/material/styles';
import { cicLightTheme } from './theme';
import {
  Box,
  Button,
  TextField,
  Typography,
  InputAdornment,
  IconButton,
} from '@mui/material';
import Visibility from '@mui/icons-material/Visibility';
import VisibilityOff from '@mui/icons-material/VisibilityOff';

const LoginPage = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const login = useLogin();
  const notify = useNotify();

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    login({ username, password })
      .catch(() => {
        notify('Incorrect username or password', { type: 'error' });
      })
      .finally(() => setLoading(false));
  };

  return (
    <ThemeProvider theme={cicLightTheme}>
    <Box
      sx={{
        display: 'flex',
        minHeight: '100vh',
        fontFamily: '"Inter", -apple-system, sans-serif',
      }}
    >
      {/* Left panel — brand/identity */}
      <Box
        sx={{
          flex: '0 0 42%',
          display: { xs: 'none', md: 'flex' },
          flexDirection: 'column',
          justifyContent: 'space-between',
          p: 5,
          bgcolor: '#0f172a',
          color: '#e2e8f0',
          position: 'relative',
          overflow: 'hidden',
        }}
      >
        {/* Subtle grid pattern overlay */}
        <Box
          sx={{
            position: 'absolute',
            inset: 0,
            opacity: 0.04,
            backgroundImage:
              'linear-gradient(rgba(255,255,255,.5) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,.5) 1px, transparent 1px)',
            backgroundSize: '48px 48px',
          }}
        />
        <Box sx={{ position: 'relative', zIndex: 1 }}>
          <Typography
            sx={{
              fontSize: '0.75rem',
              fontWeight: 600,
              letterSpacing: '0.08em',
              textTransform: 'uppercase',
              color: '#64748b',
            }}
          >
            Customer Information Center
          </Typography>
        </Box>
        <Box sx={{ position: 'relative', zIndex: 1 }}>
          <Typography
            sx={{
              fontSize: '2.25rem',
              fontWeight: 300,
              lineHeight: 1.2,
              letterSpacing: '-0.02em',
              mb: 2,
            }}
          >
            One view of
            <br />
            every customer.
          </Typography>
          <Typography
            sx={{
              fontSize: '0.875rem',
              color: '#94a3b8',
              maxWidth: 320,
              lineHeight: 1.6,
            }}
          >
            Manage records, consents, and audit trails across personal and juristic accounts.
          </Typography>
        </Box>
        <Box sx={{ position: 'relative', zIndex: 1 }}>
          <Typography
            sx={{
              fontSize: '0.7rem',
              color: '#475569',
              mb: 0.5,
            }}
          >
            v0.1b · Internal use only
          </Typography>
          <Typography
            sx={{
              fontSize: '0.65rem',
              color: '#374151',
            }}
          >
            © 2025–{new Date().getFullYear()} CIC Platform. All rights reserved.
          </Typography>
        </Box>
      </Box>

      {/* Right panel — form */}
      <Box
        sx={{
          flex: 1,
          display: 'flex',
          flexDirection: 'column',
          justifyContent: 'center',
          alignItems: 'center',
          p: { xs: 3, sm: 5 },
          bgcolor: '#ffffff',
        }}
      >
        <Box sx={{ width: '100%', maxWidth: 360 }}>
          {/* Mobile-only brand label */}
          <Typography
            sx={{
              display: { xs: 'block', md: 'none' },
              fontSize: '0.7rem',
              fontWeight: 600,
              letterSpacing: '0.08em',
              textTransform: 'uppercase',
              color: '#94a3b8',
              mb: 4,
            }}
          >
            CIC Platform
          </Typography>

          <Typography
            variant="h5"
            sx={{
              fontWeight: 600,
              color: '#0f172a',
              mb: 0.5,
            }}
          >
            Sign in
          </Typography>
          <Typography
            sx={{
              fontSize: '0.875rem',
              color: '#64748b',
              mb: 4,
            }}
          >
            Enter your credentials to continue
          </Typography>

          <form onSubmit={handleSubmit}>
            <TextField
              label="Username"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              fullWidth
              required
              autoFocus
              size="small"
              sx={{ mb: 2.5 }}
            />
            <TextField
              label="Password"
              type={showPassword ? 'text' : 'password'}
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              fullWidth
              required
              size="small"
              InputProps={{
                endAdornment: (
                  <InputAdornment position="end">
                    <IconButton
                      aria-label={showPassword ? 'Hide password' : 'Show password'}
                      onClick={() => setShowPassword(!showPassword)}
                      edge="end"
                      size="small"
                      tabIndex={-1}
                    >
                      {showPassword ? <VisibilityOff fontSize="small" /> : <Visibility fontSize="small" />}
                    </IconButton>
                  </InputAdornment>
                ),
              }}
              sx={{ mb: 3 }}
            />
            <Button
              type="submit"
              variant="contained"
              fullWidth
              disabled={loading}
              disableElevation
              sx={{
                py: 1.2,
                fontWeight: 600,
                fontSize: '0.875rem',
                textTransform: 'none',
                bgcolor: '#0f172a',
                color: '#ffffff',
                '&:hover': { bgcolor: '#1e293b' },
                borderRadius: 1,
              }}
            >
              {loading ? 'Signing in…' : 'Sign in'}
            </Button>
          </form>
        </Box>
      </Box>
    </Box>
    </ThemeProvider>
  );
};

export default LoginPage;
