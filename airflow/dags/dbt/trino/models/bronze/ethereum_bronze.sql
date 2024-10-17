{{
    config(
        materialized='table',
        tags=["bronze"]
    )
}}
WITH raw_data AS (
SELECT DISTINCT
    raw_data
FROM
	{{ source('minio', 'ethereum') }})
SELECT
	*
FROM
	raw_data
