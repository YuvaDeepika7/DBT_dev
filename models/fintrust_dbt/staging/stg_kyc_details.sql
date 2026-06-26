{{ config(materialized='view') }} 


select kyc_id,
       kyc_status,
       kyc_status = 'verified' as is_verified
from {{ source('customers_1', 'kyc_details') }}
where kyc_id is not null

