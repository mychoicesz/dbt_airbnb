WITH raw_hosts AS (
SELECT * FROM {{ source('airbnb', 'hosts') }}
)
SELECT
ID AS host_id,
NAME AS HOST_NAME,
IS_SUPERHOST,
CREATED_AT,
UPDATED_AT
FROM raw_hosts