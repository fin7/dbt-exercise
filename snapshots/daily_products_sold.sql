{% snapshot daily_products_sold %}

{{
  config(
    target_schema='dbt_sandbox1',
    unique_key='product_date_id',
    strategy='check',
    check_cols=['units_sold']
  )
}}

select * FROM {{ ref('fct_daily_products_sold_incremental') }}

{% endsnapshot %}
