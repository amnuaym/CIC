-- Migration: Update role values to new RBAC convention
-- Old values: 'user', 'admin'
-- New values: 'SUPER_ADMIN', 'ADMIN', 'OPERATOR', 'VIEWER'

-- Update existing role values
UPDATE users SET role = 'OPERATOR' WHERE role = 'user' OR role = 'STAFF';
UPDATE users SET role = 'ADMIN' WHERE role = 'admin';

-- Update default roles in the roles table
UPDATE roles SET name = 'ADMIN', description = 'Team lead with delete/restore permissions' WHERE name = 'admin';
UPDATE roles SET name = 'OPERATOR', description = 'Staff with customer CRUD permissions' WHERE name = 'user';

-- Insert new roles
INSERT INTO roles (name, description) VALUES
    ('SUPER_ADMIN', 'System owner with full access including user management'),
    ('VIEWER', 'Auditor/compliance with read-only access')
ON CONFLICT (name) DO NOTHING;
