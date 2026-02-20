import {
  List,
  Datagrid,
  TextField,
  EmailField,
  BooleanField,
  DateField,
  Show,
  SimpleShowLayout,
  SearchInput,
} from 'react-admin';

const userFilters = [
  <SearchInput source="q" alwaysOn />,
];

export const UserList = () => (
  <List filters={userFilters}>
    <Datagrid rowClick="show">
      <TextField source="id" />
      <TextField source="username" />
      <EmailField source="email" />
      <TextField source="role" />
      <BooleanField source="is_active" />
      <DateField source="created_at" />
    </Datagrid>
  </List>
);

export const UserShow = () => (
  <Show>
    <SimpleShowLayout>
      <TextField source="id" />
      <TextField source="username" />
      <EmailField source="email" />
      <TextField source="role" />
      <BooleanField source="is_active" />
      <DateField source="created_at" showTime />
      <DateField source="updated_at" showTime />
    </SimpleShowLayout>
  </Show>
);
