{{ config(materialized='view') }} 


select 
    payment_id,
    loan_id,
    payment_date,
    emi_amount,
    principal_paid,
    interest_paid,
    penalty_amount,
    payment_status,
    days_overdue,
    (principal_paid + interest_paid + penalty_amount) as total_paid
from {{ source('loans', 'loan_payments') }}
where payment_id is not null