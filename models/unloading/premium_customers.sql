{{ config(
        materialized='view',
        alias='premium_customers',
        post_hook = "{{ unload_this('LANDING.RAW.UNLOADING_TO_S3', 'LANDING.RAW.JSON_FILE_FORMAT') }}"
    ) 
}}

with premium_customers as (
    select * from {{ ref('staging_customer')}}
    where c_birth_country in ('INDIA')
)
select
    *
from
    premium_customers
limit 100