{% docs fct_sales__description %}
Fact table containing each sale order item (delivered or shipped).
All other order statuses `(less than 1% of records)`, and records missing an order item, are filtered out in the intermediate view `sales_order_items_joined`.
The date of reference for a sale is `order_purchase_timestamp`.
{% enddocs %}
