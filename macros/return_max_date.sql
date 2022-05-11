{% macro get_max_date(model, date_column) %}

select

  max({{ date_column }}) 

from {{ model }}

{% endmacro %}
