{{ config(materialized='view') }} 


select  CUSTOMER_ID,
        FIRST_NAME,
        LAST_NAME,
        EMAIL,
        PHONE,
        DATE_OF_BIRTH,
        GENDER,
        CITY,
        STATE,
        PINCODE,
        CUSTOMER_SEGMENT,
        ONBOARDED_DATE,
        IS_ACTIVE,
        UPDATED_AT,
    FIRST_NAME || ' ' || LAST_NAME   as FULL_NAME, 
    FLOOR(DATEDIFF(day, date_of_birth, CURRENT_DATE) / 365.25) AS age
from {{ source('customers_1', 'customers') }}
where customer_id is not null