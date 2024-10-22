{{
    config(
        materialized='incremental',
        unique_key='extracted_at',
        incremental_strategy='delete+insert',
        tags=["bronze"]
    )
}}
WITH raw_data AS (
    SELECT
        raw_data,
        json_extract_scalar(cast(raw_data AS VARCHAR), '$._airbyte_extracted_at') AS extracted_at
    FROM
        {{ source('minio', 'bitcoin') }}
        {{ sample_rows(10) }}
    )
SELECT
	*
FROM
	raw_data
{% if is_incremental() %}
WHERE
    extracted_at > (
        SELECT MAX(extracted_at) FROM {{ this }}
    )
{% endif %}
