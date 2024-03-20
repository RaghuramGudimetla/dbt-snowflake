{{
    config(
        materialized='table',
        alias='dim_locations',
        unique_key=['location_id'],
        tags=["ad_hoc"]
    )
}}

with location_references as (
    select * from {{ ref('stg_covid__location_reference') }}
),
locations as (
    select
        location_id,
        iso_2_country_code,
        iso_3_country_code,
        admin_name,
        state,
        country,
        country_state,
        latitude,
        longitude,
        country_code,
        fips,
        population
    from location_references
)
select 
    *
from locations