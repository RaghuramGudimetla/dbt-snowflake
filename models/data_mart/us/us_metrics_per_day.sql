{{
    config(
        alias='us_metrics_per_day',
        unique_key=['recorded_date'],
    )
}}

with us_aggregated_data as (
    select * from {{ ref('dw_fct_us_daily_aggregations') }}
    {% if is_incremental() %}
        where recorded_date > (select max(recorded_date) from {{ this }})
    {% endif %}
),
grouped_data as (
    select
        recorded_date,
        sum(deaths_count) as total_deaths,
        sum(confirmed_count) as total_confirmed_cases
    from us_aggregated_data
    group by 1
    order by 1
)
select 
    *
from grouped_data