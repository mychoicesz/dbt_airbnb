{{
    config(
        materialized = 'view'
    )
}}
WITH src_hosts AS (
SELECT * FROM {{ ref('src_hosts')}}
)
SELECT
host_id,
NVL(HOST_NAME, 'Anonymous') as HOST_NAME,
IS_SUPERHOST,
CREATED_AT,
UPDATED_AT
FROM src_hosts