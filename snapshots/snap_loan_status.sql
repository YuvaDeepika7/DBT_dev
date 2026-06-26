{% snapshot snap_loan_status %} 

{{ 
    config( 
        target_database = 'FINTRUST_ANALYTICS', 
        target_schema   = 'SNAPSHOTS', 
        unique_key      = 'loan_id', 
        strategy        = 'check', 
        check_cols      = ['status', 'outstanding_amount'] 
    ) 

}} 

select 
    loan_id, 
    customer_id, 
    loan_type, 
    principal_amount, 
    outstanding_amount, 
    status, 
    branch_code, 
    updated_at 
from {{ ref('stg_loans') }} 

{% endsnapshot %} 