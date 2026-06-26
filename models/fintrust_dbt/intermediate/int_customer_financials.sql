{{ config(materialized='ephemeral') }} 

select 
    c.customer_id, 
    c.full_name, 
    c.customer_segment, 
    c.age, 
    c.city, 
    c.state, 
    c.is_active, 
    k.kyc_status,
    k.annual_income, 
    {{ classify_risk('k.risk_category') }}   as risk_flag,  
    count(a.account_id)                      as total_accounts, 
    sum(a.current_balance)                   as total_balance, 
    coalesce(max(a.account_type = 'fixed_deposit'), false) as has_fixed_deposit
from {{ ref('stg_customers_fintrust') }} as c 
left join {{ ref('stg_kyc_details') }} as k 
    on c.customer_id = k.customer_id 
left join {{ ref('stg_accounts') }} as a 
    on c.customer_id = a.customer_id 
group by 1,2,3,4,5,6,7,8,9,10 