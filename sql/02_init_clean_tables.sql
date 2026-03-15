-- Clean tables
CREATE TABLE customers_clean (
    id INT,
    name VARCHAR(100),
    dob DATE,
    created_at DATETIME
);

CREATE TABLE sales_clean (
    vin VARCHAR(50),
    customer_id INT,
    model VARCHAR(50),
    invoice_date DATE,
    price BIGINT,
    created_at DATETIME
);

CREATE TABLE after_sales_clean (
    service_ticket VARCHAR(50),
    vin VARCHAR(50),
    customer_id INT,
    model VARCHAR(50),
    service_date DATE,
    service_type VARCHAR(10),
    created_at DATETIME
);

CREATE TABLE addresses_clean (
    id INT,
    customer_id INT,
    address TEXT,
    city VARCHAR(100),
    province VARCHAR(100),
    created_at DATETIME
);

-- Data mart
CREATE TABLE sales_summary_mart (
    periode VARCHAR(7),
    class VARCHAR(10),
    model VARCHAR(50),
    total BIGINT
);

CREATE TABLE service_priority_mart (
    periode INT,
    vin VARCHAR(50),
    customer_name VARCHAR(100),
    address TEXT,
    count_service INT,
    priority VARCHAR(10)
);