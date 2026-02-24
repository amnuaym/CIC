import {
    List, Datagrid, TextField, DateField, SelectField, SearchInput,
    BooleanInput, useRecordContext, useDataProvider, useNotify, useRefresh,
    Button, Edit, TextInput, DateInput, SelectInput, required, TabbedForm, FormTab,
    Create, SimpleForm, Show, useShowContext, TopToolbar, ListButton, EditButton,
    CreateButton, ExportButton, FilterLiveSearch
} from 'react-admin';
import RestoreFromTrashIcon from '@mui/icons-material/RestoreFromTrash';
import DeleteIcon from '@mui/icons-material/Delete';
import DownloadIcon from '@mui/icons-material/Download';
import {
    Card, CardContent, Typography, Grid, Chip, Box, Divider
} from '@mui/material';
import { AddressList } from './customers/components/AddressList';
import { IdentityList } from './customers/components/IdentityList';
import { RelationshipList } from './customers/components/RelationshipList';
import { ConsentList as CustomerConsentList } from './customers/components/ConsentList';
import { ActivityLog } from './customers/components/ActivityLog';

// --- Status Config ---
const statusConfig: Record<string, { color: 'success' | 'error' | 'warning' | 'info' | 'default'; label: string }> = {
    ACTIVE: { color: 'success', label: 'Active' },
    INACTIVE: { color: 'default', label: 'Inactive' },
    SUSPENDED: { color: 'warning', label: 'Suspended' },
    BLACKLISTED: { color: 'error', label: 'Blacklisted' },
};

// --- Restore Button ---
const RestoreButton = () => {
    const record = useRecordContext();
    const dataProvider = useDataProvider();
    const notify = useNotify();
    const refresh = useRefresh();

    if (!record || !record.deleted_at) return null;

    const handleClick = (e: any) => {
        e.stopPropagation();
        dataProvider.restore('juristics', { id: record.id })
            .then(() => { notify('Company restored'); refresh(); })
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
        if (!window.confirm('Are you sure you want to ANONYMIZE this company? This cannot be undone.')) return;
        const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8080/api/v1';
        const token = localStorage.getItem('token');
        fetch(`${apiUrl}/customers/${record.id}/anonymize`, {
            method: 'POST',
            headers: token ? { Authorization: `Bearer ${token}` } : {},
        })
            .then(() => { notify('Company Anonymized', { type: 'success' }); refresh(); })
            .catch((e) => { notify('Error: ' + e.message, { type: 'error' }); });
    };

    return (
        <Button label="Anonymize (PDPA)" onClick={handleClick} color="error">
            <DeleteIcon />
        </Button>
    );
};

