{{
    config(
        alias='fct_worldwide_recordings',
        incremental_strategy='append'
    )
}}

with worldwide_combined_data as (
    select * from {{ ref('stg_covid__time_series_covid_combined') }}
    {% if is_incremental() %}
        where recorded_date > (select max(recorded_date) from {{ this }})
    {% endif %}
),
latest_data as (
    select
        country,
        state,
        confirmed,
        recovered,
        deaths,
        recorded_date
    from 
        worldwide_combined_data
)
select 
    *
from latest_data