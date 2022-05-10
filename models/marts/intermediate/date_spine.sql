{{ dbt_utils.date_spine(
datepart="day",
start_date="to_date('09/04/2016', 'mm/dd/yyyy')",
end_date="to_date('10/17/2018', 'mm/dd/yyyy')"
)
}}
