{{
    config(
        materialized='table',
        tags=["silver"]
    )
}}
WITH 
    raw_data AS (
        SELECT DISTINCT
            coin_id,
            coin_name,
            CAST(from_unixtime(CAST(price[1] / 1000 AS bigint)) AS varchar) AS ctimestamp,
            price[2] AS price
        FROM
            {{ source('iceberg_bronze', 'cardano_bronze') }},
            UNNEST(cast(json_extract(cast(raw_data AS varchar), '$.prices') AS array(array(double)))) AS t(price)
    )
SELECT
	*
FROM
	raw_data
