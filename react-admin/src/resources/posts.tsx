import {
  List,
  Datagrid,
  TextField,
  DateField,
  Edit,
  Create,
  SimpleForm,
  TextInput,
  SelectInput,
  required,
} from 'react-admin';

export const PostList = () => (
  <List>
    <Datagrid rowClick="edit">
      <TextField source="id" />
      <TextField source="title" />
      <TextField source="status" />
      <DateField source="created_at" />
      <DateField source="updated_at" />
    </Datagrid>
  </List>
);

export const PostEdit = () => (
  <Edit>
    <SimpleForm>
      <TextInput source="id" disabled />
      <TextInput source="title" validate={[required()]} fullWidth />
      <TextInput source="content" multiline rows={5} fullWidth />
      <SelectInput
        source="status"
        choices={[
          { id: 'draft', name: 'Draft' },
          { id: 'published', name: 'Published' },
          { id: 'archived', name: 'Archived' },
        ]}
      />
    </SimpleForm>
  </Edit>
);

export const PostCreate = () => (
  <Create>
    <SimpleForm>
      <TextInput source="title" validate={[required()]} fullWidth />
      <TextInput source="content" multiline rows={5} fullWidth />
      <SelectInput
        source="status"
        choices={[
          { id: 'draft', name: 'Draft' },
          { id: 'published', name: 'Published' },
          { id: 'archived', name: 'Archived' },
        ]}
        defaultValue="draft"
      />
    </SimpleForm>
  </Create>
);
