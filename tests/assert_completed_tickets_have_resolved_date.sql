-- Fails if any resolved ticket is missing resolved_at 

select 
    ticket_id, 
    status, 
    resolved_at 
from {{ ref('stg_support_tickets') }} 
where status = 'resolved' 
  and resolved_at is null 