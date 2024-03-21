Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test

### Source Data

Source data is coming from S3 bucket and is available in COVID.RAW
It's in CSV format and we used INFER_SCHEMA to fetch the schema of each source table.
Loaded it using storage integration.

### Elementary
- pip install elementary-data
- dbt run -s elementary
- make sure we have profile named elementary in the profiles.yml file
- edr report --project-dir /c/Personal/dbt-snowflake (Any of the local path)
- edr report --project-name Covid Dataset Model --env prod