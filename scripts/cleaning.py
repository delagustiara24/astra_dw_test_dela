from sqlalchemy import create_engine, text

engine = create_engine(
"mysql+pymysql://root:password@mysql:3306/maju_jaya_dw"
)

with engine.begin() as conn:
    # ---------------------------------------------------------------------------- #
    #                                 Cleaning data                                #
    # ---------------------------------------------------------------------------- #
    
    
    # addresses (Filtering uniqe id or customer id based on latest created at)
    conn.execute(text("""
        INSERT INTO addresses_clean
        (id, customer_id, address, city, province, created_at)

        SELECT
        id,
        customer_id,
        address,
        city,
        province,
        created_at

        FROM (
            SELECT *,
            ROW_NUMBER() OVER(
                PARTITION BY id, customer_id
                ORDER BY created_at DESC
            ) AS rn
            FROM customer_addresses_raw
        ) t

        WHERE rn = 1;
    """))

    # customers cleaning (dob field pattern)
    conn.execute(text("""
    INSERT INTO customers_clean
    (id, name, dob, created_at)

    SELECT
    id,
    name,
    CASE
        WHEN dob IS NULL THEN NULL
        WHEN dob REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
            THEN STR_TO_DATE(dob,'%Y-%m-%d')
        WHEN dob REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$'
            THEN STR_TO_DATE(dob,'%Y/%m/%d')
        WHEN dob REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
            THEN STR_TO_DATE(dob,'%d/%m/%Y')
        ELSE NULL
    END,
    created_at

    FROM (
        SELECT *,
        ROW_NUMBER() OVER(
            PARTITION BY id
            ORDER BY created_at DESC
        ) AS rn
        FROM customers_raw
    ) t

    WHERE rn = 1;
    """))

    # sales cleaning (price field pattern)
    conn.execute(text("""
    INSERT INTO sales_clean
    SELECT
        vin,
        customer_id,
        model,
        invoice_date,
        REPLACE(price,'.',''),
        created_at
    FROM sales_raw
    """))

    # after sales (just copy from raw table to clean table)
    conn.execute(text("""
    INSERT INTO after_sales_clean
    SELECT * FROM after_sales_raw
    """))

print("Cleaning complete")