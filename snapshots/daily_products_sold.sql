{% snapshot daily_products_sold %}

{{
  config(
    target_schema='dbt_sandbox1',
    unique_key='product_id',
    strategy='timestamp',
    updated_at='order_date',
    invalidate_hard_deletes=True
  )
}}

select * FROM {{ ref('fct_daily_products_sold_incremental') }}

{% endsnapshot %}
