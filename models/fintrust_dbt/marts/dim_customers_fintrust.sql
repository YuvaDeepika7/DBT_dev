{{ config(materialized='table') }} 


select a.account_id,
    cf.customer_id, 
    cf.full_name, 
    cf.customer_segment, 
    cf.age, 
    cf.city, 
    cf.state, 
    cf.is_active, 
    cf.kyc_status, 
    --cf.risk_flag, 
    --cf.annual_income, 
    cf.total_accounts, 
    cf.total_balance, 
    cf.has_fixed_deposit, 
    b.branch_name, 
    b.zone ,
    count(l.loan_id)                         as loan_count, 
    coalesce(case
    when cf.total_balance >= 1000000 then 'high_value'
    when cf.total_balance >= 100000 then 'mid_value'
    else 'low_value' end,  'low_value' ) as customer_tier,
    coalesce(count(l.loan_id) > 0, 'false') as has_active_loan
    from {{ ref('int_customer_financials') }} as cf 
left join {{ ref('stg_loans') }} as l 
    on cf.customer_id = l.customer_id and l.status = 'active' 
left join {{ ref('stg_accounts') }} as a 
    on cf.customer_id = a.customer_id    and a.status = 'active' 
left join {{ ref('branch_master') }} as  b 
    on a.branch_code = b.branch_code 
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14