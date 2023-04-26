# CSV parser with DuckDB
This snippet uses DuckDB CSV Auto Detection to detect schema from CSV-files. More information: https://duckdb.org/docs/data/csv/auto_detection.html

DuckDB information schema is queried to produce correct format for ADE entity import.

## Pre-requisites:
- Python3
- Libraries:
    - pandas
    - duckdb


## Tips & tricks
Function read_csv_auto() allows configuring datatypes per column, if auto-detection seems to give incorrect results.

For example, an example below explicitly tries to read column 'ounces' to datatype DECIMAL.
```SQL
CREATE OR REPLACE TABLE beers AS SELECT * FROM read_csv_auto('beers.csv', types={{'ounces': DECIMAL});
```