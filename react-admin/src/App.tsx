import { Admin, Resource } from 'react-admin';
import { dataProvider } from './dataProvider';
import { authProvider } from './authProvider';
import PostIcon from '@mui/icons-material/Book';
import UserIcon from '@mui/icons-material/Group';
import { PostList, PostEdit, PostCreate } from './resources/posts';
import { UserList, UserShow } from './resources/users';
import { CustomerList, CustomerEdit, CustomerCreate, CustomerShow } from './resources/customers';

const App = () => (
  <Admin
    dataProvider={dataProvider}
    authProvider={authProvider}
    title="Backend Template Admin"
  >
    <Resource
      name="customers"
      list={CustomerList}
      edit={CustomerEdit}
      create={CustomerCreate}
      show={CustomerShow}
      icon={UserIcon}
    />
    <Resource
      name="posts"
      list={PostList}
      edit={PostEdit}
      create={PostCreate}
      icon={PostIcon}
    />
    <Resource
      name="users"
      list={UserList}
      show={UserShow}
      icon={UserIcon}
    />
  </Admin>
);

export default App;
