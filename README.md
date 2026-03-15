# AstraWorld Data Engineering Technical Test

## Overview

This project implements a simple **data pipeline and data warehouse design** that processes customer, sales, and after-sales data into structured analytical tables.

The pipeline is containerized using **Docker** so the reviewer can run the project without installing dependencies locally.

The system follows a common **data warehouse architecture** consisting of:

- **Raw Layer**
- **Clean Layer**
- **Datamart Layer**

---

# Architecture

The full architecture diagram can be accessed here:

**Architecture Diagram:**
[Architecture Design Link](https://drive.google.com/file/d/14sMVZo1Obd_jM18v1llPXZ_0CJ0mpZSo/view?usp=sharing)

---

# Project Structure

```
project-root
│
├── docker-compose.yml
├── Dockerfile
├── requirements.txt
│
├── data
│   └── customer_addresses_YYYYMMDD.csv
│
├── scripts
│   ├── ingest_csv.py
│   ├── cleaning.py
│   └── datamart.py
│
└── sql
    ├── init_dummy.sql
    ├── init_tables.sql
    └── seed_data.sql
```

---

# Technologies Used

- Python
- Pandas
- SQLAlchemy
- MySQL 8
- Docker
- Docker Compose

---

# How to Run the Project

Make sure the following tools are installed:

- Docker
- Docker Compose

Run the pipeline using:

```bash
docker compose up --build
```

The ETL pipeline will automatically execute the following steps:

1. CSV ingestion
2. Data cleaning
3. Datamart generation

---

# Database Access

The MySQL database can be accessed using the following credentials:

| Parameter | Value        |
| --------- | ------------ |
| Host      | 127.0.0.1    |
| Port      | 3307         |
| Username  | root         |
| Password  | password     |
| Database  | maju_jaya_dw |

You can connect using **MySQL Workbench** or any MySQL client.

---

# Pipeline Steps

## Step 1 – Data Ingestion

The CSV file:

```
customer_addresses_YYYYMMDD.csv
```

is ingested into the following raw table:

```
customer_addresses_raw
```

This process is handled by:

```
scripts/ingest_csv.py
```

---

## Step 2 – Data Cleaning

The cleaning process performs several transformations to standardize the data.

### Customers

- Standardizes the `dob` field into a valid date format
- Prevents duplicate customer IDs

### Sales

- Converts price values such as `"350.000.000"` into numeric format

### Addresses

- Deduplicates address records based on the latest record

Output tables:

```
customers_clean
sales_clean
after_sales_clean
addresses_clean
```

---

## Step 3 – Datamart

Two analytical tables are generated for reporting.

### Sales Summary Mart

Provides a summary of sales by:

- Period
- Vehicle class
- Vehicle model

Price classification:

| Class  | Price Range |
| ------ | ----------- |
| LOW    | 100M – 250M |
| MEDIUM | 250M – 400M |
| HIGH   | > 400M      |

Output table:

```
sales_summary_mart
```

---

### Service Priority Mart

Identifies customer service priority based on the number of service visits.

| Priority | Service Count |
| -------- | ------------- |
| LOW      | < 5           |
| MED      | 5 – 10        |
| HIGH     | > 10          |

Output table:

```
service_priority_mart
```

---

# Verifying the Results

Once the pipeline finishes running, the following queries can be executed to verify the results:

```sql
SELECT * FROM sales_summary_mart;

SELECT * FROM service_priority_mart;
```

---

# Viewing Container Logs

To view the ETL process logs:

```bash
docker logs -f etl_pipeline
```

---

# Reset Environment

To remove containers and reset the database:

```bash
docker compose down -v
```

Then run the pipeline again:

```bash
docker compose up --build
```

---

# Notes

- The pipeline uses a retry mechanism to ensure MySQL is available before executing the ETL process.
- The entire environment runs inside Docker containers to guarantee reproducibility.
- This project demonstrates a simplified **data warehouse pipeline design** suitable for analytics workloads.
