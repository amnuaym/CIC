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
  Create,
  SimpleForm,
  TextInput,
  SelectInput,
  Edit,
  BooleanInput,
  ReferenceInput,
  AutocompleteInput,
  usePermissions,
  TopToolbar,
  CreateButton,
  EditButton,
} from 'react-admin';

// Role choices matching Go backend constants
const roleChoices = [
  { id: 'SUPER_ADMIN', name: 'Super Admin' },
  { id: 'ADMIN', name: 'Admin' },
  { id: 'OPERATOR', name: 'Operator' },
  { id: 'VIEWER', name: 'Viewer' },
];

// --- Filters ---
const userFilters = [
  <SearchInput source="q" alwaysOn />,
];

// --- Custom List Actions (only SUPER_ADMIN sees Create button) ---
const UserListActions = () => {
  const { permissions } = usePermissions();
  return (
    <TopToolbar>
      {permissions === 'SUPER_ADMIN' && <CreateButton />}
    </TopToolbar>
  );
};

// --- List ---
export const UserList = () => {
  const { permissions } = usePermissions();
  return (
    <List filters={userFilters} actions={<UserListActions />}>
      <Datagrid rowClick="show">
        <TextField source="id" />
        <TextField source="username" />
        <EmailField source="email" />
        <TextField source="role" />
        <BooleanField source="is_active" label="Active" />
        <DateField source="created_at" label="Created" />
        {permissions === 'SUPER_ADMIN' && <EditButton />}
      </Datagrid>
    </List>
  );
};

// --- Show ---
export const UserShow = () => (
  <Show>
    <SimpleShowLayout>
      <TextField source="id" />
      <TextField source="username" />
      <EmailField source="email" />
      <TextField source="role" />
      <BooleanField source="is_active" label="Active" />
      <DateField source="created_at" label="Created" showTime />
      <DateField source="updated_at" label="Updated" showTime />
    </SimpleShowLayout>
  </Show>
);

// --- Create (SUPER_ADMIN only) ---
export const UserCreate = () => (
  <Create>
    <SimpleForm>
      <TextInput source="username" required />
      <TextInput source="email" type="email" required />
      <TextInput source="password" type="password" required />
      <SelectInput source="role" choices={roleChoices} required />
      <ReferenceInput source="supervisor_id" reference="users" allowEmpty>
        <AutocompleteInput optionText="username" />
      </ReferenceInput>
    </SimpleForm>
  </Create>
);

// --- Edit (SUPER_ADMIN only) ---
export const UserEdit = () => (
  <Edit>
    <SimpleForm>
      <TextInput source="username" disabled />
      <TextInput source="email" type="email" />
      <SelectInput source="role" choices={roleChoices} />
      <BooleanInput source="is_active" label="Active" />
      <ReferenceInput source="supervisor_id" reference="users" allowEmpty>
        <AutocompleteInput optionText="username" />
      </ReferenceInput>
    </SimpleForm>
  </Edit>
);
