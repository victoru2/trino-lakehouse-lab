{{
    config(
        materialized='table',
        schema='bronze',
        alias='ethereum'
    )
}}
WITH raw_data AS (
SELECT DISTINCT
    'eth' AS coin_id,
    'ethereum' AS coin_name,
	_airbyte_raw_id AS id,
    _airbyte_extracted_at AS extracted_at,
    _airbyte_generation_id AS generation_id,
    _airbyte_meta AS metadata,
    _airbyte_data AS raw_data
FROM
	{{ source('minio', 'ethereum') }})
SELECT
	*
FROM
	raw_data
