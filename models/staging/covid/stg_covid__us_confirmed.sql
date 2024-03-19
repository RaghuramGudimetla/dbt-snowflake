with us_confirmed_cases as (
    select * from {{ source('covid', 'us_confirmed')}}
)
select

    -- strings
    "Admin2"::VARCHAR as admin_name,
    "Province/State"::VARCHAR as state,

    -- numeric
    "Case"::NUMBER as number_of_cases,

    -- date
    "Date"::date as recorded_date

    -- ignoring Country as by default this is all in US
from
    us_confirmed_cases

