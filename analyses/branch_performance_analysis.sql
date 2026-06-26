-- Branch performance: default risk vs transaction volume 
-- Compile with: dbt compile --select branch_performance_analysis 


select 
    a.account_id,
    b.branch_code, 
    b.branch_name, 
    b.zone, 
    count(fl.loan_id)                        as total_loans, 
    count(case when fl.default_risk != 'low' 
        then 1 end)                          as overdue_loans, 
    round(count(case when fl.default_risk != 'low' 
        then 1 end) 
        / nullif(count(fl.loan_id), 0) 
        * 100, 2)                            as overdue_rate_pct, 
    sum(dt.total_transactions)               as total_transactions, 
    sum(dt.total_credit_amount 
        + dt.total_debit_amount)             as total_transaction_value 
from {{ ref('branch_master') }} as b 
left join {{ ref('fct_loan_summary') }} as fl 
    on b.branch_code = fl.branch_code 
left join {{ ref('stg_accounts') }} as a 
    on b.branch_code = a.branch_code 
left join {{ ref('fct_daily_transactions') }} as dt 
    on a.account_id = dt.unique_accounts 
group by 1, 2, 3 
order by 7 desc, 8 asc 