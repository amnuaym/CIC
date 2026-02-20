import { Admin, Resource } from 'react-admin';
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
import { UserList, UserShow } from './resources/users';

const App = () => (
  <Admin
    dataProvider={dataProvider}
    authProvider={authProvider}
    title="CIC Admin"
  >
    <Resource
      name="individuals"
      list={IndividualList}
      edit={IndividualEdit}
      create={IndividualCreate}
      show={IndividualShow}
      icon={PersonIcon}
      options={{ label: 'Individuals' }}
    />
    <Resource
      name="juristic"
      list={JuristicList}
      edit={JuristicEdit}
      create={JuristicCreate}
      show={JuristicShow}
      icon={BusinessIcon}
      options={{ label: 'Juristic' }}
    />
    <Resource
      name="consents"
      list={ConsentList}
      show={ConsentShow}
      icon={PrivacyTipIcon}
      options={{ label: 'Consents' }}
    />
    <Resource
      name="audit-logs"
      list={AuditLogList}
      show={AuditLogShow}
      icon={HistoryIcon}
      options={{ label: 'Audit Logs' }}
    />
    <Resource
      name="users"
      list={UserList}
      show={UserShow}
      icon={AdminPanelSettingsIcon}
      options={{ label: 'Users' }}
    />
  </Admin>
);

export default App;
