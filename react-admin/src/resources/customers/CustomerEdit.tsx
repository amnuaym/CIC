import { Edit, TextInput, DateInput, SelectInput, FormDataConsumer, required, TabbedForm, FormTab } from 'react-admin';

export const CustomerEdit = () => (
    <Edit>
        <TabbedForm>
            <FormTab label="Summary">
                <TextInput source="id" disabled />
                <SelectInput source="type" choices={[
                    { id: 'PERSONAL', name: 'Personal' },
                    { id: 'JURISTIC', name: 'Juristic' },
                ]} disabled />

                <FormDataConsumer>
                    {({ formData, ...rest }) => formData.type === 'PERSONAL' &&
                        <>
                            <TextInput source="title" label="Title" {...rest} />
                            <TextInput source="first_name" label="First Name" validate={required()} {...rest} />
                            <TextInput source="last_name" label="Last Name" validate={required()} {...rest} />
                            <DateInput source="date_of_birth" label="Date of Birth" {...rest} />
                            <TextInput source="nationality" label="Nationality" {...rest} />
                        </>
                    }
                </FormDataConsumer>

                <FormDataConsumer>
                    {({ formData, ...rest }) => formData.type === 'JURISTIC' &&
                        <>
                            <TextInput source="company_name" label="Company Name" validate={required()} {...rest} />
                            <DateInput source="registration_date" label="Registration Date" {...rest} />
                            <TextInput source="industry_code" label="Industry Code" {...rest} />
                        </>
                    }
                </FormDataConsumer>

                <SelectInput source="status" choices={[
                    { id: 'ACTIVE', name: 'Active' },
                    { id: 'INACTIVE', name: 'Inactive' },
                    { id: 'SUSPENDED', name: 'Suspended' },
                    { id: 'BLACKLISTED', name: 'Blacklisted' },
                    { id: 'DECEASED', name: 'Deceased' },
                ]} validate={required()} />
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
