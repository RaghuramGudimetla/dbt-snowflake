with countries_aggregated as (
    select * from {{ source('covid', 'countries_aggregated')}}
)
select
    -- strings
    "Country"::VARCHAR as country,

    -- numerics
    "Confirmed"::NUMBER as confirmed_count,
    "Recovered"::NUMBER as recovered_count,
    "Deaths"::NUMBER as deaths_count,

    -- dates
    "Date"::date as recorded_date,
from
    countries_aggregated