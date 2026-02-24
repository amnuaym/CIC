import {
    List, Datagrid, TextField, DateField, BooleanField, Show,
    SimpleShowLayout, SearchInput, TopToolbar, ExportButton, FilterLiveSearch
} from 'react-admin';
import { Box, Typography } from '@mui/material';

// --- Empty State ---
const EmptyList = () => (
    <Box sx={{ textAlign: 'center', py: 12, border: '1px dashed', borderColor: 'divider', borderRadius: 2, bgcolor: 'background.paper', mt: 2 }}>
        <Typography variant="h6" color="primary" gutterBottom sx={{ fontWeight: 700 }}>
            Consents: Start by searching (V2.1)
        </Typography>
        <Typography variant="body2" color="text.secondary">
            Use the search box in the top-left toolbar to find records, or use <strong>*</strong> to show all.
        </Typography>
    </Box>
);

// --- List Actions (Toolbar) ---
const ConsentListActions = () => (
    <TopToolbar sx={{ justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
        <FilterLiveSearch source="q" label="Search Consents..." sx={{ minWidth: 300 }} />
        <Box sx={{ display: 'flex', gap: 1 }}>
            <ExportButton />
        </Box>
    </TopToolbar>
);

// --- Filters ---
const consentFilters = [
    <SearchInput source="q" />,
];

// --- List: Top-level cross-customer consent overview ---
export const ConsentList = () => (
    <List actions={<ConsentListActions />} filters={consentFilters}>
        <Datagrid rowClick="show" empty={<EmptyList />}>
            <TextField source="id" />
            <TextField source="customer_id" label="Customer" />
            <TextField source="topic" />
            <TextField source="version" />
            <BooleanField source="is_granted" label="Granted" />
            <DateField source="timestamp" label="Timestamp" showTime />
        </Datagrid>
    </List>
);

// --- Show ---
export const ConsentShow = () => (
    <Show>
        <SimpleShowLayout>
            <TextField source="id" />
            <TextField source="customer_id" label="Customer ID" />
            <TextField source="topic" />
            <TextField source="version" />
            <BooleanField source="is_granted" label="Granted" />
            <DateField source="timestamp" label="Timestamp" showTime />
            <DateField source="created_at" label="Created" showTime />
        </SimpleShowLayout>
    </Show>
);
