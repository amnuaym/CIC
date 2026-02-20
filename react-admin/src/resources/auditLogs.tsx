import {
    List, Datagrid, TextField, DateField, Show,
    SimpleShowLayout, SearchInput, SelectInput
} from 'react-admin';

// --- Filters ---
const auditLogFilters = [
    <SearchInput source="q" alwaysOn />,
    <SelectInput source="action" choices={[
        { id: 'CREATE', name: 'Create' },
        { id: 'UPDATE', name: 'Update' },
        { id: 'DELETE', name: 'Delete' },
        { id: 'RESTORE', name: 'Restore' },
        { id: 'ANONYMIZE', name: 'Anonymize' },
    ]} alwaysOn />,
];

// --- List: Read-only audit trail ---
export const AuditLogList = () => (
    <List filters={auditLogFilters} sort={{ field: 'timestamp', order: 'DESC' }}>
        <Datagrid rowClick="show" bulkActionButtons={false}>
            <TextField source="id" />
            <TextField source="entity_type" label="Entity" />
            <TextField source="entity_id" label="Entity ID" />
            <TextField source="action" />
            <TextField source="performed_by" label="By" />
            <DateField source="timestamp" showTime />
            <TextField source="ip_address" label="IP" />
        </Datagrid>
    </List>
);

// --- Show: Full detail with changes ---
export const AuditLogShow = () => (
    <Show>
        <SimpleShowLayout>
            <TextField source="id" />
            <TextField source="entity_type" label="Entity Type" />
            <TextField source="entity_id" label="Entity ID" />
            <TextField source="action" />
            <TextField source="performed_by" label="Performed By" />
            <DateField source="timestamp" label="Timestamp" showTime />
            <TextField source="ip_address" label="IP Address" />
            <TextField source="changes" label="Changes (Old → New)" />
        </SimpleShowLayout>
    </Show>
);
