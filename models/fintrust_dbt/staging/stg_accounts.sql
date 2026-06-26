{{ config(materialized='view') }} 



select 
    account_id, 
    customer_id, 
    account_number, 
    account_type, 
    branch_code, 
    ifsc_code,
    opened_date, 
    status, 
    current_balance, 
    interest_rate,
    updated_at,
   coalesce(interest_rate > 0, false) as is_interest_bearing
 from {{ source('accounts', 'accounts') }} 