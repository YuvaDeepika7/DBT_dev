{{ config(materialized='view') }} 

select 
    loan_id, 
    customer_id, 
    account_id, 
    loan_type, 
    principal_amount, 
    outstanding_amount,
    interest_rate, 
    tenure_months, 
    disbursed_date, 
    due_date,
    status,
    branch_code,
    updated_at,
    datediff('month', disbursed_date, CURRENT_DATE()) AS loan_age_months,
    CASE 
    WHEN status = 'overdue' THEN TRUE
    ELSE FALSE
  END AS is_overdue,
from {{ source('loans', 'loans') }} 