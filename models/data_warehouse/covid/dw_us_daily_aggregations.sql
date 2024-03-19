{{
    config(
        alias='us_daily_joined',
        unique_key=['recorded_date', 'state', 'admin_name']
    )
}}

with confirmed as (
    select * from {{ ref('stg_covid__us_confirmed') }}
    {% if is_incremental() %}
        where recorded_date > (select max(recorded_date) from {{ this }})
    {% endif %}
),
deaths as (
    select * from {{ ref('stg_covid__us_deaths') }}
    {% if is_incremental() %}
        where recorded_date > (select max(recorded_date) from {{ this }})
    {% endif %}
),
joined as (
    select 
        confirmed.admin_name as admin_name,
        confirmed.state as state,
        confirmed.number_of_cases as confirmed_count,
        deaths.number_of_cases as deaths_count,
        confirmed.recorded_date as recorded_date
    from confirmed
    left join deaths 
    on confirmed.recorded_date = deaths.recorded_date
    and confirmed.state = deaths.state
    and confirmed.admin_name = deaths.admin_name
)
select 
    *
from joined