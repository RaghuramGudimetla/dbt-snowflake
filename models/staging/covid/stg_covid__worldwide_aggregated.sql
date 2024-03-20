with aggregated_worldwide as (
    select * from {{ source('covid', 'worldwide_aggregate')}}
)
select

    -- numeric
    "Confirmed"::NUMBER as confirmed_cases_count,
    "Recovered"::NUMBER as recovered_cases_count,
    "Deaths"::NUMBER as deaths_count,
    "Increase rate"::FLOAT as daily_cases_increase_rate,

    -- date
    "Date"::date as recorded_date

    -- ignoring Country as by default this is all in US
from
    aggregated_worldwide

