{{config(materialized = 'table')}}


Select c.Customer_id,
c.first_name,
c.last_name,
c.email,
count(o.order_id) as totat_orders,
sum(o.amount) as totat_spent,
min(o.order_date) as first_order_date,
max(o.order_date) as last_order_date
From {{ref('stg_customers_ref')}} c
left join {{ref('stg_orders')}} o
on c.customer_id = o.customer_id
group by 1,2,3,4