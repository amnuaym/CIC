import { 
    List, Datagrid, TextField, DateField, SelectField, SearchInput, 
    BooleanInput, useRecordContext, useDataProvider, useNotify, useRefresh, 
    Button
} from 'react-admin';
import RestoreFromTrashIcon from '@mui/icons-material/RestoreFromTrash';

const RestoreButton = () => {
    const record = useRecordContext();
    const dataProvider = useDataProvider();
    const notify = useNotify();
    const refresh = useRefresh();

    if (!record || !record.deleted_at) return null;

    const handleClick = (e: any) => {
        e.stopPropagation();
        dataProvider.restore('customers', { id: record.id })
            .then(() => {
                notify('Customer restored');
                refresh();
            })
            .catch((e: any) => {
                notify('Error: ' + e.message, { type: 'warning' });
            });
    };

    return (
        <Button label="Restore" onClick={handleClick} color="primary">
            <RestoreFromTrashIcon />
        </Button>
    );
};

const customerFilters = [
    <SearchInput source="q" alwaysOn />,
    <BooleanInput source="deleted" label="Show Deleted (Trash)" />
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
            <RestoreButton />
        </Datagrid>
    </List>
);
