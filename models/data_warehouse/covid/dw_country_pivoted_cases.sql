{{
    config(
        alias='key_countries_pivoted',
        unique_key='recorded_date'
    )
}}

{%- set key_countries = ['China','US','Italy', 'France', 'Germany', 'Spain', 'Iran'] -%}

with countries_data as (
   select * from {{ ref('stg_covid__countries_aggregated') }}
   {% if is_incremental() %}
        where recorded_date > (select max(recorded_date) from {{ this }})
    {% endif %}
),
pivoted_data as (

   select
      recorded_date,
      {% for country_name in key_countries -%}

        sum(
            case
                when country = '{{ country_name }}'
                then confirmed_count
                else 0
            end
        )
        as {{ country_name }}_confirmed_count,

        sum(
            case
                when country = '{{ country_name }}'
                then recovered_count
                else 0
            end
        )
        as {{ country_name }}_recovered_count,

        sum(
            case
                when country = '{{ country_name }}'
                then deaths_count
                else 0
            end
        )
        as {{ country_name }}s,
      {%- endfor %}

   from countries_data
   group by 1

)

select * from pivoted_data


