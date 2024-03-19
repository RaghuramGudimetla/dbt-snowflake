with covid_time_series_combined as (
    select * from {{ source('covid', 'time_series_covid_combined')}}
)
select
    -- strings
    "Country/Region"::VARCHAR as country,
    "Province/State"::VARCHAR as state,

    -- numeric
    "Confirmed"::NUMBER as confirmed,
    "Recovered"::NUMBER as recovered,
    "Deaths"::NUMBER as deaths,

    -- dates
    "Date"::date as recorded_date
from
    covid_time_series_combined

