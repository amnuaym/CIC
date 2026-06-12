import { useGetIdentity, usePermissions, Title } from 'react-admin';
import { useNavigate } from 'react-router-dom';
import {
  Box, Card, CardContent, CardActionArea, Typography, Grid, Chip,
} from '@mui/material';
import PersonIcon from '@mui/icons-material/Person';
import BusinessIcon from '@mui/icons-material/Business';
import PrivacyTipIcon from '@mui/icons-material/PrivacyTip';
import HistoryIcon from '@mui/icons-material/History';
import AdminPanelSettingsIcon from '@mui/icons-material/AdminPanelSettings';
import SearchIcon from '@mui/icons-material/Search';

const QuickLink = ({ icon, label, description, path }: {
  icon: React.ReactNode; label: string; description: string; path: string;
}) => {
  const navigate = useNavigate();
  return (
    <Card sx={{ height: '100%' }}>
      <CardActionArea onClick={() => navigate(path)} sx={{ p: 2.5, height: '100%', display: 'flex', flexDirection: 'column', alignItems: 'flex-start', justifyContent: 'flex-start' }}>
        <Box sx={{ color: 'secondary.main', mb: 1.5 }}>{icon}</Box>
        <Typography variant="subtitle1" sx={{ mb: 0.5 }}>{label}</Typography>
        <Typography variant="body2" color="text.secondary">{description}</Typography>
      </CardActionArea>
    </Card>
  );
};

const Dashboard = () => {
  const { data: identity } = useGetIdentity();
  const { permissions } = usePermissions();

  const hour = new Date().getHours();
  const greeting = hour < 12 ? 'Good morning' : hour < 18 ? 'Good afternoon' : 'Good evening';

  return (
    <Box sx={{ maxWidth: 960, mx: 'auto', py: 2 }}>
      <Title title="Dashboard" />

      {/* Greeting */}
      <Box sx={{ mb: 4 }}>
        <Typography variant="h5" sx={{ fontWeight: 600, mb: 0.5 }}>
          {greeting}, {identity?.fullName || 'there'}
        </Typography>
        <Typography variant="body2" color="text.secondary">
          Customer Information Center · {new Date().toLocaleDateString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })}
        </Typography>
      </Box>

      {/* Quick stats */}
      <Grid container spacing={2} sx={{ mb: 4 }}>
        <Grid item xs={6} sm={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center', py: 2 }}>
              <Typography variant="caption" color="text.secondary" sx={{ textTransform: 'uppercase', letterSpacing: '0.04em' }}>
                Your role
              </Typography>
              <Box sx={{ mt: 0.5 }}>
                <Chip label={permissions || 'VIEWER'} size="small" color="primary" variant="outlined" />
              </Box>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={6} sm={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center', py: 2 }}>
              <Typography variant="caption" color="text.secondary" sx={{ textTransform: 'uppercase', letterSpacing: '0.04em' }}>
                Version
              </Typography>
              <Typography variant="body1" sx={{ fontWeight: 600, mt: 0.5 }}>v0.1b</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={6} sm={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center', py: 2 }}>
              <Typography variant="caption" color="text.secondary" sx={{ textTransform: 'uppercase', letterSpacing: '0.04em' }}>
                Environment
              </Typography>
              <Typography variant="body1" sx={{ fontWeight: 600, mt: 0.5 }}>Development</Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={6} sm={3}>
          <Card>
            <CardContent sx={{ textAlign: 'center', py: 2 }}>
              <Typography variant="caption" color="text.secondary" sx={{ textTransform: 'uppercase', letterSpacing: '0.04em' }}>
                API Status
              </Typography>
              <Typography variant="body1" sx={{ fontWeight: 600, mt: 0.5, color: 'success.main' }}>Healthy</Typography>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      {/* Quick navigation */}
      <Typography variant="subtitle1" sx={{ mb: 2 }}>Quick access</Typography>
      <Grid container spacing={2}>
        <Grid item xs={12} sm={6} md={4}>
          <QuickLink
            icon={<SearchIcon />}
            label="Search customers"
            description="Find individual or juristic records"
            path="/individuals"
          />
        </Grid>
        <Grid item xs={12} sm={6} md={4}>
          <QuickLink
            icon={<PersonIcon />}
            label="Individuals"
            description="Personal customer records"
            path="/individuals"
          />
        </Grid>
        <Grid item xs={12} sm={6} md={4}>
          <QuickLink
            icon={<BusinessIcon />}
            label="Juristics"
            description="Corporate and company records"
            path="/juristics"
          />
        </Grid>
        <Grid item xs={12} sm={6} md={4}>
          <QuickLink
            icon={<PrivacyTipIcon />}
            label="Consents"
            description="PDPA consent management"
            path="/consents"
          />
        </Grid>
        <Grid item xs={12} sm={6} md={4}>
          <QuickLink
            icon={<HistoryIcon />}
            label="Audit logs"
            description="Activity and change history"
            path="/audit-logs"
          />
        </Grid>
        {(permissions === 'SUPER_ADMIN' || permissions === 'ADMIN') && (
          <Grid item xs={12} sm={6} md={4}>
            <QuickLink
              icon={<AdminPanelSettingsIcon />}
              label="User management"
              description="Manage accounts and roles"
              path="/users"
            />
          </Grid>
        )}
      </Grid>
    </Box>
  );
};

export default Dashboard;
