import {
    List, Datagrid, TextField, DateField, BooleanField, Show,
    SimpleShowLayout, SearchInput
} from 'react-admin';

// --- Filters ---
const consentFilters = [
    <SearchInput source="q" alwaysOn />,
];

// --- List: Top-level cross-customer consent overview ---
export const ConsentList = () => (
    <List filters={consentFilters}>
        <Datagrid rowClick="show">
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
