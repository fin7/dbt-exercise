with customers as (

  select
    customer_unique_id,
    customer_id

  from {{ ref('stg_customers') }}

),

sales_order_items as (

  select
    order_item_id,
    order_id,
    customer_id,
    order_purchase_timestamp,
    price,
    freight_value

  from {{ ref('sales_order_items_joined') }}

),

order_stats as (

  select
    order_id,
    round(sum(price) + sum(freight_value), 2) as order_value

  from sales_order_items
  group by 1

),

joined as (

  select

    c.customer_unique_id,
    count(distinct soi.order_id) as order_count,
    round(sum(soi.price) + sum(soi.freight_value), 2) as total_order_value,
    min(soi.order_purchase_timestamp) as first_order_date,
    max(soi.order_purchase_timestamp) as last_order_date,
    max(os.order_value) as highest_order_value


  from sales_order_items soi
  left join order_stats os using(order_id)
  left join customers c using(customer_id)

  group by 1

)

select * from joined
