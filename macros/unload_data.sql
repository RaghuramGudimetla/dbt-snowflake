{% macro unload_this(unload_stage, file_format_name) %}

    {% set run_ts = run_started_at.strftime("%Y-%m-%d %H:%M:%S") %}
    {% set run_ts_tidy = run_ts.replace(" ", "_").replace(":", "").replace("-", "_") %}

    {% set new_rows_query %}
        select count(*) as num_rows from {{ this }}
    {% endset %}

    {% set file_count_query %}
        select count(*) as num_files from @{{ unload_stage }};
    {% endset %}

    {% set unload_query %}

          copy into @{{ unload_stage }}/{{ this.name }}_{{ run_ts_tidy }}
          from (
              with object_construction as (
                select object_construct(*) as object from {{ this }}
              )
              select object_agg(f.key, f.value)
              from object_construction, lateral flatten(input => object_construction.object) as f
              group by seq
          )
          file_format = (format_name = {{ file_format_name }});
    {% endset %}

    {% if execute %}
        {% set new_rows_count = run_query(new_rows_query) %}
        {% set file_count_before = run_query(file_count_query).columns[0].values()[0] %}
        {% do log('>>>>> New rows added to [' ~ this ~ ']: ' ~ new_rows_count.columns[0].values()[0], True) %}
        {% do log('>>>>> Running copy command: ' ~ unload_query, True) %}
        {% do run_query(unload_query) %}
        {% set file_count_after = run_query(file_count_query).columns[0].values()[0] %}
        {% do log('>>>>> Row count in stage: Before: ' ~ file_count_before ~ ' / After: ' ~ file_count_after, True) %}
    {% endif %}

{% endmacro %}