// --- Export Data Button ---
const ExportDataButton = () => {
    const record = useRecordContext();
    const notify = useNotify();

    if (!record) return null;

    const handleClick = () => {
        const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8080/api/v1';
        const token = localStorage.getItem('token');
        fetch(`${apiUrl}/customers/${record.id}/export`, {
            headers: token ? { Authorization: `Bearer ${token}` } : {},
        })
            .then(res => res.json())
            .then(data => {
                const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
                const url = URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = `company_${record.id}_export.json`;
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

// --- Helper: Detail Field ---
const DetailField = ({ label, value }: { label: string; value: any }) => (
    <Box sx={{ mb: 1.5 }}>
        <Typography variant="caption" color="text.secondary" sx={{ textTransform: 'uppercase', fontSize: '0.7rem', letterSpacing: 0.5 }}>
            {label}
        </Typography>
        <Typography variant="body1" sx={{ fontWeight: 500 }}>
            {value || '—'}
        </Typography>
    </Box>
);

// --- Section Header ---
const SectionHeader = ({ title }: { title: string }) => (
    <Box sx={{ mb: 2, mt: 3 }}>
        <Typography variant="h6" sx={{ fontWeight: 600, color: 'primary.main' }}>
            {title}
        </Typography>
        <Divider sx={{ mt: 0.5 }} />
    </Box>
);

// --- Filters ---
const juristicFilters = [
    <SearchInput source="q" />,
    <BooleanInput source="deleted" label="Show Deleted (Trash)" />,
];

const statusChoices = [
    { id: 'ACTIVE', name: 'Active' },
    { id: 'INACTIVE', name: 'Inactive' },
    { id: 'SUSPENDED', name: 'Suspended' },
    { id: 'BLACKLISTED', name: 'Blacklisted' },
];

// --- Empty State ---
const EmptyList = () => (
    <Box sx={{ textAlign: 'center', py: 12, border: '1px dashed', borderColor: 'divider', borderRadius: 2, bgcolor: 'background.paper', mt: 2 }}>
        <Typography variant="h6" color="primary" gutterBottom sx={{ fontWeight: 700 }}>
            Juristics: Start by searching (V2.1)
        </Typography>
        <Typography variant="body2" color="text.secondary">
            Use the search box in the top-left toolbar to find records, or use <strong>*</strong> to show all.
        </Typography>
    </Box>
);

// --- List Actions (Toolbar) ---
const JuristicListActions = () => (
    <TopToolbar sx={{ justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
        <FilterLiveSearch source="q" label="Search Companies..." sx={{ minWidth: 300 }} />
        <Box sx={{ display: 'flex', gap: 1 }}>
            <CreateButton />
            <ExportButton />
        </Box>
    </TopToolbar>
);

// --- List ---
export const JuristicList = () => (
    <List 
        actions={<JuristicListActions />} 
        filters={juristicFilters}
        filter={{ type: 'JURISTIC' }}
    >
        <Datagrid rowClick="show" empty={<EmptyList />}>
            <TextField source="id" />
            <TextField source="company_name" label="Company Name" />
            <TextField source="industry_code" label="Industry" />
            <SelectField source="status" choices={statusChoices} />
            <DateField source="registration_date" label="Registered" />
            <DateField source="created_at" />
            <RestoreButton />
        </Datagrid>
    </List>
);

// --- Create ---
export const JuristicCreate = () => (
    <Create>
        <SimpleForm>
            <TextInput source="company_name" label="Company Name" validate={required()} fullWidth />
            <DateInput source="registration_date" label="Registration Date" />
            <TextInput source="industry_code" label="Industry Code" />
            <SelectInput source="status" choices={[
                { id: 'ACTIVE', name: 'Active' },
                { id: 'INACTIVE', name: 'Inactive' },
            ]} defaultValue="ACTIVE" />
        </SimpleForm>
    </Create>
);

// --- Edit ---
export const JuristicEdit = () => (
    <Edit>
        <TabbedForm>
            <FormTab label="Company Info">
                <TextInput source="id" disabled />
                <TextInput source="company_name" label="Company Name" validate={required()} fullWidth />
                <DateInput source="registration_date" label="Registration Date" />
                <TextInput source="industry_code" label="Industry Code" />
                <SelectInput source="status" choices={statusChoices} validate={required()} />
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

// --- Show (Detail Page) ---
const JuristicDetail = () => {
    const { record, isLoading } = useShowContext();

    if (isLoading || !record) return null;

    const status = statusConfig[record.status] || { color: 'default' as const, label: record.status };

    return (
        <Box sx={{ width: '100%' }}>
            {/* === Company Header Card === */}
            <Card sx={{ mb: 3 }}>
                <CardContent sx={{ p: 3 }}>
                    <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', mb: 2 }}>
                        <Box>
                            <Typography variant="h4" sx={{ fontWeight: 700, mb: 0.5 }}>
                                {record.company_name}
                            </Typography>
                            <Typography variant="body2" color="text.secondary" sx={{ fontFamily: 'monospace', fontSize: '0.8rem' }}>
                                ID: {record.id}
                            </Typography>
                        </Box>
                        <Box sx={{ display: 'flex', gap: 1, alignItems: 'center' }}>
                            <Chip label={status.label} color={status.color} size="medium" />
                            {record.is_high_value && <Chip label="High Value" color="warning" size="small" variant="outlined" />}
                        </Box>
                    </Box>

                    <Grid container spacing={3}>
                        <Grid item xs={12} sm={6} md={3}>
                            <DetailField label="Industry Code" value={record.industry_code} />
                        </Grid>
                        <Grid item xs={12} sm={6} md={3}>
                            <DetailField label="Registration Date" value={
                                record.registration_date ? new Date(record.registration_date).toLocaleDateString() : null
                            } />
                        </Grid>
                        <Grid item xs={12} sm={6} md={3}>
                            <DetailField label="Created" value={new Date(record.created_at).toLocaleDateString()} />
                        </Grid>
                        <Grid item xs={12} sm={6} md={3}>
                            <DetailField label="Last Updated" value={new Date(record.updated_at).toLocaleString()} />
                        </Grid>
                    </Grid>

                    {/* Action buttons */}
                    <Box sx={{ display: 'flex', gap: 1, mt: 2, pt: 2, borderTop: '1px solid', borderColor: 'divider' }}>
                        <ExportDataButton />
                        <AnonymizeButton />
                    </Box>
                </CardContent>
            </Card>

            {/* === Business Profile + Addresses === */}
            <Grid container spacing={3} sx={{ mb: 3 }}>
                <Grid item xs={12} md={6}>
                    <Card sx={{ height: '100%' }}>
                        <CardContent>
                            <Typography variant="subtitle1" sx={{ fontWeight: 600, mb: 2 }}>
                                Business Profile
                            </Typography>
                            <Grid container spacing={2}>
                                <Grid item xs={6}>
                                    <DetailField label="Membership Tier" value={record.membership_tier} />
                                </Grid>
                                <Grid item xs={6}>
                                    <DetailField label="Points Balance" value={record.points_balance?.toLocaleString()} />
                                </Grid>
                                <Grid item xs={6}>
                                    <DetailField label="Lifetime Value (CLV)" value={
                                        record.clv ? `฿${record.clv.toLocaleString()}` : null
                                    } />
                                </Grid>
                                <Grid item xs={6}>
                                    <DetailField label="Portfolio Size" value={
                                        record.portfolio_size ? `฿${record.portfolio_size.toLocaleString()}` : null
                                    } />
                                </Grid>
                                <Grid item xs={6}>
                                    <DetailField label="Preferred Channel" value={record.preferred_channel} />
                                </Grid>
                                <Grid item xs={6}>
                                    <DetailField label="Last Transaction" value={
                                        record.last_transaction_date ? new Date(record.last_transaction_date).toLocaleDateString() : null
                                    } />
                                </Grid>
                            </Grid>
                        </CardContent>
                    </Card>
                </Grid>
                <Grid item xs={12} md={6}>
                    <Card sx={{ height: '100%' }}>
                        <CardContent>
                            <Typography variant="subtitle1" sx={{ fontWeight: 600, mb: 2 }}>
                                Addresses
                            </Typography>
                            <Box sx={{ maxHeight: 300, overflow: 'auto' }}>
                                <AddressList />
                            </Box>
                        </CardContent>
                    </Card>
                </Grid>
            </Grid>

            <Grid container spacing={3} sx={{ mb: 3 }}>
                <Grid item xs={12} md={4}>
                    <Card sx={{ height: '100%' }}>
                        <CardContent>
                            <Typography variant="subtitle1" sx={{ fontWeight: 600, mb: 2 }}>
                                Identity Documents
                            </Typography>
                            <Box sx={{ maxHeight: 300, overflow: 'auto' }}>
                                <IdentityList />
                            </Box>
                        </CardContent>
                    </Card>
                </Grid>
                <Grid item xs={12} md={4}>
                    <Card sx={{ height: '100%' }}>
                        <CardContent>
                            <Typography variant="subtitle1" sx={{ fontWeight: 600, mb: 2 }}>
                                Related Individuals
                            </Typography>
                            <Box sx={{ maxHeight: 300, overflow: 'auto' }}>
                                <RelationshipList />
                            </Box>
                        </CardContent>
                    </Card>
                </Grid>
                <Grid item xs={12} md={4}>
                    <Card sx={{ height: '100%' }}>
                        <CardContent>
                            <Typography variant="subtitle1" sx={{ fontWeight: 600, mb: 2 }}>
                                Consents (PDPA)
                            </Typography>
                            <Box sx={{ maxHeight: 300, overflow: 'auto' }}>
                                <CustomerConsentList />
                            </Box>
                        </CardContent>
                    </Card>
                </Grid>
            </Grid>

            {/* === Recent Activity === */}
            <SectionHeader title="Recent Activity" />
            <ActivityLog />
        </Box>
    );
};

const JuristicShowActions = () => (
    <TopToolbar>
        <ListButton label="Back to List" />
        <EditButton />
    </TopToolbar>
);

export const JuristicShow = () => (
    <Show component="div" actions={<JuristicShowActions />}>
        <JuristicDetail />
    </Show>
);
