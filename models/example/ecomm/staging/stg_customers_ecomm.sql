{{ 
    config(materialized='view') 
    
}} 

select 
    customer_id, 
    first_name, 
    last_name,
    phone, 
    city, 
    state, 
    signup_date, 
    is_active, 
    updated_at,
    lower(email) as email,
    first_name || ' ' || last_name   as full_name
from {{ source('customers', 'customers') }} 
where customer_id is not null 