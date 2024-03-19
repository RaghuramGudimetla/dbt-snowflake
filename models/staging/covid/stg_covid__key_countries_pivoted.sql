with countries_pivoted as (
    select * from {{ source('covid', 'key_countries_pivoted')}}
)
select
    "China"::NUMBER as china,
    "US"::NUMBER as us,
    "United_Kingdom"::NUMBER as uk,
    "Italy"::NUMBER as italy,
    "France"::NUMBER as france,
    "Germany"::NUMBER as germany,
    "Spain"::NUMBER as spain,
    "Iran"::NUMBER as iran,
    "Date" as recorded_date
from
    countries_pivoted