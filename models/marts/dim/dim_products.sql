with products as (

  select
    *

  from {{ ref('stg_products') }}

),

sales_order_items as (

  select
    order_item_id,
    order_id,
    product_id,
    price,
    freight_value

  from {{ ref('sales_order_items_joined') }}

),

joined as (

  select

    p.product_id,
    count(*) as total_units_sold,
    round(sum(soi.price) + sum(soi.freight_value), 2) as total_revenue,
    case
      when row_number() over (order by count(*) desc)<=10 then TRUE
      else FALSE
    end as is_top10_product,
    max(p.product_length_cm) * max(p.product_height_cm) * max(p.product_width_cm) as product_volume_cubic_cm

  from products p
  left join sales_order_items soi using(product_id)

  group by 1

)

select * from joined
