{{ config(materialized='ephemeral') }} 
 
select 
    l.loan_id, 
    l.customer_id, 
    l.loan_type, 
    l.principal_amount, 
    l.outstanding_amount, 
    l.branch_code, 
    l.is_overdue, 
    l.loan_age_months,
    ltc.risk_weight, 
    count(lp.payment_id)                     as total_payments_made, 
    sum(lp.total_paid)                       as total_amount_paid, 
    sum(lp.penalty_amount)                   as total_penalty_paid, 
    max(lp.days_overdue)                     as max_days_overdue
from {{ ref('stg_loans') }} as l 
left join {{ ref('stg_loan_payments') }} as lp 
    on l.loan_id = lp.loan_id 
left join {{ ref('loan_type_config') }} as ltc 
    on l.loan_type = ltc.loan_type 
group by 1,2,3,4,5,6,7,8,9