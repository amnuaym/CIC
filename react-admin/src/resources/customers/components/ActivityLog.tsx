import { useRecordContext, Loading } from 'react-admin';
import { useQuery } from 'react-query';
import {
    Table, TableBody, TableCell, TableHead, TableRow, Paper,
    Typography, Chip, Box
} from '@mui/material';

const actionColors: Record<string, 'success' | 'info' | 'warning' | 'error' | 'default'> = {
    CREATE: 'success',
    UPDATE: 'info',
    DELETE: 'error',
    RESTORE: 'warning',
    ANONYMIZE: 'error',
};

export const ActivityLog = () => {
    const record = useRecordContext();

    const { data, isLoading, error } = useQuery(
        ['activity-log', record?.id],
        async () => {
            if (!record) return [];
            const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8080/api/v1';
            const token = localStorage.getItem('token');
            const response = await fetch(
                `${apiUrl}/audit-logs?entity_id=${record.id}&limit=20`,
                { headers: token ? { Authorization: `Bearer ${token}` } : {} }
            );
            if (!response.ok) throw new Error('Failed to load activity');
            return response.json();
        },
        { enabled: !!record }
    );

    if (isLoading) return <Loading />;
    if (error) return <Typography color="error">Error loading activity log</Typography>;
    if (!data || data.length === 0) {
        return (
            <Box sx={{ py: 2, textAlign: 'center' }}>
                <Typography color="text.secondary">No activity recorded yet</Typography>
            </Box>
        );
    }

    return (
        <Paper variant="outlined">
            <Table size="small">
                <TableHead>
                    <TableRow sx={{ bgcolor: 'action.hover' }}>
                        <TableCell sx={{ fontWeight: 600 }}>Action</TableCell>
                        <TableCell sx={{ fontWeight: 600 }}>Performed By</TableCell>
                        <TableCell sx={{ fontWeight: 600 }}>Date & Time</TableCell>
                        <TableCell sx={{ fontWeight: 600 }}>IP Address</TableCell>
                        <TableCell sx={{ fontWeight: 600 }}>Changes</TableCell>
                    </TableRow>
                </TableHead>
                <TableBody>
                    {data.map((log: any) => (
                        <TableRow key={log.id} hover>
                            <TableCell>
                                <Chip
                                    label={log.action}
                                    size="small"
                                    color={actionColors[log.action] || 'default'}
                                    variant="outlined"
                                />
                            </TableCell>
                            <TableCell>{log.performed_by}</TableCell>
                            <TableCell>
                                {new Date(log.timestamp).toLocaleString()}
                            </TableCell>
                            <TableCell>
                                <Typography variant="body2" sx={{ fontFamily: 'monospace', fontSize: '0.8rem' }}>
                                    {log.ip_address || '—'}
                                </Typography>
                            </TableCell>
                            <TableCell sx={{ maxWidth: 300 }}>
                                <Typography
                                    variant="body2"
                                    sx={{
                                        fontSize: '0.8rem',
                                        whiteSpace: 'nowrap',
                                        overflow: 'hidden',
                                        textOverflow: 'ellipsis',
                                    }}
                                    title={log.changes}
                                >
                                    {log.changes || '—'}
                                </Typography>
                            </TableCell>
                        </TableRow>
                    ))}
                </TableBody>
            </Table>
        </Paper>
    );
};
