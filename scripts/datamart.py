from sqlalchemy import create_engine, text

engine = create_engine(
    "mysql+pymysql://root:password@mysql:3306/maju_jaya_dw"
)

with engine.begin() as conn:
    # ---------------------------------------------------------------------------- #
    #                                    REPORTS                                   #
    # ---------------------------------------------------------------------------- #


    # SALES SUMMARY REPORT TABLE
    conn.execute(text("""
    INSERT INTO sales_summary_mart
    SELECT
        DATE_FORMAT(invoice_date,'%Y-%m') AS periode,
        CASE
            WHEN price BETWEEN 100000000 AND 250000000 THEN 'LOW'
            WHEN price BETWEEN 250000000 AND 400000000 THEN 'MEDIUM'
            ELSE 'HIGH'
        END AS class,
        model,
        SUM(price) AS total
    FROM sales_clean
    GROUP BY 1,2,3
    """))

    # SERVICE PRIORITY REPOR TABLE
    conn.execute(text("""
    INSERT INTO service_priority_mart
    SELECT
        YEAR(a.service_date) AS periode,
        a.vin,
        c.name,
        ad.address,
        COUNT(a.service_ticket),
        CASE
            WHEN COUNT(a.service_ticket) > 10 THEN 'HIGH'
            WHEN COUNT(a.service_ticket) BETWEEN 5 AND 10 THEN 'MED'
            ELSE 'LOW'
        END
    FROM after_sales_clean a
    LEFT JOIN customers_clean c
    ON a.customer_id = c.id
    LEFT JOIN addresses_clean ad
    ON ad.customer_id = c.id
    GROUP BY 1,2,3,4
    """))

print("Datamart created")