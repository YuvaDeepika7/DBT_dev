{{ config(materialized='view') }} 

select 
    click_id, 
    campaign_id, 
    customer_id, 
    clicked_at, 
    device_type, 
    converted,
    hour(clicked_at) as click_hour
from {{ source('marketing', 'campaign_clicks') }}