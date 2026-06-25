{{ config(materialized='view') }} 


select kyc_id,
       kyc_status,
       CASE 
    WHEN kyc_status = 'verified' THEN TRUE
    ELSE FALSE
  END AS is_verified
from {{ source('customers_1', 'kyc_details') }}
where kyc_id is not null

