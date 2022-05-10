select

    *

from {{ source('ecommerce_sales_sources', 'products') }}
