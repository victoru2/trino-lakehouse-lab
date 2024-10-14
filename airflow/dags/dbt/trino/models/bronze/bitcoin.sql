{{
    config(
        materialized='table',
        schema='bronze',
        alias='bitcoin'
    )
}}
WITH raw_data AS (
SELECT DISTINCT
    'btc' AS coin_id,
    'bitcoin' AS coin_name,
	_airbyte_raw_id AS id,
    _airbyte_extracted_at AS extracted_at,
    _airbyte_generation_id AS generation_id,
    _airbyte_meta AS metadata,
    _airbyte_data AS raw_data
FROM
	{{ source('minio', 'bitcoin') }})
SELECT
	*
FROM
	raw_data
