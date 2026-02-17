import { useRecordContext, Loading } from 'react-admin';
import { useQuery } from 'react-query';
import {
    Table, TableBody, TableCell, TableHead, TableRow, Paper
} from '@mui/material';

export const ConsentList = () => {
    const record = useRecordContext();

    const { data, isLoading, error } = useQuery(
        ['consents', record?.id],
        async () => {
            if (!record) return [];
            const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8080/api/v1';
            const response = await fetch(`${apiUrl}/customers/${record.id}/consents`);
            if (!response.ok) throw new Error('Network response was not ok');
            return response.json();
        },
        { enabled: !!record }
    );

    if (isLoading) return <Loading />;
    if (error) return <p style={{ color: 'red' }}>Error loading consents</p>;
    if (!data || data.length === 0) return <p>No consents found</p>;

    return (
        <Paper>
            <Table size="small">
                <TableHead>
                    <TableRow>
                        <TableCell>Topic</TableCell>
                        <TableCell>Status</TableCell>
                        <TableCell>Version</TableCell>
                        <TableCell>Date</TableCell>
                    </TableRow>
                </TableHead>
                <TableBody>
                    {data.map((consent: any) => (
                        <TableRow key={consent.id}>
                            <TableCell>{consent.topic}</TableCell>
                            <TableCell>{consent.status}</TableCell>
                            <TableCell>{consent.version}</TableCell>
                            <TableCell>{new Date(consent.granted_at).toLocaleDateString()}</TableCell>
                        </TableRow>
                    ))}
                </TableBody>
            </Table>
        </Paper>
    );
};
