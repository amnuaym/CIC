-- ============================================================
-- CIC Mock Data Seed Script
-- Run with: Get-Content scripts/seed-data.sql | docker exec -i my-postgres-container psql -U postgres -d cic_dev
-- ============================================================

-- ============================================================
-- INDIVIDUALS (PERSONAL type)
-- ============================================================

INSERT INTO customers (id, type, title, first_name, last_name, date_of_birth, nationality, status, membership_tier, points_balance, clv, portfolio_size, preferred_channel, is_high_value, last_transaction_date)
VALUES
  ('a0000001-0000-0000-0000-000000000001', 'PERSONAL', 'Mr.', 'Somchai', 'Jaturapattarapong', '1985-03-15', 'Thai', 'ACTIVE', 'Platinum', 125000, 3500000, 12500000, 'Branch', true, NOW() - INTERVAL '2 days'),
  ('a0000001-0000-0000-0000-000000000002', 'PERSONAL', 'Ms.', 'Siriporn', 'Ratchaniyom', '1990-07-22', 'Thai', 'ACTIVE', 'Gold', 45000, 890000, 2300000, 'Mobile', false, NOW() - INTERVAL '5 days'),
  ('a0000001-0000-0000-0000-000000000003', 'PERSONAL', 'Mr.', 'Tanaka', 'Yamamoto', '1978-11-08', 'Japanese', 'ACTIVE', 'Platinum', 200000, 5200000, 18000000, 'Online', true, NOW() - INTERVAL '1 day'),
  ('a0000001-0000-0000-0000-000000000004', 'PERSONAL', 'Mrs.', 'Nattaya', 'Srisawat', '1995-01-30', 'Thai', 'INACTIVE', 'Silver', 5000, 120000, 350000, 'Call Center', false, NOW() - INTERVAL '90 days'),
  ('a0000001-0000-0000-0000-000000000005', 'PERSONAL', 'Dr.', 'Preecha', 'Wongsakul', '1970-06-12', 'Thai', 'ACTIVE', 'Gold', 78000, 1750000, 5600000, 'Branch', true, NOW() - INTERVAL '10 days')
ON CONFLICT (id) DO NOTHING;

-- ============================================================
-- JURISTIC (JURISTIC type)
-- ============================================================

INSERT INTO customers (id, type, company_name, registration_date, industry_code, status, membership_tier, points_balance, clv, portfolio_size, preferred_channel, is_high_value, last_transaction_date)
VALUES
  ('b0000001-0000-0000-0000-000000000001', 'JURISTIC', 'Siam Digital Solutions Co., Ltd.', '2015-04-20', 'IT-6201', 'ACTIVE', 'Enterprise', 500000, 15000000, 42000000, 'Relationship Manager', true, NOW() - INTERVAL '3 days'),
  ('b0000001-0000-0000-0000-000000000002', 'JURISTIC', 'Bangkok Fresh Market PCL', '2008-09-15', 'FOOD-4711', 'ACTIVE', 'Corporate', 180000, 6800000, 22000000, 'Branch', true, NOW() - INTERVAL '1 day'),
  ('b0000001-0000-0000-0000-000000000003', 'JURISTIC', 'Thai Green Energy Ltd.', '2019-01-10', 'ENERGY-3511', 'SUSPENDED', 'Standard', 12000, 950000, 3200000, 'Online', false, NOW() - INTERVAL '60 days'),
  ('b0000001-0000-0000-0000-000000000004', 'JURISTIC', 'Chiang Mai Craft Exports Co., Ltd.', '2012-06-30', 'TRADE-4690', 'ACTIVE', 'Corporate', 95000, 4200000, 11500000, 'Relationship Manager', false, NOW() - INTERVAL '7 days')
ON CONFLICT (id) DO NOTHING;

-- ============================================================
-- ADDRESSES
-- ============================================================

