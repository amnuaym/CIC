import { Admin, Resource, Layout, LayoutProps } from 'react-admin';
import { dataProvider } from './dataProvider';
import { authProvider } from './authProvider';
import PersonIcon from '@mui/icons-material/Person';
import BusinessIcon from '@mui/icons-material/Business';
import PrivacyTipIcon from '@mui/icons-material/PrivacyTip';
import HistoryIcon from '@mui/icons-material/History';
import AdminPanelSettingsIcon from '@mui/icons-material/AdminPanelSettings';
import { IndividualList, IndividualEdit, IndividualCreate, IndividualShow } from './resources/individuals';
import { JuristicList, JuristicEdit, JuristicCreate, JuristicShow } from './resources/juristic';
import { ConsentList, ConsentShow } from './resources/consents';
import { AuditLogList, AuditLogShow } from './resources/auditLogs';
import { UserList, UserShow, UserCreate, UserEdit } from './resources/users';

// Custom layout with collapsible sidebar
const CICLayout = (props: LayoutProps) => <Layout {...props} />;

const App = () => (
  <Admin
    dataProvider={dataProvider}
    authProvider={authProvider}
    title="CIC Platform v2.0"
    layout={CICLayout}
  >
    {(permissions: string) => [
      /* All authenticated users see customer menus */
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
      /* Users menu: ADMIN+ can see, SUPER_ADMIN gets full CRUD */
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

export default App;
