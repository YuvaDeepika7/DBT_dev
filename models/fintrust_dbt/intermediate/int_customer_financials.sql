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
    {{ classify_risk('k.risk_category') }}   as risk_flag, 
    k.annual_income, 
    count(a.account_id)                      as total_accounts, 
    sum(a.current_balance)                   as total_balance, 
    max(case 
        when a.account_type = 'fixed_deposit' 
        then true else false 
    end)                                     as has_fixed_deposit 
from {{ ref('stg_customers') }} c 
left join {{ ref('stg_kyc_details') }} k 
    on c.customer_id = k.customer_id 
left join {{ ref('stg_accounts') }} a 
    on c.customer_id = a.customer_id 
group by 1,2,3,4,5,6,7,8,9,10 