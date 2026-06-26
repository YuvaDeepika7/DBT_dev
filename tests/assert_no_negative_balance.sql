-- Fails if any account has a negative current_balance 

select 
    account_id, 
    current_balance 
from {{ ref('stg_accounts') }} 
where current_balance < 0 

 