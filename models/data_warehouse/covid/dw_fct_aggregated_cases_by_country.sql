{{
    config(
        alias='fct_aggregated_cases_by_country',
        unique_key=['recorded_date','country_code'],
    )
}}

with aggregated_data as (
    select * from {{ ref('stg_covid__countries_aggregated') }}
    {% if is_incremental() %}
        where recorded_date > (select max(recorded_date) from {{ this }})
    {% endif %}
),
locations as (
    select * from {{ ref('dw_dim_locations') }}
),
unique_countries as (
    select 
        distinct country, country_code
    from locations
),
mapped_data as (
    select
        unique_countries.country_code,
        confirmed_count,
        recovered_count,
        deaths_count,
        recorded_date,
    from aggregated_data
    left outer join unique_countries 
    using(country)
)
select 
    *
from mapped_data