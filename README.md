# ADE Community entity import scripts

This repository contains example solution for detecting schema from CSV-files and importing the resulting entity import CSVs to Agile Data Engine.

This solution uses DuckDB CSV Auto Detection to detect schema from CSV-files. More information: https://duckdb.org/docs/data/csv/auto_detection.html

DuckDB information schema is queried to produce correct format for ADE entity import.

## Purpose
This solution helps to import entity metadata, so you can have correct schema created by ADE. After importing entity metadata, you can load your source files correctly to target database.

For more information, please refer to the official documentation: https://docs.agiledataengine.com/docs/import-entities

## Usage
Solution is done with Jupyter Notebook, which you can run locally.
Notebook was chosen as a template for this solution so it is easy to follow the execution of the script.

### Pre-requisites:
To be able to run the notebook, you should have:

- Python3 & Jupyter Notebook
- Libraries:
    - pandas
    - duckdb

### Running & importing to ADE
1. Place CSV-files to [**data**](data) -folder
2. Execute the script and it will write entity import CSV-file to [**entity_import**](entity_import) -folder
    - You may need to adjust script in some cases, for example if you want to create different kind of entity types. Default entity type in the script is SOURCE-entity.
3. Import the CSV file to Agile Data Engine
4. Check the results from resulted package(s)

### Tips & tricks
#### 1. Overriding data type per column
Function read_csv_auto() allows configuring datatypes per column, if auto-detection seems to give incorrect results.

For example, an example below explicitly tries to read column 'ounces' to datatype DECIMAL.
```SQL
CREATE OR REPLACE TABLE beers AS SELECT * FROM read_csv_auto('beers.csv', types={{'ounces': DECIMAL});
```


## Disclaimer
**The repository is provided as community solution and it may require modifications to fit your use case. Note that this solution is not part of the Agile Data Engine product. Please use at your own caution.**