CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE customer_type AS ENUM ('PERSONAL', 'JURISTIC');
CREATE TYPE customer_status AS ENUM ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'DECEASED', 'BLACKLISTED');

CREATE TABLE customers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    type customer_type NOT NULL,
    
    -- Personal Fields
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    title VARCHAR(50),
    date_of_birth DATE,
    nationality VARCHAR(50),
    
    -- Juristic Fields
    company_name VARCHAR(255),
    registration_date DATE,
    industry_code VARCHAR(50),
    
    -- Business Profile
    status customer_status DEFAULT 'ACTIVE',
    membership_tier VARCHAR(50),
    points_balance DECIMAL(15, 2) DEFAULT 0,
    clv DECIMAL(15, 2) DEFAULT 0, -- Customer Lifetime Value
    portfolio_size DECIMAL(15, 2) DEFAULT 0,
    last_transaction_date TIMESTAMP WITH TIME ZONE,
    preferred_channel VARCHAR(50),
    is_high_value BOOLEAN DEFAULT FALSE,
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP WITH TIME ZONE -- Soft Delete
);

CREATE TABLE addresses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL, -- Registered, Mailing, HQ
    
    -- Relational Components (No JSONB)
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100), -- Province/State
    district VARCHAR(100), -- For Thailand
    sub_district VARCHAR(100), -- For Thailand
    zip_code VARCHAR(20),
    country VARCHAR(100) NOT NULL,
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE identities (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL, -- Passport, National ID, Tax ID
    number VARCHAR(100) NOT NULL,
    issuance_country VARCHAR(100),
    expiry_date DATE,
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE(type, number, issuance_country) -- Prevention of duplicates
);

CREATE TABLE relationships (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    from_customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    to_customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    role VARCHAR(50) NOT NULL, -- Director, Shareholder, Spouse
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE consents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    topic VARCHAR(100) NOT NULL, -- Marketing, Analytics
    version VARCHAR(20) NOT NULL,
    is_granted BOOLEAN DEFAULT FALSE,
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    entity_id UUID NOT NULL, -- Customer ID
    entity_type VARCHAR(50) NOT NULL, -- CUSTOMER, ADDRESS, etc.
    action VARCHAR(50) NOT NULL, -- CREATE, UPDATE, DELETE, MOVE
    performed_by VARCHAR(100) NOT NULL, -- User ID or System
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    changes TEXT, -- Storing delta (Old/New) as Text/JSON (Log can be text)
    ip_address VARCHAR(50)
);

CREATE INDEX idx_customers_search_name ON customers(first_name, last_name, company_name);
CREATE INDEX idx_identities_search_number ON identities(number);
