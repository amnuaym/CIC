import { Title } from 'react-admin';
import {
  Box, Card, CardContent, Typography, ToggleButtonGroup, ToggleButton,
} from '@mui/material';
import LightModeIcon from '@mui/icons-material/LightMode';
import DarkModeIcon from '@mui/icons-material/DarkMode';
import SettingsBrightnessIcon from '@mui/icons-material/SettingsBrightness';
import { useThemeMode } from '../ThemeContext';

const ThemePage = () => {
  const { mode, setMode } = useThemeMode();

  return (
    <Box sx={{ maxWidth: 720, mx: 'auto', py: 2 }}>
      <Title title="Theme" />

      <Typography variant="h5" sx={{ mb: 3, fontWeight: 600 }}>
        Theme
      </Typography>

      <Card>
        <CardContent sx={{ p: 3 }}>
          <Typography variant="subtitle1" sx={{ mb: 0.5 }}>
            Appearance
          </Typography>
          <Typography variant="body2" color="text.secondary" sx={{ mb: 3 }}>
            Choose how CIC looks for you. Select a single theme or sync with your system setting.
          </Typography>

          <ToggleButtonGroup
            value={mode}
            exclusive
            onChange={(_, newMode) => { if (newMode) setMode(newMode); }}
            sx={{
              display: 'flex',
              gap: 2,
              '& .MuiToggleButton-root': {
                flex: 1,
                flexDirection: 'column',
                gap: 1,
                py: 3,
                px: 3,
                border: '1px solid',
                borderColor: 'divider',
                borderRadius: '8px !important',
                textTransform: 'none',
                '&.Mui-selected': {
                  bgcolor: 'primary.main',
                  color: 'primary.contrastText',
                  borderColor: 'primary.main',
                  '&:hover': {
                    bgcolor: 'primary.dark',
                  },
                },
              },
            }}
          >
            <ToggleButton value="light" aria-label="Light theme">
              <LightModeIcon />
              <Typography variant="body2" sx={{ fontWeight: 600 }}>
                Light
              </Typography>
              <Typography variant="caption" sx={{ opacity: 0.7 }}>
                Clean and bright
              </Typography>
            </ToggleButton>

            <ToggleButton value="dark" aria-label="Dark theme">
              <DarkModeIcon />
              <Typography variant="body2" sx={{ fontWeight: 600 }}>
                Dark
              </Typography>
              <Typography variant="caption" sx={{ opacity: 0.7 }}>
                Easier on the eyes
              </Typography>
            </ToggleButton>

            <ToggleButton value="system" aria-label="System theme">
              <SettingsBrightnessIcon />
              <Typography variant="body2" sx={{ fontWeight: 600 }}>
                System
              </Typography>
              <Typography variant="caption" sx={{ opacity: 0.7 }}>
                Follow OS setting
              </Typography>
            </ToggleButton>
          </ToggleButtonGroup>

          <Typography variant="body2" color="text.secondary" sx={{ mt: 3 }}>
            Currently using: <strong>{mode === 'system' ? `System (resolves to ${window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'})` : mode}</strong>
          </Typography>
        </CardContent>
      </Card>

      <Card sx={{ mt: 3 }}>
        <CardContent sx={{ p: 3 }}>
          <Typography variant="subtitle1" sx={{ mb: 0.5 }}>
            Density
          </Typography>
          <Typography variant="body2" color="text.secondary">
            Data density and spacing preferences will be available in a future release.
          </Typography>
        </CardContent>
      </Card>
    </Box>
  );
};

export default ThemePage;
