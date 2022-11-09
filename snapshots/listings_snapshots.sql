{% snapshot listings_snapshot %}
{{
    config(
        target_schema='snapshots',
        unique_key='id',
        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes=True
    )
}}
select * FROM {{ source('airbnb', 'listings') }}
{% endsnapshot %}