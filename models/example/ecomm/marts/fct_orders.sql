{{ config(materialized='table') }} 

select 
    oe.order_id, 
    oe.customer_id, 
    oe.order_date, 
    oe.status, 
    oe.net_amount, 
    oe.discount_amount, 
    oe.shipping_amount, 
    oe.item_count, 
    oe.total_quantity, 
    oe.order_tier, 
    oe.is_completed, 
    p.status as payment_status, 
    p.payment_method, 
    p.gateway, 
    p.collected_amount, 
    s.carrier, 
    s.shipped_date, 
    s.delivered_date, 
    s.transit_days, 
    s.is_delayed, 
    t.ticket_id, 
    t.ticket_type, 
    t.is_sla_breached 
from {{ ref('int_orders_enriched') }} as oe 
left join {{ ref('stg_payments') }} as p 
    on oe.order_id = p.order_id 
left join {{ ref('stg_shipments') }} as s 
    on oe.order_id = s.order_id 
left join {{ ref('stg_support_tickets') }} as t 
    on oe.order_id = t.order_id 