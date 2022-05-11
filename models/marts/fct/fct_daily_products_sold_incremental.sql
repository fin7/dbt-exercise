{{
  config(
    materialized = 'incremental',
    on_schema_change='fail'
    )
}}


with date_spine as (

    select
      date(date_day) as order_date

    from {{ ref('date_spine') }}

),

sales_order_items as (

  select
    date(order_purchase_timestamp) as order_date,
    product_id,
    count(*) as units_sold

  from {{ ref('sales_order_items_joined') }}
  group by 1,2

),

all_dates as (

  select
    {{ dbt_utils.surrogate_key(['product_id', 'order_date']) }}
    as product_date_id,
    date(date_spine.order_date) as order_date,
    products.product_id

    from date_spine

    cross join (select distinct product_id from sales_order_items) as products

),

daily_products_sold as (

  select
    all_dates.product_date_id,
    all_dates.order_date,
    all_dates.product_id,
    coalesce(sum(sales_order_items.units_sold), 0) as units_sold

  from all_dates
  left join sales_order_items
    on all_dates.order_date=sales_order_items.order_date
    and all_dates.product_id=sales_order_items.product_id

  group by 1,2,3

)

select * from daily_products_sold order by order_date, product_id


{% if is_incremental() %}
  and order_date > (select max(order_date) from {{ this }})
{% endif %}
