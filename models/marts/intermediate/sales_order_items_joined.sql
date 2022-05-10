with sales as (

  select

    *

  from {{ ref('sales_filtered') }}

),

order_items as (

  select

    *

  from {{ ref('stg_order_items') }}

),

joined as (

  select

    oi.order_item_id,
    oi.product_id,
    oi.price,
    oi.freight_value,
    s.*

  from sales s
  left join order_items oi using(order_id)

)

select * from joined
