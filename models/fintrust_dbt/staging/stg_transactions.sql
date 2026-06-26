{{ config(materialized='view') }} 


select transaction_id,
       account_id,
       transaction_date,
       transaction_type,
       channel,
       amount,
       balance_after,
       description,
       status,
       created_at,
       coalesce(transaction_type = 'credit',false) as is_credit,
       coalesce(transaction_type = 'debit',false) as is_debit
from {{ source('transactions', 'transactions') }}
where transaction_id is not null