{{
    config(
        alias='australia_recordings_daily',
        incremental_strategy='append',
    )
}}

with worldwide_data as (
    select * from {{ ref('dw_fct_worldwide_recordings') }}
    where country='Australia'
    {% if is_incremental() %}
        and recorded_date > (select max(recorded_date) from {{ this }})
    {% endif %}
),
latest_data as (
   select
        state,
        recorded_date,
        confirmed,
        recovered,
        deaths
    from 
        worldwide_data
)
select 
    *
from latest_data