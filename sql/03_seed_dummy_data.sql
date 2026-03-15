-- ================================================================
-- Notes:
-- * Based on requirement existing tables is customers_raw, sales_raw and after_sales_raw
-- * Seeder process is used for testing only!!!, assumming that there are no pre-existing tables and row
-- * Seeder process can be executed if the existing tables are not initial
-- ================================================================


-- ================================
-- Seed customers_raw
-- ================================
INSERT INTO customers_raw (id, name, dob, created_at)
SELECT * FROM (
    SELECT 1,'Antonio','1998-08-04','2025-03-01 14:24:40' UNION ALL
    SELECT 2,'Brandon','2001-04-21','2025-03-02 08:12:54' UNION ALL
    SELECT 3,'Charlie','1980/11/15','2025-03-02 11:20:02' UNION ALL
    SELECT 4,'Dominikus','14/01/1995','2025-03-03 09:50:41' UNION ALL
    SELECT 5,'Erik','1900-01-01','2025-03-03 17:22:03' UNION ALL
    SELECT 6,'PT Black Bird',NULL,'2025-03-04 12:52:16'
) AS seed
WHERE NOT EXISTS (
    SELECT 1 FROM customers_raw LIMIT 1
);

-- ================================
-- Seed sales_raw
-- ================================
INSERT INTO sales_raw (vin, customer_id, model, invoice_date, price, created_at)
SELECT * FROM (
    SELECT 'JIS8135SAD',1,'RAIZA','2025-03-01','350.000.000','2025-03-01 14:24:40' UNION ALL
    SELECT 'MAS8160POE',3,'RANGGO','2025-05-19','430.000.000','2025-05-19 14:29:21' UNION ALL
    SELECT 'JLK1368KDE',4,'INNAVO','2025-05-22','600.000.000','2025-05-22 16:10:28' UNION ALL
    SELECT 'JLK1869KDF',6,'VELOS','2025-08-02','390.000.000','2025-08-02 14:04:31' UNION ALL
    SELECT 'JLK1962KOP',6,'VELOS','2025-08-02','390.000.000','2025-08-02 15:21:04'
) AS seed
WHERE NOT EXISTS (
    SELECT 1 FROM sales_raw LIMIT 1
);

-- ================================
-- Seed after_sales_raw
-- ================================
INSERT INTO after_sales_raw
(service_ticket, vin, customer_id, model, service_date, service_type, created_at)
SELECT * FROM (
    SELECT 'T124-kgu1','MAS8160POE',3,'RANGGO','2025-07-11','BP','2025-07-11 09:24:40' UNION ALL
    SELECT 'T560-jga1','JLK1368KDE',4,'INNAVO','2025-08-04','PM','2025-08-04 10:12:54' UNION ALL
    SELECT 'T521-oai8','POI1059IIK',5,'RAIZA','2026-09-10','GR','2026-09-10 12:45:02'
) AS seed
WHERE NOT EXISTS (
    SELECT 1 FROM after_sales_raw LIMIT 1
);