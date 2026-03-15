CREATE TABLE IF NOT EXISTS customers_raw (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    dob VARCHAR(20),
    created_at DATETIME
);

CREATE TABLE IF NOT EXISTS sales_raw (
    vin VARCHAR(50),
    customer_id INT,
    model VARCHAR(50),
    invoice_date DATE,
    price VARCHAR(20),
    created_at DATETIME
);

CREATE TABLE IF NOT EXISTS after_sales_raw (
    service_ticket VARCHAR(50),
    vin VARCHAR(50),
    customer_id INT,
    model VARCHAR(50),
    service_date DATE,
    service_type VARCHAR(10),
    created_at DATETIME
);

CREATE TABLE customer_addresses_raw (
    raw_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    id INT,
    customer_id INT,
    address TEXT,
    city VARCHAR(100),
    province VARCHAR(100),
    created_at DATETIME,
    ingestion_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
