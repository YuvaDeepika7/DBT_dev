{{ config(materialized='view') }} 

select 
    ticket_id, 
    customer_id, 
    account_id, 
    ticket_category, 
    priority, 
    status,
    channel, 
    created_at, 
    resolved_at, 
    sla_hours,
    branch_code, 
    datediff('hour', created_at, 
    coalesce(resolved_at, current_timestamp)) as hours_to_resolve, 
    case 
        when resolved_at is null then FALSE 
        when datediff('hour', created_at, resolved_at) > sla_hours then TRUE 
        else FALSE 
    end as is_sla_breached 
from {{ source('support_1', 'support_tickets') }} 