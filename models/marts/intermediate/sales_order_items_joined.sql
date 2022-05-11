{{
  config(
    materialized = 'view'
    )
}}

with sales as (

  select

    *

  from {{ ref('stg_orders') }}

  where
    order_status='delivered' or
    order_status='shipped'

),

order_items as (

  select

    *

  from {{ ref('stg_order_items') }}

),

joined as (

  select

    order_items.unique_order_item_id,
    order_items.order_item_id,
    order_items.product_id,
    order_items.price,
    order_items.freight_value,
    sales.*

  from sales
  left join order_items using(order_id)

  where order_items.order_item_id is not null

)

select * from joined
