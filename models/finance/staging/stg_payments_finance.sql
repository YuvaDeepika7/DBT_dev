select
    payment_id,
    loan_id,
    due_date,
    paid_date,
    emi_amount,
    amount_paid,
    days_past_due,
    coalesce(days_past_due > 90,false) as is_npa
from {{ source('lending','raw_payments') }}