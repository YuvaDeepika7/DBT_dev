{% macro is_sla_breached(created_col, resolved_col, sla_col) %} 

    case 
        when {{ resolved_col }} is null then false 
        when datediff('hour', 
            {{ created_col }}, 
            {{ resolved_col }}) > {{ sla_col }} then true 
        else false 
    end 

{% endmacro %} 