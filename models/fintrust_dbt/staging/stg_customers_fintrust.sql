{{ config(materialized='view') }} 


select  customer_id,
        first_name,
        last_name,
        email,
        phone,
        date_of_birth,
        gender,
        city,
        state,
        pincode,
        customer_segment,
        onboarded_date,
        is_active,
        updated_at,
    first_name || ' ' || last_name   as full_name, 
    floor(datediff(day, date_of_birth, current_date) / 365.25) as age
from {{ source('customers_1', 'customers') }}
where customer_id is not null