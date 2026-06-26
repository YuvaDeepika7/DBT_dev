{{ 

    config( 
        materialized     = 'incremental', 
        unique_key       = 'transaction_date', 
        on_schema_change = 'sync_all_columns' 
    ) 

}} 

select 
    transaction_date, 
    count(transaction_id)                    as total_transactions, 
    count(case when status = 'success' 
        then 1 end)                          as successful_transactions, 
    count(case when status = 'failed' 
        then 1 end)                          as failed_transactions, 
    sum(case when is_credit = true 
        then amount else 0 end)              as total_credit_amount, 
    sum(case when is_debit = true 
        then amount else 0 end)              as total_debit_amount, 
    sum(case when is_credit = true 
        then amount else 0 end) 
    - sum(case when is_debit = true 
        then amount else 0 end)              as net_flow, 
    count(distinct account_id)               as unique_accounts, 
    current_timestamp                        as loaded_at 
from {{ ref('stg_transactions') }} 

{% if is_incremental() %} 
    where transaction_date > ( 
        select dateadd('day', -3, max(transaction_date)) 
        from {{ this }} 
    ) 
{% endif %} 
group by 1 