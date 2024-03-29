-- Macro to override default database and use custom.
{% macro generate_database_name(custom_database_name=none, node=none) -%}

    {%- set default_database = target.database -%}
    {%- if custom_database_name is none -%}

        {{ default_database }}

    {%- else -%}

        {{ custom_database_name.upper() | trim }}

    {%- endif -%}

{%- endmacro %}