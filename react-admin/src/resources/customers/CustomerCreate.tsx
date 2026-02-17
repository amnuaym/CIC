import { Create, SimpleForm, TextInput, DateInput, SelectInput, FormDataConsumer, required } from 'react-admin';

export const CustomerCreate = () => (
    <Create>
        <SimpleForm>
            <SelectInput source="type" choices={[
                { id: 'PERSONAL', name: 'Personal' },
                { id: 'JURISTIC', name: 'Juristic' },
            ]} validate={required()} />

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
            ]} defaultValue="ACTIVE" />
        </SimpleForm>
    </Create>
);
