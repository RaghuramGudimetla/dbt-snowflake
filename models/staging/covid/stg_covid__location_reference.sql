with reference as (
    select * from {{ source('covid', 'reference')}}
)
select
    -- ids
    "UID"::NUMBER as uid,

    -- strings
    "iso2"::VARCHAR as iso_2,
    "iso3"::VARCHAR as iso_3,
    "Admin2"::VARCHAR as admin_name,
    "Province_State"::VARCHAR as state,
    "Country_Region"::VARCHAR as country,
    "Combined_Key"::VARCHAR as country_state,

    -- numerics
    "Lat"::FLOAT as latitude,
    "Long_"::FLOAT as longitude,
    "code3"::NUMBER as code_3,
    "FIPS"::NUMBER as fips,
    "Population"::NUMBER as population
from
    reference