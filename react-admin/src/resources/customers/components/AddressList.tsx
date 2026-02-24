import { useRecordContext, Loading } from 'react-admin';
import { useQuery } from 'react-query';
import {
    Table, TableBody, TableCell, TableHead, TableRow, Paper
} from '@mui/material';

export const AddressList = () => {
    const record = useRecordContext();

    // Use react-query to fetch data manually if not using ReferenceManyField
    // Here we assume dataProvider.getOne('customers/X/addresses') works if we hack it, 
    // or we just use fetch. Let's use fetch for simplicity as dataProvider might expect standard resource.

    const { data, isLoading, error } = useQuery(
        ['addresses', record?.id],
        async () => {
            if (!record) return [];
            const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8080/api/v1';
            const token = localStorage.getItem('token');
            const response = await fetch(`${apiUrl}/customers/${record.id}/addresses`, {
                headers: token ? { Authorization: `Bearer ${token}` } : {},
            });
            if (!response.ok) throw new Error('Network response was not ok');
            return response.json();
        },
        { enabled: !!record }
    );

    if (isLoading) return <Loading />;
    if (error) return <p style={{ color: 'red' }}>Error loading addresses</p>;
    if (!data || data.length === 0) return <p>No addresses found</p>;

    return (
        <Paper>
            <Table size="small">
                <TableHead>
                    <TableRow>
                        <TableCell>Type</TableCell>
                        <TableCell>Address</TableCell>
                        <TableCell>City</TableCell>
                        <TableCell>Country</TableCell>
                    </TableRow>
                </TableHead>
                <TableBody>
                    {data.map((address: any) => (
                        <TableRow key={address.id}>
                            <TableCell>{address.type}</TableCell>
                            <TableCell>
                                {address.address_line1} {address.address_line2}
                            </TableCell>
                            <TableCell>{address.city}, {address.state} {address.zip_code}</TableCell>
                            <TableCell>{address.country}</TableCell>
                        </TableRow>
                    ))}
                </TableBody>
            </Table>
        </Paper>
    );
};
