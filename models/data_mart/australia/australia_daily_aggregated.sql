{{
    config(
        alias='australia_daily_aggregated',
        incremental_strategy='append',
        post_hook = "{{ unload_this('COVID.RAW.AWS_COVID_STAGE', 'COVID.RAW.JSON_EXPORT') }}"
    )
}}

with australia_daily as (
    select * from {{ ref('austraila_recordings_daily') }}
    {% if is_incremental() %}
        where recorded_date > (select max(recorded_date) from {{ this }})
    {% endif %}
),
latest_data as (
   select
        recorded_date,
        sum(confirmed) as confirmed_cases_count,
        sum(recovered) as recovered_cases_count,
        sum(deaths) as deaths_count,
    from 
        australia_daily
    group by 1
)
select 
    *
from latest_data