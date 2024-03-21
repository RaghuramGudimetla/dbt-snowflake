{{
    config(
        alias='worldwide_countries_aggregated_daily',
        unique_key=['country','recorded_date']
    )
}}

with worldwide_data as (
    select * from {{ ref('dw_fct_worldwide_recordings') }}
    {% if is_incremental() %}
        where recorded_date > (select max(recorded_date) from {{ this }})
    {% endif %}
),
latest_data as (
    select
        country,
        recorded_date,
        sum(confirmed) as confirmed_cases,
        sum(recovered) as recovered_cases,
        sum(deaths) as deaths,
    from 
        worldwide_data
    group by 1, 2
    order by 1, 2
)
select 
    *
from latest_data