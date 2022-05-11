select

  *

from {{ ref('fct_sales') }}

where
  order_status='delivered'
  and order_delivered_customer_date is null
limit 10
