-- Fails if any overdue payment has zero penalty 

select 
    payment_id, 
    loan_id, 
    payment_status, 
    penalty_amount 
from {{ ref('stg_loan_payments') }} 
where payment_status = 'overdue' 
  and penalty_amount = 0 