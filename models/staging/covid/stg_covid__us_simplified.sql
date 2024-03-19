with us_cases_simplified as (
    select * from {{ source('covid', 'us_simplified')}}
)
select

    -- strings
    "Admin2"::VARCHAR as admin_name,
    "Province/State" as state,

    -- numeric
    "Confirmed"::NUMBER as confirmed_cases_count,
    "Deaths"::NUMBER as deaths_count,

    -- date
    "Date"::date as recorded_date

    -- ignoring Country as by default this is all in US
from
    us_cases_simplified

