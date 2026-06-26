{{ config(materialized='view') }} 


select
    address_id,
    customer_id,
    address_type,
    street,
    city,
    state,
    pincode,
    is_default,
    address_type = 'shipping' as is_shipping
from {{ source('customers','customer_addresses') }}