import {
    List, Datagrid, TextField, DateField, SelectField, SearchInput,
    BooleanInput, useRecordContext, useDataProvider, useNotify, useRefresh,
    Button, Edit, TextInput, DateInput, SelectInput, required, TabbedForm, FormTab,
    Create, SimpleForm, Show, TabbedShowLayout, Tab
} from 'react-admin';
import RestoreFromTrashIcon from '@mui/icons-material/RestoreFromTrash';
import DeleteIcon from '@mui/icons-material/Delete';
import DownloadIcon from '@mui/icons-material/Download';
import { AddressList } from './customers/components/AddressList';
import { IdentityList } from './customers/components/IdentityList';
import { RelationshipList } from './customers/components/RelationshipList';
import { ConsentList as CustomerConsentList } from './customers/components/ConsentList';

// --- Restore Button ---
const RestoreButton = () => {
    const record = useRecordContext();
    const dataProvider = useDataProvider();
    const notify = useNotify();
    const refresh = useRefresh();

    if (!record || !record.deleted_at) return null;

    const handleClick = (e: any) => {
        e.stopPropagation();
        dataProvider.restore('individuals', { id: record.id })
            .then(() => { notify('Customer restored'); refresh(); })
            .catch((e: any) => { notify('Error: ' + e.message, { type: 'warning' }); });
    };

    return (
        <Button label="Restore" onClick={handleClick} color="primary">
            <RestoreFromTrashIcon />
        </Button>
    );
};

// --- Anonymize Button ---
const AnonymizeButton = () => {
    const record = useRecordContext();
    const notify = useNotify();
    const refresh = useRefresh();

    if (!record) return null;

    const handleClick = () => {
        if (!window.confirm('Are you sure you want to ANONYMIZE this customer? This cannot be undone.')) return;
        const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8080/api/v1';
        fetch(`${apiUrl}/customers/${record.id}/anonymize`, { method: 'POST' })
            .then(() => { notify('Customer Anonymized', { type: 'success' }); refresh(); })
            .catch((e) => { notify('Error: ' + e.message, { type: 'error' }); });
    };

    return (
        <Button label="Anonymize (PDPA)" onClick={handleClick} color="error">
            <DeleteIcon />
        </Button>
    );
};

// --- Export Data Button (BRD §2.4) ---
const ExportDataButton = () => {
    const record = useRecordContext();
    const notify = useNotify();

    if (!record) return null;

    const handleClick = () => {
        const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8080/api/v1';
        fetch(`${apiUrl}/customers/${record.id}/export`)
            .then(res => res.json())
            .then(data => {
                const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
                const url = URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = `customer_${record.id}_export.json`;
                a.click();
                URL.revokeObjectURL(url);
                notify('Data exported', { type: 'success' });
            })
            .catch((e) => { notify('Error: ' + e.message, { type: 'error' }); });
    };

    return (
        <Button label="Export Data" onClick={handleClick} color="primary">
            <DownloadIcon />
        </Button>
    );
};

const ShowActions = () => (
    <div style={{ display: 'flex', gap: 8 }}>
        <ExportDataButton />
        <AnonymizeButton />
    </div>
);

// --- Filters ---
const individualFilters = [
    <SearchInput source="q" alwaysOn />,
    <BooleanInput source="deleted" label="Show Deleted (Trash)" />,
];

// --- List ---
export const IndividualList = () => (
    <List filters={individualFilters} filter={{ type: 'PERSONAL' }}>
        <Datagrid rowClick="show">
            <TextField source="id" />
            <TextField source="title" label="Title" />
            <TextField source="first_name" label="First Name" />
            <TextField source="last_name" label="Last Name" />
            <SelectField source="status" choices={[
                { id: 'ACTIVE', name: 'Active' },
                { id: 'INACTIVE', name: 'Inactive' },
                { id: 'SUSPENDED', name: 'Suspended' },
                { id: 'BLACKLISTED', name: 'Blacklisted' },
                { id: 'DECEASED', name: 'Deceased' },
            ]} />
            <TextField source="nationality" />
            <DateField source="created_at" />
            <RestoreButton />
        </Datagrid>
    </List>
);

// --- Create ---
export const IndividualCreate = () => (
    <Create>
        <SimpleForm>
            <TextInput source="title" label="Title" />
            <TextInput source="first_name" label="First Name" validate={required()} fullWidth />
            <TextInput source="last_name" label="Last Name" validate={required()} fullWidth />
            <DateInput source="date_of_birth" label="Date of Birth" />
            <TextInput source="nationality" label="Nationality" />
            <SelectInput source="status" choices={[
                { id: 'ACTIVE', name: 'Active' },
                { id: 'INACTIVE', name: 'Inactive' },
            ]} defaultValue="ACTIVE" />
        </SimpleForm>
    </Create>
);

// --- Edit ---
export const IndividualEdit = () => (
    <Edit>
        <TabbedForm>
            <FormTab label="Profile">
                <TextInput source="id" disabled />
                <TextInput source="title" label="Title" />
                <TextInput source="first_name" label="First Name" validate={required()} fullWidth />
                <TextInput source="last_name" label="Last Name" validate={required()} fullWidth />
                <DateInput source="date_of_birth" label="Date of Birth" />
                <TextInput source="nationality" label="Nationality" />
                <SelectInput source="status" choices={[
                    { id: 'ACTIVE', name: 'Active' },
                    { id: 'INACTIVE', name: 'Inactive' },
                    { id: 'SUSPENDED', name: 'Suspended' },
                    { id: 'BLACKLISTED', name: 'Blacklisted' },
                    { id: 'DECEASED', name: 'Deceased' },
                ]} validate={required()} />
            </FormTab>
            <FormTab label="Business Profile">
                <TextInput source="membership_tier" />
                <TextInput source="points_balance" disabled />
                <TextInput source="clv" label="Lifetime Value" disabled />
                <TextInput source="portfolio_size" disabled />
                <DateInput source="last_transaction_date" disabled />
            </FormTab>
        </TabbedForm>
    </Edit>
);

// --- Show ---
export const IndividualShow = () => (
    <Show actions={<ShowActions />}>
        <TabbedShowLayout>
            <Tab label="Profile">
                <TextField source="id" />
                <TextField source="title" />
                <TextField source="first_name" label="First Name" />
                <TextField source="last_name" label="Last Name" />
                <DateField source="date_of_birth" label="Date of Birth" />
                <TextField source="nationality" />
                <SelectField source="status" choices={[
                    { id: 'ACTIVE', name: 'Active' },
                    { id: 'INACTIVE', name: 'Inactive' },
                    { id: 'SUSPENDED', name: 'Suspended' },
                    { id: 'BLACKLISTED', name: 'Blacklisted' },
                    { id: 'DECEASED', name: 'Deceased' },
                ]} />
                <DateField source="created_at" />
                <DateField source="updated_at" />
            </Tab>
            <Tab label="Business Profile">
                <TextField source="membership_tier" />
                <TextField source="points_balance" />
                <TextField source="clv" label="Lifetime Value" />
                <TextField source="portfolio_size" />
                <DateField source="last_transaction_date" />
            </Tab>
            <Tab label="Addresses">
                <AddressList />
            </Tab>
            <Tab label="Identities">
                <IdentityList />
            </Tab>
            <Tab label="Relationships">
                <RelationshipList />
            </Tab>
            <Tab label="Consents (PDPA)">
                <CustomerConsentList />
            </Tab>
        </TabbedShowLayout>
    </Show>
);
