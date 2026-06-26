{{ config(materialized='table') }} 

with dim_prod as
(
    select 
        product_id, 
        sum(stock_qty)       as total_stock, 
        count(warehouse_id)  as warehouses_stocked 
    from {{ ref('stg_inventory') }} 
    group by 1 
)

select 
    p.product_id, 
    p.product_name, 
    p.category, 
    p.sub_category, 
    p.brand, 
    p.price, 
    p.cost_price, 
    p.gross_margin, 
    p.margin_pct, 
    p.is_active, 
    p.launched_at, 
    coalesce(inv.total_stock, 0)         as total_stock, 
    coalesce(inv.warehouses_stocked, 0)  as warehouses_stocked 
from {{ ref('stg_products') }} as p 
left join dim_prod as inv 
on p.product_id = inv.product_id 