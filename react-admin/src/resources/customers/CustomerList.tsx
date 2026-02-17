import { List, Datagrid, TextField, DateField, SelectField, SearchInput } from 'react-admin';

const customerFilters = [
    <SearchInput source="q" alwaysOn />
];

export const CustomerList = () => (
    <List filters={customerFilters}>
        <Datagrid rowClick="show">
            <TextField source="id" />
            <SelectField source="type" choices={[
                { id: 'PERSONAL', name: 'Personal' },
                { id: 'JURISTIC', name: 'Juristic' },
            ]} />
            <TextField source="first_name" label="First Name" />
            <TextField source="last_name" label="Last Name" />
            <TextField source="company_name" label="Company" />
            <SelectField source="status" choices={[
                { id: 'ACTIVE', name: 'Active' },
                { id: 'INACTIVE', name: 'Inactive' },
                { id: 'SUSPENDED', name: 'Suspended' },
                { id: 'BLACKLISTED', name: 'Blacklisted' },
            ]} />
            <DateField source="created_at" />
        </Datagrid>
    </List>
);
