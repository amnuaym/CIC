import { defaultTheme } from 'react-admin';
import { createTheme } from '@mui/material/styles';

/**
 * CIC Enterprise Theme
 * 
 * Design direction: Institutional precision meets modern clarity.
 * Palette drawn from financial services vernacular — slate blues,
 * controlled accent, high contrast for data-dense screens.
 */

const lightPalette = {
  primary: '#1e3a5f',
  accent: '#0d9488',
  surface: '#f8fafc',
  background: '#ffffff',
  textPrimary: '#1e293b',
  textSecondary: '#64748b',
  border: '#e2e8f0',
  sidebarBg: '#1e293b',
  sidebarText: '#cbd5e1',
  sidebarActive: '#0d9488',
};

const darkPalette = {
  primary: '#60a5fa',
  accent: '#2dd4bf',
  surface: '#0f172a',
  background: '#1e293b',
  textPrimary: '#f1f5f9',
  textSecondary: '#94a3b8',
  border: '#334155',
  sidebarBg: '#0f172a',
  sidebarText: '#94a3b8',
  sidebarActive: '#2dd4bf',
};

const buildTheme = (mode: 'light' | 'dark') => {
  const p = mode === 'dark' ? darkPalette : lightPalette;

  return createTheme({
    ...defaultTheme,
    palette: {
      mode,
      primary: {
        main: p.primary,
        contrastText: mode === 'dark' ? '#0f172a' : '#ffffff',
      },
      secondary: {
        main: p.accent,
        contrastText: '#ffffff',
      },
      background: {
        default: p.surface,
        paper: p.background,
      },
      text: {
        primary: p.textPrimary,
        secondary: p.textSecondary,
      },
      divider: p.border,
      error: { main: '#dc2626' },
      warning: { main: '#d97706' },
      success: { main: '#16a34a' },
      info: { main: '#2563eb' },
    },
    typography: {
      fontFamily: '"Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif',
      h4: { fontWeight: 700, letterSpacing: '-0.02em' },
      h5: { fontWeight: 600, letterSpacing: '-0.01em' },
      h6: { fontWeight: 600, fontSize: '1rem' },
      subtitle1: { fontWeight: 600, fontSize: '0.875rem' },
      body1: { fontSize: '0.875rem', lineHeight: 1.6 },
      body2: { fontSize: '0.8rem', lineHeight: 1.5 },
      caption: { fontSize: '0.7rem', letterSpacing: '0.04em' },
      button: { textTransform: 'none' as const, fontWeight: 600 },
    },
    shape: {
      borderRadius: 6,
    },
    components: {
      MuiCssBaseline: {
        styleOverrides: {
          body: { backgroundColor: p.surface },
        },
      },
      MuiAppBar: {
        styleOverrides: {
          root: {
            backgroundColor: p.background,
            color: p.textPrimary,
            boxShadow: `0 1px 0 ${p.border}`,
          },
        },
      },
      MuiDrawer: {
        styleOverrides: {
          paper: {
            backgroundColor: p.sidebarBg,
            color: p.sidebarText,
            borderRight: 'none',
          },
        },
      },
      MuiCard: {
        defaultProps: { elevation: 0 },
        styleOverrides: {
          root: { border: `1px solid ${p.border}`, borderRadius: 8 },
        },
      },
      MuiButton: {
        defaultProps: { disableElevation: true },
        styleOverrides: {
          root: { borderRadius: 6, padding: '6px 16px', fontSize: '0.8125rem' },
        },
      },
      MuiTextField: {
        defaultProps: { size: 'small' as const, variant: 'outlined' as const },
        styleOverrides: {
          root: {
            '& .MuiOutlinedInput-root': { borderRadius: 6, fontSize: '0.875rem' },
          },
        },
      },
      MuiTableHead: {
        styleOverrides: {
          root: {
            '& .MuiTableCell-head': {
              fontWeight: 600,
              fontSize: '0.75rem',
              textTransform: 'uppercase' as const,
              letterSpacing: '0.04em',
              color: p.textSecondary,
              backgroundColor: p.surface,
              borderBottom: `2px solid ${p.border}`,
              padding: '10px 16px',
            },
          },
        },
      },
      MuiTableCell: {
        styleOverrides: {
          root: { fontSize: '0.8125rem', padding: '10px 16px', borderBottom: `1px solid ${p.border}` },
        },
      },
      MuiTableRow: {
        styleOverrides: {
          root: { '&:hover': { backgroundColor: `${p.surface} !important` } },
        },
      },
      MuiChip: {
        styleOverrides: { root: { fontWeight: 600, fontSize: '0.7rem', height: 24 } },
      },
      MuiTab: {
        styleOverrides: {
          root: { textTransform: 'none' as const, fontWeight: 500, fontSize: '0.8125rem', minHeight: 42 },
        },
      },
      MuiListItemButton: {
        styleOverrides: {
          root: {
            borderRadius: 6,
            margin: '2px 8px',
            '&.Mui-selected': {
              backgroundColor: `${p.sidebarActive}20`,
              color: '#ffffff',
              '&:hover': { backgroundColor: `${p.sidebarActive}30` },
              '& .MuiListItemIcon-root': { color: p.sidebarActive },
            },
            '& .MuiListItemIcon-root': { color: p.sidebarText, minWidth: 36 },
          },
        },
      },
      MuiListItemText: {
        styleOverrides: { primary: { fontSize: '0.8125rem', fontWeight: 500 } },
      },
      MuiToolbar: {
        styleOverrides: { root: { minHeight: '52px !important' } },
      },
      MuiTableContainer: {
        styleOverrides: { root: { overflowX: 'auto' as const } },
      },
    },
  });
};

export const cicLightTheme = buildTheme('light');
export const cicDarkTheme = buildTheme('dark');
// Default export for backward compat
export const cicTheme = cicLightTheme;