INSERT INTO addresses (customer_id, type, address_line1, address_line2, city, state, district, sub_district, zip_code, country) VALUES
  -- Somchai's addresses
  ('a0000001-0000-0000-0000-000000000001', 'Registered', '123/45 Sukhumvit Soi 39', 'Phrom Phong Tower, Floor 15', 'Bangkok', 'Bangkok', 'Watthana', 'Khlong Tan Nuea', '10110', 'Thailand'),
  ('a0000001-0000-0000-0000-000000000001', 'Mailing', '88 Silom Road', 'Silom Complex, Unit B12', 'Bangkok', 'Bangkok', 'Bang Rak', 'Si Lom', '10500', 'Thailand'),
  -- Siriporn's address
  ('a0000001-0000-0000-0000-000000000002', 'Registered', '456 Nimman Road Soi 5', '', 'Chiang Mai', 'Chiang Mai', 'Mueang', 'Suthep', '50200', 'Thailand'),
  -- Tanaka's address
  ('a0000001-0000-0000-0000-000000000003', 'Registered', '1-2-3 Shinjuku', 'Park Tower 28F', 'Tokyo', 'Tokyo', '', '', '163-0228', 'Japan'),
  ('a0000001-0000-0000-0000-000000000003', 'Mailing', '999 Rama 4 Road', 'Sathorn Square, Tower A', 'Bangkok', 'Bangkok', 'Sathorn', 'Thung Maha Mek', '10120', 'Thailand'),
  -- Preecha's address
  ('a0000001-0000-0000-0000-000000000005', 'Registered', '77/3 Phaholyothin Road', '', 'Bangkok', 'Bangkok', 'Chatuchak', 'Lat Yao', '10900', 'Thailand'),
  -- Siam Digital HQ
  ('b0000001-0000-0000-0000-000000000001', 'HQ', '1 CyberWorld Tower', 'Ratchadaphisek Road', 'Bangkok', 'Bangkok', 'Huai Khwang', 'Huai Khwang', '10310', 'Thailand'),
  ('b0000001-0000-0000-0000-000000000001', 'Mailing', 'P.O. Box 456', '', 'Bangkok', 'Bangkok', '', '', '10310', 'Thailand'),
  -- Bangkok Fresh Market
  ('b0000001-0000-0000-0000-000000000002', 'HQ', '1234 Charoen Krung Road', '', 'Bangkok', 'Bangkok', 'Samphanthawong', 'Talat Noi', '10100', 'Thailand'),
  -- Chiang Mai Craft
  ('b0000001-0000-0000-0000-000000000004', 'HQ', '321 Tha Phae Road', '', 'Chiang Mai', 'Chiang Mai', 'Mueang', 'Chang Khlan', '50100', 'Thailand');

-- ============================================================
-- IDENTITIES
-- ============================================================

INSERT INTO identities (customer_id, type, number, issuance_country, expiry_date) VALUES
  -- Somchai
  ('a0000001-0000-0000-0000-000000000001', 'National ID', '1-1001-00001-01-1', 'Thailand', '2030-03-15'),
  ('a0000001-0000-0000-0000-000000000001', 'Passport', 'TH12345678', 'Thailand', '2028-06-20'),
  -- Siriporn
  ('a0000001-0000-0000-0000-000000000002', 'National ID', '5-5001-00002-02-2', 'Thailand', '2031-07-22'),
  -- Tanaka
  ('a0000001-0000-0000-0000-000000000003', 'Passport', 'JP98765432', 'Japan', '2027-11-08'),
  ('a0000001-0000-0000-0000-000000000003', 'Tax ID', 'JP-TAX-2023-001', 'Japan', NULL),
  -- Nattaya
  ('a0000001-0000-0000-0000-000000000004', 'National ID', '1-1234-56789-01-0', 'Thailand', '2029-01-30'),
  -- Preecha
  ('a0000001-0000-0000-0000-000000000005', 'National ID', '3-3001-00005-05-5', 'Thailand', '2032-06-12'),
  ('a0000001-0000-0000-0000-000000000005', 'Passport', 'TH55667788', 'Thailand', '2029-12-01'),
  -- Siam Digital (Tax ID)
  ('b0000001-0000-0000-0000-000000000001', 'Tax ID', '0105558000001', 'Thailand', NULL),
  -- Bangkok Fresh Market
  ('b0000001-0000-0000-0000-000000000002', 'Tax ID', '0107551000234', 'Thailand', NULL),
  -- Chiang Mai Craft
  ('b0000001-0000-0000-0000-000000000004', 'Tax ID', '0505555000789', 'Thailand', NULL)
ON CONFLICT (type, number, issuance_country) DO NOTHING;

-- ============================================================
-- RELATIONSHIPS
-- ============================================================

