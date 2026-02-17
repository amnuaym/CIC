import { Show, TabbedShowLayout, Tab, TextField, DateField, SelectField, Button, useRecordContext } from 'react-admin';
import DeleteIcon from '@mui/icons-material/Delete';
import { useNotify, useRefresh } from 'react-admin';
import { AddressList } from './components/AddressList';
import { IdentityList } from './components/IdentityList';
import { RelationshipList } from './components/RelationshipList';
import { ConsentList } from './components/ConsentList';

const AnonymizeButton = () => {
    const record = useRecordContext();
    const notify = useNotify();
    const refresh = useRefresh();

    if (!record) return null;

    const handleClick = () => {
        if (!window.confirm("Are you sure you want to ANONYMIZE this customer? This cannot be undone.")) return;

        // Custom fetch to /anonymize
        // Since dataProvider doesn't have custom method readily available as a standard verb, 
        // we might need to use fetch or extend dataProvider. 
        // Or assume we have a custom method. 
        // For now, let's use standard fetch pointing to API.
        const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8080/api/v1';
        fetch(`${apiUrl}/customers/${record.id}/anonymize`, { method: 'POST' })
            .then(() => {
                notify('Customer Anonymized', { type: 'success' });
                refresh();
            })
            .catch((e) => {
                notify('Error: ' + e.message, { type: 'error' });
            });
    };

    return (
        <Button label="Anonymize (PDPA)" onClick={handleClick} color="error">
            <DeleteIcon />
        </Button>
    );
};

export const CustomerShow = () => (
    <Show actions={<AnonymizeButton />}>
        <TabbedShowLayout>
            <Tab label="Summary">
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
                <DateField source="updated_at" />
            </Tab>
            <Tab label="Business Profile">
                <TextField source="membership_tier" />
                <TextField source="points_balance" />
                <TextField source="clv" />
                <TextField source="portfolio_size" />
                <DateField source="last_transaction_date" />
            </Tab>
            {/* Placeholders for sub-resources */}
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
                <ConsentList />
            </Tab>
        </TabbedShowLayout>
    </Show>
);
