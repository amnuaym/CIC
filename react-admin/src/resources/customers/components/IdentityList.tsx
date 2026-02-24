import { useRecordContext, Loading } from 'react-admin';
import { useQuery } from 'react-query';
import {
    Table, TableBody, TableCell, TableHead, TableRow, Paper
} from '@mui/material';

export const IdentityList = () => {
    const record = useRecordContext();

    const { data, isLoading, error } = useQuery(
        ['identities', record?.id],
        async () => {
            if (!record) return [];
            const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8080/api/v1';
            const token = localStorage.getItem('token');
            const response = await fetch(`${apiUrl}/customers/${record.id}/identities`, {
                headers: token ? { Authorization: `Bearer ${token}` } : {},
            });
            if (!response.ok) throw new Error('Network response was not ok');
            return response.json();
        },
        { enabled: !!record }
    );

    if (isLoading) return <Loading />;
    if (error) return <p style={{ color: 'red' }}>Error loading identities</p>;
    if (!data || data.length === 0) return <p>No identities found</p>;

    return (
        <Paper>
            <Table size="small">
                <TableHead>
                    <TableRow>
                        <TableCell>Type</TableCell>
                        <TableCell>Number</TableCell>
                        <TableCell>Country</TableCell>
                        <TableCell>Expiry</TableCell>
                    </TableRow>
                </TableHead>
                <TableBody>
                    {data.map((identity: any) => (
                        <TableRow key={identity.id}>
                            <TableCell>{identity.type}</TableCell>
                            <TableCell>{identity.number}</TableCell>
                            <TableCell>{identity.issuance_country}</TableCell>
                            <TableCell>{identity.expiry_date ? new Date(identity.expiry_date).toLocaleDateString() : '-'}</TableCell>
                        </TableRow>
                    ))}
                </TableBody>
            </Table>
        </Paper>
    );
};
