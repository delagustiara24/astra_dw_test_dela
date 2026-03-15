import pandas as pd
import glob
from sqlalchemy import create_engine

engine = create_engine(
    "mysql+pymysql://root:password@mysql:3306/maju_jaya_dw"
)

files = glob.glob("/data/customer_addresses_*.csv")

for file in files:

    print("Processing:", file)

    df = pd.read_csv(file)

    df.to_sql(
        "customer_addresses_raw",
        con=engine,
        if_exists="append",
        index=False
    )

print("CSV ingestion complete")