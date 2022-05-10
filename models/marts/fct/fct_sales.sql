with sales_order_items as (

  select

    *

  from {{ ref('sales_order_items_joined') }}

),

customers as (

  select

    customer_unique_id,
    customer_id

  from {{ ref('stg_customers') }}

),

sales_customers_joined as (

  select

    soi.*,
    c.customer_unique_id,
    case
      when row_number() over
      (partition by c.customer_unique_id
        order by soi.order_purchase_timestamp)=1 then 'New'
      else 'Repeat'
    end as customer_type,
    date_diff(soi.order_delivered_customer_date, soi.order_purchase_timestamp, DAY)
    as days_from_purchase_to_delivery

  from sales_order_items soi
  left join customers c using(customer_id)

)

select * from sales_customers_joined
