{{
    config(
        alias='worldwide_aggregated_daily',
        unique_key=['recorded_date']
    )
}}

with worldwide_aggregated_data as (
    select * from {{ ref('worldwide_countries_aggregated_daily') }}
    {% if is_incremental() %}
        where recorded_date > (select max(recorded_date) from {{ this }})
    {% endif %}
),
grouped_data as (
    select
        recorded_date,
        sum(confirmed_cases) as confirmed_cases,
        sum(recovered_cases) as recovered_cases,
        sum(deaths) as deaths,
    from 
        worldwide_aggregated_data
    group by 1
    order by 1
),
precentage_increase as (
    select
        recorded_date,
        confirmed_cases,
        recovered_cases,
        deaths,
        ((confirmed_cases - LAG(confirmed_cases) OVER (ORDER BY recorded_date))/LAG(confirmed_cases) OVER (ORDER BY recorded_date))*100 as percentage_increase_confirmed_cases,
    from grouped_data
)
select 
    *
from precentage_increase