INSERT INTO relationships (from_customer_id, to_customer_id, role) VALUES
  -- Somchai is Director of Siam Digital
  ('a0000001-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'Director'),
  -- Siriporn is Shareholder of Bangkok Fresh Market
  ('a0000001-0000-0000-0000-000000000002', 'b0000001-0000-0000-0000-000000000002', 'Shareholder'),
  -- Preecha is Director of Bangkok Fresh Market
  ('a0000001-0000-0000-0000-000000000005', 'b0000001-0000-0000-0000-000000000002', 'Director'),
  -- Nattaya is Spouse of Somchai
  ('a0000001-0000-0000-0000-000000000004', 'a0000001-0000-0000-0000-000000000001', 'Spouse'),
  -- Somchai is Shareholder of Chiang Mai Craft
  ('a0000001-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000004', 'Shareholder');

-- ============================================================
-- CONSENTS (PDPA)
-- ============================================================

INSERT INTO consents (customer_id, topic, version, is_granted) VALUES
  -- Somchai
  ('a0000001-0000-0000-0000-000000000001', 'Marketing Communications', '2.0', true),
  ('a0000001-0000-0000-0000-000000000001', 'Data Analytics', '1.5', true),
  ('a0000001-0000-0000-0000-000000000001', 'Third-party Sharing', '1.0', false),
  -- Siriporn
  ('a0000001-0000-0000-0000-000000000002', 'Marketing Communications', '2.0', true),
  ('a0000001-0000-0000-0000-000000000002', 'Data Analytics', '1.5', false),
  -- Tanaka
  ('a0000001-0000-0000-0000-000000000003', 'Marketing Communications', '2.0', false),
  ('a0000001-0000-0000-0000-000000000003', 'Data Analytics', '1.5', true),
  ('a0000001-0000-0000-0000-000000000003', 'Third-party Sharing', '1.0', true),
  -- Preecha
  ('a0000001-0000-0000-0000-000000000005', 'Marketing Communications', '2.0', true),
  -- Siam Digital
  ('b0000001-0000-0000-0000-000000000001', 'Marketing Communications', '2.0', true),
  ('b0000001-0000-0000-0000-000000000001', 'Data Analytics', '1.5', true),
  -- Bangkok Fresh Market
  ('b0000001-0000-0000-0000-000000000002', 'Marketing Communications', '2.0', true);

-- ============================================================
-- AUDIT LOGS (Activity history)
-- ============================================================

INSERT INTO audit_logs (entity_id, entity_type, action, performed_by, timestamp, changes, ip_address) VALUES
  -- Somchai activity
  ('a0000001-0000-0000-0000-000000000001', 'CUSTOMER', 'CREATE', 'admin', NOW() - INTERVAL '30 days', '{"first_name":"Somchai","last_name":"Jaturapattarapong"}', '192.168.1.10'),
  ('a0000001-0000-0000-0000-000000000001', 'CUSTOMER', 'UPDATE', 'admin', NOW() - INTERVAL '15 days', '{"membership_tier":"Gold -> Platinum","points_balance":"80000 -> 125000"}', '192.168.1.10'),
  ('a0000001-0000-0000-0000-000000000001', 'ADDRESS', 'CREATE', 'operator1', NOW() - INTERVAL '28 days', '{"type":"Registered","city":"Bangkok"}', '10.0.0.5'),
  ('a0000001-0000-0000-0000-000000000001', 'ADDRESS', 'CREATE', 'operator1', NOW() - INTERVAL '20 days', '{"type":"Mailing","city":"Bangkok"}', '10.0.0.5'),
  -- Siriporn activity
  ('a0000001-0000-0000-0000-000000000002', 'CUSTOMER', 'CREATE', 'admin', NOW() - INTERVAL '25 days', '{"first_name":"Siriporn","last_name":"Ratchaniyom"}', '192.168.1.10'),
  ('a0000001-0000-0000-0000-000000000002', 'CUSTOMER', 'UPDATE', 'operator2', NOW() - INTERVAL '10 days', '{"status":"INACTIVE -> ACTIVE"}', '10.0.0.8'),
  -- Tanaka activity
  ('a0000001-0000-0000-0000-000000000003', 'CUSTOMER', 'CREATE', 'admin', NOW() - INTERVAL '20 days', '{"first_name":"Tanaka","last_name":"Yamamoto"}', '192.168.1.10'),
  ('a0000001-0000-0000-0000-000000000003', 'IDENTITY', 'CREATE', 'operator1', NOW() - INTERVAL '19 days', '{"type":"Passport","number":"JP98765432"}', '10.0.0.5'),
  -- Siam Digital activity
  ('b0000001-0000-0000-0000-000000000001', 'CUSTOMER', 'CREATE', 'admin', NOW() - INTERVAL '60 days', '{"company_name":"Siam Digital Solutions Co., Ltd."}', '192.168.1.10'),
  ('b0000001-0000-0000-0000-000000000001', 'CUSTOMER', 'UPDATE', 'admin', NOW() - INTERVAL '5 days', '{"membership_tier":"Corporate -> Enterprise","clv":"8000000 -> 15000000"}', '192.168.1.10'),
  ('b0000001-0000-0000-0000-000000000001', 'CONSENT', 'CREATE', 'operator1', NOW() - INTERVAL '55 days', '{"topic":"Marketing Communications","is_granted":true}', '10.0.0.5'),
  -- Bangkok Fresh Market activity
  ('b0000001-0000-0000-0000-000000000002', 'CUSTOMER', 'CREATE', 'admin', NOW() - INTERVAL '45 days', '{"company_name":"Bangkok Fresh Market PCL"}', '192.168.1.10'),
  ('b0000001-0000-0000-0000-000000000002', 'RELATIONSHIP', 'CREATE', 'operator2', NOW() - INTERVAL '40 days', '{"role":"Director","from":"Preecha Wongsakul"}', '10.0.0.8'),
  -- Thai Green Energy
  ('b0000001-0000-0000-0000-000000000003', 'CUSTOMER', 'CREATE', 'admin', NOW() - INTERVAL '35 days', '{"company_name":"Thai Green Energy Ltd."}', '192.168.1.10'),
  ('b0000001-0000-0000-0000-000000000003', 'CUSTOMER', 'UPDATE', 'admin', NOW() - INTERVAL '10 days', '{"status":"ACTIVE -> SUSPENDED"}', '192.168.1.10');
