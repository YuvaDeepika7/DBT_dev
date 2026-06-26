-- Ad-hoc analysis: customer lifetime value by tier and state
-- Not materialized — compile and run manually

select
    dc.state,
    dc.customer_tier,
    count(dc.customer_id)           as total_customers,
    sum(dc.lifetime_value)          as total_revenue,
    avg(dc.lifetime_value)          as avg_ltv,
    avg(dc.total_orders)            as avg_orders_per_customer,
    avg(dc.days_since_last_order)   as avg_days_since_order
from {{ ref('dim_customers') }} as dc
group by 1, 2
order by 4 desc