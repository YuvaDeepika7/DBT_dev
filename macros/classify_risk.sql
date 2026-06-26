{% macro classify_risk(column_name) %} 


    case 
        when {{ column_name }} = 'high'   then 'critical' 
        when {{ column_name }} = 'medium' then 'watch' 
        when {{ column_name }} = 'low'    then 'safe' 
        else 'unknown' 
    end 


{% endmacro %} 