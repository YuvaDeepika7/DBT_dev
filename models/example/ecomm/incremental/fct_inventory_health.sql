{{ 
    config( 
        materialized = 'incremental', 
        unique_key   = ['product_id', 'warehouse_id'] 
    ) 
}} 


select 
    i.product_id, 
    i.warehouse_id, 
    w.warehouse_name, 
    w.city                              as warehouse_city, 
    p.product_name, 
    p.category, 
    i.stock_qty, 
    i.reorder_level, 
    i.stock_status, 
    i.last_updated, 
    current_timestamp                   as snapshot_at 
from {{ ref('stg_inventory') }} as i 
INNER JOIN {{ ref('stg_warehouses') }} as w 
    ON i.warehouse_id = w.warehouse_id 
INNER JOIN {{ ref('stg_products') }} as p 
    ON i.product_id = p.product_id 


{% if is_incremental() %} 
    where i.last_updated > ( 
        select max(last_updated) from {{ this }} 
    ) 


{% endif %} 