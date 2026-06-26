{{ config(materialized='table') }} 


 select 
    lh.loan_id, 
    lh.customer_id, 
    lh.loan_type, 
    lh.principal_amount, 
    lh.outstanding_amount, 
    lh.branch_code, 
    lh.is_overdue, 
    lh.loan_age_months, 
    lh.total_payments_made, 
    lh.total_amount_paid, 
    lh.total_penalty_paid, 
    lh.max_days_overdue, 
    lh.risk_weight                           as loan_type_risk, 
    b.branch_name, 
    b.zone, 
    round(lh.total_amount_paid 
        / nullif(lh.principal_amount, 0) 
        * 100, 2)                            as repayment_rate, 
    case 
        when lh.is_overdue 
         and lh.max_days_overdue > 30 then 'high' 
        when lh.is_overdue            then 'medium' 
        else                               'low' 
    end                                      as default_risk 
from {{ ref('int_loan_health') }} lh 
left join {{ ref('branch_master') }} b 
    on lh.branch_code = b.branch_code 