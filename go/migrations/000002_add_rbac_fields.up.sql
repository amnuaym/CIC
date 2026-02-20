ALTER TABLE users ADD COLUMN role VARCHAR(50) DEFAULT 'user';
ALTER TABLE users ADD COLUMN supervisor_id UUID REFERENCES users(id);
ALTER TABLE customers ADD COLUMN deleted_by UUID REFERENCES users(id);
