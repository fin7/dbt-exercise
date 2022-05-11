{% test nonnegative_value(model, column_name) %}

select

  *

from {{ model }}

where {{ column_name }} < 0
limit 10

{% endtest %}
