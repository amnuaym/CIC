import { useGetIdentity, usePermissions, useNotify, Title } from 'react-admin';
import {
  Box, Card, CardContent, Typography, Grid, Chip, TextField,
  Button, InputAdornment, IconButton, Divider, ToggleButtonGroup, ToggleButton,
} from '@mui/material';
import Visibility from '@mui/icons-material/Visibility';
import VisibilityOff from '@mui/icons-material/VisibilityOff';
import LightModeIcon from '@mui/icons-material/LightMode';
import DarkModeIcon from '@mui/icons-material/DarkMode';
import SettingsBrightnessIcon from '@mui/icons-material/SettingsBrightness';
import { useState } from 'react';
import { useThemeMode } from '../ThemeContext';

const ProfilePage = () => {
  const { data: identity } = useGetIdentity();
  const { permissions } = usePermissions();
  const notify = useNotify();
  const { mode, setMode } = useThemeMode();

  const [currentPassword, setCurrentPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showCurrent, setShowCurrent] = useState(false);
  const [showNew, setShowNew] = useState(false);
  const [showConfirm, setShowConfirm] = useState(false);

  const user = JSON.parse(localStorage.getItem('user') || '{}');

  const handleChangePassword = (e: React.FormEvent) => {
    e.preventDefault();
    if (newPassword !== confirmPassword) {
      notify('New passwords do not match', { type: 'error' });
      return;
    }
    if (newPassword.length < 8) {
      notify('Password must be at least 8 characters', { type: 'error' });
      return;
    }
    notify('Password change is not yet implemented in the API', { type: 'info' });
    setCurrentPassword('');
    setNewPassword('');
    setConfirmPassword('');
  };

  const PasswordField = ({
    label, value, onChange, show, onToggle,
  }: {
    label: string; value: string; onChange: (v: string) => void;
    show: boolean; onToggle: () => void;
  }) => (
    <TextField
      label={label}
      type={show ? 'text' : 'password'}
      value={value}
      onChange={(e) => onChange(e.target.value)}
      fullWidth
      size="small"
      required
      InputProps={{
        endAdornment: (
          <InputAdornment position="end">
            <IconButton onClick={onToggle} edge="end" size="small" tabIndex={-1}
              aria-label={show ? 'Hide password' : 'Show password'}>
              {show ? <VisibilityOff fontSize="small" /> : <Visibility fontSize="small" />}
            </IconButton>
          </InputAdornment>
        ),
      }}
    />
  );

  return (
    <Box sx={{ maxWidth: 720, mx: 'auto', py: 2 }}>
      <Title title="Profile" />

      <Typography variant="h5" sx={{ mb: 3, fontWeight: 600 }}>
        Profile
      </Typography>

      {/* Account info */}
      <Card sx={{ mb: 3 }}>
        <CardContent sx={{ p: 3 }}>
          <Typography variant="subtitle1" sx={{ mb: 2 }}>
            Account information
          </Typography>
          <Grid container spacing={3}>
            <Grid item xs={12} sm={6}>
              <Box>
                <Typography variant="caption" color="text.secondary" sx={{ textTransform: 'uppercase', letterSpacing: '0.04em' }}>
                  Username
                </Typography>
                <Typography variant="body1" sx={{ fontWeight: 500 }}>
                  {user.username || identity?.fullName || '—'}
                </Typography>
              </Box>
            </Grid>
            <Grid item xs={12} sm={6}>
              <Box>
                <Typography variant="caption" color="text.secondary" sx={{ textTransform: 'uppercase', letterSpacing: '0.04em' }}>
                  Email
                </Typography>
                <Typography variant="body1" sx={{ fontWeight: 500 }}>
                  {user.email || '—'}
                </Typography>
              </Box>
            </Grid>
            <Grid item xs={12} sm={6}>
              <Box>
                <Typography variant="caption" color="text.secondary" sx={{ textTransform: 'uppercase', letterSpacing: '0.04em' }}>
                  Role
                </Typography>
                <Box sx={{ mt: 0.5 }}>
                  <Chip label={permissions || user.role || 'VIEWER'} size="small" color="primary" variant="outlined" />
                </Box>
              </Box>
            </Grid>
            <Grid item xs={12} sm={6}>
              <Box>
                <Typography variant="caption" color="text.secondary" sx={{ textTransform: 'uppercase', letterSpacing: '0.04em' }}>
                  User ID
                </Typography>
                <Typography variant="body2" sx={{ fontFamily: 'monospace', fontSize: '0.75rem', mt: 0.5 }}>
                  {user.id || identity?.id || '—'}
                </Typography>
              </Box>
            </Grid>
          </Grid>
        </CardContent>
      </Card>

      {/* Theme settings */}
      <Card sx={{ mb: 3 }}>
        <CardContent sx={{ p: 3 }}>
          <Typography variant="subtitle1" sx={{ mb: 0.5 }}>
            Appearance
          </Typography>
          <Typography variant="body2" color="text.secondary" sx={{ mb: 2.5 }}>
            Choose how CIC looks for you.
          </Typography>
          <ToggleButtonGroup
            value={mode}
            exclusive
            onChange={(_, newMode) => { if (newMode) setMode(newMode); }}
            size="small"
            sx={{
              '& .MuiToggleButton-root': {
                px: 2.5,
                py: 1,
                gap: 0.75,
                textTransform: 'none',
                fontSize: '0.8125rem',
                '&.Mui-selected': {
                  bgcolor: 'primary.main',
                  color: 'primary.contrastText',
                  '&:hover': { bgcolor: 'primary.dark' },
                },
              },
            }}
          >
            <ToggleButton value="light" aria-label="Light theme">
              <LightModeIcon fontSize="small" /> Light
            </ToggleButton>
            <ToggleButton value="dark" aria-label="Dark theme">
              <DarkModeIcon fontSize="small" /> Dark
            </ToggleButton>
            <ToggleButton value="system" aria-label="System theme">
              <SettingsBrightnessIcon fontSize="small" /> System
            </ToggleButton>
          </ToggleButtonGroup>
        </CardContent>
      </Card>

      {/* Change password */}
      <Card>
        <CardContent sx={{ p: 3 }}>
          <Typography variant="subtitle1" sx={{ mb: 0.5 }}>
            Change password
          </Typography>
          <Typography variant="body2" color="text.secondary" sx={{ mb: 2.5 }}>
            Use a strong password with at least 8 characters.
          </Typography>
          <Divider sx={{ mb: 2.5 }} />
          <form onSubmit={handleChangePassword}>
            <Grid container spacing={2}>
              <Grid item xs={12}>
                <PasswordField
                  label="Current password"
                  value={currentPassword}
                  onChange={setCurrentPassword}
                  show={showCurrent}
                  onToggle={() => setShowCurrent(!showCurrent)}
                />
              </Grid>
              <Grid item xs={12} sm={6}>
                <PasswordField
                  label="New password"
                  value={newPassword}
                  onChange={setNewPassword}
                  show={showNew}
                  onToggle={() => setShowNew(!showNew)}
                />
              </Grid>
              <Grid item xs={12} sm={6}>
                <PasswordField
                  label="Confirm new password"
                  value={confirmPassword}
                  onChange={setConfirmPassword}
                  show={showConfirm}
                  onToggle={() => setShowConfirm(!showConfirm)}
                />
              </Grid>
              <Grid item xs={12}>
                <Button type="submit" variant="contained" size="small" sx={{ mt: 1 }}>
                  Update password
                </Button>
              </Grid>
            </Grid>
          </form>
        </CardContent>
      </Card>
    </Box>
  );
};

export default ProfilePage;
