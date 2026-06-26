{{
config(materialized = 'ephemeral')
}}


select order_id,
customer_id,
order_date
from {{ ref('stg_orders') }}
where status!='returned'