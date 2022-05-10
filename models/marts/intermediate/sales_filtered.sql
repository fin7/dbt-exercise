select

  *

from {{ ref('stg_orders') }}

where
  order_status='delivered' or
  order_status='shipped'
