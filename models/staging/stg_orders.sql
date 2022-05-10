select

    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_delivered_customer_date

from {{ source('ecommerce_sales_sources', 'orders') }}
