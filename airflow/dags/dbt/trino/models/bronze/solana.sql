{{
    config(
        materialized='table',
        schema='bronze',
        alias='solana'
    )
}}
WITH raw_data AS (
SELECT DISTINCT
    'sol' AS coin_id,
    'solana' AS coin_name,
	_airbyte_raw_id AS id,
    _airbyte_extracted_at AS extracted_at,
    _airbyte_generation_id AS generation_id,
    _airbyte_meta AS metadata,
    _airbyte_data AS raw_data
FROM
	{{ source('minio', 'solana') }})
SELECT
	*
FROM
	raw_data
