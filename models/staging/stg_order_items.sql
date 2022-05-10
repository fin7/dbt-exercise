select

    order_item_id,
    order_id,
    product_id,
    price,
    freight_value

from {{ source('ecommerce_sales_sources', 'order_items') }}
