{{ 
    config(materialized='view') 
    
}} 

select 
    order_id, 
    customer_id, 
    order_date, 
    status, 
    total_amount, 
    discount_amount, 
    shipping_amount, 
    created_at, 
    updated_at,
    total_amount - discount_amount    as net_amount
from {{ source('orders', 'orders') }} 
where order_id is not null 