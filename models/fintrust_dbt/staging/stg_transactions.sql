{{ config(materialized='view') }} 


select TRANSACTION_ID,
       ACCOUNT_ID,
       TRANSACTION_DATE,
       TRANSACTION_TYPE,
       CHANNEL,
       AMOUNT,
       BALANCE_AFTER,
       DESCRIPTION,
       STATUS,
       CREATED_AT,
       CASE 
    WHEN transaction_type = 'credit' THEN TRUE
    ELSE FALSE
  END AS is_credit,
  CASE 
    WHEN transaction_type = 'debit' THEN TRUE
    ELSE FALSE
  END AS is_debit
from {{ source('transactions', 'transactions') }}
where TRANSACTION_ID is not null