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
	{{ source('minio', 'bitcoin') }})
SELECT
	*
FROM
	raw_data
