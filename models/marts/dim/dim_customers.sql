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

    customers.customer_unique_id,
    count(distinct sales_order_items.order_id) as order_count,
    (round(sum(sales_order_items.price) + sum(sales_order_items.freight_value),
     2)) as total_order_value,
    min(sales_order_items.order_purchase_timestamp) as first_order_date,
    max(sales_order_items.order_purchase_timestamp) as last_order_date,
    max(order_stats.order_value) as highest_order_value


  from sales_order_items
  left join order_stats using(order_id)
  left join customers using(customer_id)

  group by 1

)

select * from joined
