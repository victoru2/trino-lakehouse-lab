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
        {{ source('minio', 'bitcoin') }}
        {{ sample_rows(10) }}
    )
SELECT
	*
FROM
	raw_data
