select

    {{ dbt_utils.surrogate_key(['order_id', 'order_item_id']) }}
    as unique_order_item_id,
    cast(order_item_id as string) as order_item_id,
    order_id,
    product_id,
    price,
    freight_value

from {{ source('ecommerce_sales_sources', 'order_items') }}
