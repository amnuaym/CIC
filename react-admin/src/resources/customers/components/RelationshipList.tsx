import { useRecordContext, Loading } from 'react-admin';
import { useQuery } from 'react-query';
import {
    Table, TableBody, TableCell, TableHead, TableRow, Paper
} from '@mui/material';

export const RelationshipList = () => {
    const record = useRecordContext();

    const { data, isLoading, error } = useQuery(
        ['relationships', record?.id],
        async () => {
            if (!record) return [];
            const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8080/api/v1';
            const response = await fetch(`${apiUrl}/customers/${record.id}/relationships`);
            if (!response.ok) throw new Error('Network response was not ok');
            return response.json();
        },
        { enabled: !!record }
    );

    if (isLoading) return <Loading />;
    if (error) return <p style={{ color: 'red' }}>Error loading relationships</p>;
    if (!data || data.length === 0) return <p>No relationships found</p>;

    return (
        <Paper>
            <Table size="small">
                <TableHead>
                    <TableRow>
                        <TableCell>Relation</TableCell>
                        <TableCell>Target Customer</TableCell>
                        <TableCell>Role</TableCell>
                    </TableRow>
                </TableHead>
                <TableBody>
                    {data.map((rel: any) => (
                        <TableRow key={rel.id}>
                            <TableCell>{rel.target_customer_id === record.id ? 'Inbound' : 'Outbound'}</TableCell>
                            <TableCell>{rel.target_customer_id === record.id ? rel.source_customer_id : rel.target_customer_id}</TableCell>
                            <TableCell>{rel.role}</TableCell>
                        </TableRow>
                    ))}
                </TableBody>
            </Table>
        </Paper>
    );
};
