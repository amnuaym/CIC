import { Admin, Resource, Layout, LayoutProps, useLogout, useGetIdentity, usePermissions, CustomRoutes, useSidebarState } from 'react-admin';
import { Route, useNavigate } from 'react-router-dom';
import { dataProvider } from './dataProvider';
import { authProvider } from './authProvider';
import { cicLightTheme, cicDarkTheme } from './theme';
import { ThemeProvider, useThemeMode } from './ThemeContext';
import LoginPage from './LoginPage';
import ProfilePage from './pages/ProfilePage';
import Dashboard from './pages/Dashboard';
import PersonIcon from '@mui/icons-material/Person';
import BusinessIcon from '@mui/icons-material/Business';
import PrivacyTipIcon from '@mui/icons-material/PrivacyTip';
import HistoryIcon from '@mui/icons-material/History';
import AdminPanelSettingsIcon from '@mui/icons-material/AdminPanelSettings';
import AccountCircleIcon from '@mui/icons-material/AccountCircle';
import LogoutIcon from '@mui/icons-material/Logout';
import PaletteIcon from '@mui/icons-material/Palette';
import BadgeIcon from '@mui/icons-material/Badge';
import MenuIcon from '@mui/icons-material/Menu';
import MenuOpenIcon from '@mui/icons-material/MenuOpen';
import LightModeIcon from '@mui/icons-material/LightMode';
import DarkModeIcon from '@mui/icons-material/DarkMode';
import SettingsBrightnessIcon from '@mui/icons-material/SettingsBrightness';
import { IndividualList, IndividualEdit, IndividualCreate, IndividualShow } from './resources/individuals';
import { JuristicList, JuristicEdit, JuristicCreate, JuristicShow } from './resources/juristic';
import { ConsentList, ConsentShow } from './resources/consents';
import { AuditLogList, AuditLogShow } from './resources/auditLogs';
import { UserList, UserShow, UserCreate, UserEdit } from './resources/users';
import { Box, Typography, IconButton, Menu, MenuItem, ListItemIcon, ListItemText, Divider, Chip } from '@mui/material';
import { useState } from 'react';

// User menu dropdown
const UserMenu = () => {
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const [themeAnchorEl, setThemeAnchorEl] = useState<null | HTMLElement>(null);
  const { data: identity } = useGetIdentity();
  const { permissions } = usePermissions();
  const { mode, setMode } = useThemeMode();
  const logout = useLogout();
  const navigate = useNavigate();

  const handleOpen = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };
  const handleClose = () => { setAnchorEl(null); setThemeAnchorEl(null); };

  const handleThemeOpen = (event: React.MouseEvent<HTMLElement>) => {
    setThemeAnchorEl(event.currentTarget);
  };
  const handleThemeClose = () => setThemeAnchorEl(null);

  const handleThemeSelect = (newMode: 'light' | 'dark' | 'system') => {
    setMode(newMode);
    handleThemeClose();
  };

  const themeLabel = mode === 'light' ? 'Light' : mode === 'dark' ? 'Dark' : 'System';

  return (
    <>
      <IconButton
        onClick={handleOpen}
        size="small"
        aria-label="Account menu"
        sx={{ color: 'text.primary' }}
      >
        <AccountCircleIcon />
      </IconButton>
      <Menu
        anchorEl={anchorEl}
        open={Boolean(anchorEl)}
        onClose={handleClose}
        transformOrigin={{ horizontal: 'right', vertical: 'top' }}
        anchorOrigin={{ horizontal: 'right', vertical: 'bottom' }}
        PaperProps={{ sx: { minWidth: 200, mt: 1 } }}
      >
        <Box sx={{ px: 2, py: 1.5, borderBottom: '1px solid', borderColor: 'divider' }}>
          <Typography sx={{ fontSize: '0.8125rem', fontWeight: 600 }}>
            {identity?.fullName || 'User'}
          </Typography>
          <Chip
            label={permissions || 'VIEWER'}
            size="small"
            variant="outlined"
            sx={{ mt: 0.5, fontSize: '0.65rem', height: 20 }}
          />
        </Box>

        <MenuItem onClick={() => { handleClose(); navigate('/profile'); }} sx={{ py: 1.2 }}>
          <ListItemIcon><BadgeIcon fontSize="small" /></ListItemIcon>
          <ListItemText primaryTypographyProps={{ fontSize: '0.8125rem' }}>Profile</ListItemText>
        </MenuItem>

        <MenuItem onClick={handleThemeOpen} sx={{ py: 1.2 }}>
          <ListItemIcon><PaletteIcon fontSize="small" /></ListItemIcon>
          <ListItemText primaryTypographyProps={{ fontSize: '0.8125rem' }}>
            Theme
          </ListItemText>
          <Typography variant="caption" color="text.secondary" sx={{ ml: 1 }}>
            {themeLabel}
          </Typography>
        </MenuItem>

        <Divider />

        <MenuItem
          onClick={() => { handleClose(); logout(); }}
          sx={{ py: 1.2, color: 'error.main' }}
        >
          <ListItemIcon><LogoutIcon fontSize="small" sx={{ color: 'error.main' }} /></ListItemIcon>
          <ListItemText primaryTypographyProps={{ fontSize: '0.8125rem' }}>Log out</ListItemText>
        </MenuItem>
      </Menu>

      {/* Theme submenu */}
      <Menu
        anchorEl={themeAnchorEl}
        open={Boolean(themeAnchorEl)}
        onClose={handleThemeClose}
        anchorOrigin={{ horizontal: 'left', vertical: 'top' }}
        transformOrigin={{ horizontal: 'right', vertical: 'top' }}
        PaperProps={{ sx: { minWidth: 140 } }}
      >
        <MenuItem onClick={() => handleThemeSelect('light')} selected={mode === 'light'} sx={{ py: 1, gap: 1 }}>
          <LightModeIcon fontSize="small" />
          <ListItemText primaryTypographyProps={{ fontSize: '0.8125rem' }}>Light</ListItemText>
        </MenuItem>
        <MenuItem onClick={() => handleThemeSelect('dark')} selected={mode === 'dark'} sx={{ py: 1, gap: 1 }}>
          <DarkModeIcon fontSize="small" />
          <ListItemText primaryTypographyProps={{ fontSize: '0.8125rem' }}>Dark</ListItemText>
        </MenuItem>
        <MenuItem onClick={() => handleThemeSelect('system')} selected={mode === 'system'} sx={{ py: 1, gap: 1 }}>
          <SettingsBrightnessIcon fontSize="small" />
          <ListItemText primaryTypographyProps={{ fontSize: '0.8125rem' }}>System</ListItemText>
        </MenuItem>
      </Menu>
    </>
  );
};

