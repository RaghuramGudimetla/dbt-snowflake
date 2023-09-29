{{ config(
        materialized='incremental',
        alias='time_dim'
    ) 
}}

with time_dim as (
    select * from {{ source('sf10tcl', 'time_dim')}}
    {% if is_incremental() %}
        where t_time_sk > (select max(t_time_sk) from {{ this }})
    {% endif %}
)
select
    t_time_sk,
    t_time_id,
    t_time,
    t_hour,
    t_minute,
    t_second,
    t_am_pm,
    t_shift,
    t_sub_shift,
    t_meal_time
from
    time_dim