// Sidebar toggle button
const SidebarToggle = () => {
  const [open, setOpen] = useSidebarState();
  return (
    <IconButton
      onClick={() => setOpen(!open)}
      size="small"
      aria-label={open ? 'Collapse sidebar' : 'Expand sidebar'}
      sx={{ color: 'text.secondary', mr: 1 }}
    >
      {open ? <MenuOpenIcon fontSize="small" /> : <MenuIcon fontSize="small" />}
    </IconButton>
  );
};

// Clickable app name
const AppBrand = () => {
  const navigate = useNavigate();
  return (
    <Box
      onClick={() => navigate('/')}
      sx={{ display: 'flex', alignItems: 'baseline', gap: 1.5, cursor: 'pointer', userSelect: 'none' }}
    >
      <Typography sx={{ fontSize: '0.875rem', fontWeight: 700, color: 'primary.main', letterSpacing: '-0.01em' }}>
        CIC
      </Typography>
      <Typography sx={{ fontSize: '0.65rem', color: 'text.secondary', fontWeight: 500, display: { xs: 'none', sm: 'block' } }}>
        v0.1b
      </Typography>
    </Box>
  );
};

// Custom layout
const CICLayout = (props: LayoutProps) => (
  <Layout
    {...props}
    sx={{
      '& .RaLayout-content': {
        padding: { xs: '12px', sm: '16px', md: '24px' },
        maxWidth: '100%',
        overflow: 'hidden',
      },
      '& .RaLayout-appFrame': { marginTop: '0px' },
      '& .RaSidebar-fixed': { paddingTop: '12px' },
      // Fix overflow on small screens
      '& .RaLayout-contentWithSidebar': {
        overflow: 'hidden',
      },
    }}
    appBar={() => (
      <Box
        sx={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          px: { xs: 1.5, sm: 3 },
          py: 1.5,
          bgcolor: 'background.paper',
          borderBottom: '1px solid',
          borderColor: 'divider',
          position: 'sticky',
          top: 0,
          zIndex: 1100,
          width: '100%',
          boxSizing: 'border-box',
        }}
      >
        <Box sx={{ display: 'flex', alignItems: 'center', minWidth: 0 }}>
          <SidebarToggle />
          <AppBrand />
        </Box>
        <Box sx={{ flexShrink: 0 }}>
          <UserMenu />
        </Box>
      </Box>
    )}
  />
);

// Inner app that reads theme context
const CICAdmin = () => {
  const { resolvedMode } = useThemeMode();
  const theme = resolvedMode === 'dark' ? cicDarkTheme : cicLightTheme;

  return (
    <Admin
      dataProvider={dataProvider}
      authProvider={authProvider}
      title="CIC Platform v0.1b"
      theme={theme}
      layout={CICLayout}
      loginPage={LoginPage}
      dashboard={Dashboard}
    >
      {(permissions: string) => [
        <CustomRoutes key="custom-routes">
          <Route path="/profile" element={<ProfilePage />} />
        </CustomRoutes>,
        <Resource
          key="individuals"
          name="individuals"
          list={IndividualList}
          edit={permissions !== 'VIEWER' ? IndividualEdit : undefined}
          create={permissions !== 'VIEWER' ? IndividualCreate : undefined}
          show={IndividualShow}
          icon={PersonIcon}
          options={{ label: 'Individuals' }}
        />,
        <Resource
          key="juristics"
          name="juristics"
          list={JuristicList}
          edit={permissions !== 'VIEWER' ? JuristicEdit : undefined}
          create={permissions !== 'VIEWER' ? JuristicCreate : undefined}
          show={JuristicShow}
          icon={BusinessIcon}
          options={{ label: 'Juristics' }}
        />,
        <Resource
          key="consents"
          name="consents"
          list={ConsentList}
          show={ConsentShow}
          icon={PrivacyTipIcon}
          options={{ label: 'Consents' }}
        />,
        <Resource
          key="audit-logs"
          name="audit-logs"
          list={AuditLogList}
          show={AuditLogShow}
          icon={HistoryIcon}
          options={{ label: 'Audit Logs' }}
        />,
        ...(permissions === 'SUPER_ADMIN' || permissions === 'ADMIN' ? [
          <Resource
            key="users"
            name="users"
            list={UserList}
            show={UserShow}
            create={permissions === 'SUPER_ADMIN' ? UserCreate : undefined}
            edit={permissions === 'SUPER_ADMIN' ? UserEdit : undefined}
            icon={AdminPanelSettingsIcon}
            options={{ label: 'Users' }}
          />,
        ] : []),
      ]}
    </Admin>
  );
};

// Root app wraps with ThemeProvider
const App = () => (
  <ThemeProvider>
    <CICAdmin />
  </ThemeProvider>
);

export default App;
