{{
    config(
        materialized='incremental',
        unique_key='last_updated',
        incremental_strategy='delete+insert',
        tags=["silver"]
    )
}}
WITH 
    raw_data AS (
        SELECT
            json_extract(cast(raw_data AS varchar), '$._airbyte_data') AS raw_column
        FROM
            {{ source('iceberg_bronze', 'binancecoin_bronze') }}
        {% if is_incremental() %}
        WHERE from_iso8601_timestamp(json_extract_scalar(json_extract(cast(raw_data AS varchar), '$._airbyte_data'), '$.last_updated')) > (SELECT MAX(last_updated) FROM {{ this }})
        {% endif %}
    ),
    expanded_data AS (
        SELECT
            json_extract_scalar(raw_column, '$.id') AS id,
            json_extract_scalar(raw_column, '$.symbol') AS symbol,
            json_extract_scalar(raw_column, '$.name') AS name,
            json_extract_scalar(raw_column, '$.last_updated') AS last_updated,
            -- Aplicamos filtro para encontrar solo los elementos con market.name = 'Binance' y target = 'USDT'
            element_at(
                filter(
                    cast(json_extract(raw_column, '$.tickers') AS array(json)),
                    ticker -> 
                        json_extract_scalar(ticker, '$.market.name') = 'Binance' 
                        AND json_extract_scalar(ticker, '$.target') = 'USDT'
                ), 
                1
            ) AS binance_usdt_ticker
        FROM
            raw_data
    )
SELECT
    id
    ,symbol
    ,name
    ,from_iso8601_timestamp(last_updated) AS last_updated
    ,json_extract_scalar(binance_usdt_ticker, '$.base') AS base
    ,json_extract_scalar(binance_usdt_ticker, '$.target') AS target
    ,json_extract_scalar(binance_usdt_ticker, '$.market.name') AS market
    ,CAST(json_extract_scalar(binance_usdt_ticker, '$.last') AS DECIMAL(10,2)) AS last_value
    ,CAST(json_extract_scalar(binance_usdt_ticker, '$.volume') AS DECIMAL(18,6)) AS volume
    ,CAST(json_extract_scalar(binance_usdt_ticker, '$.converted_volume.usd') AS BIGINT) AS converted_volume_usd
    ,json_extract_scalar(binance_usdt_ticker, '$.trust_score') AS trust_score
    ,from_iso8601_timestamp(json_extract_scalar(binance_usdt_ticker, '$.timestamp')) AS timestamp
    ,CAST(json_extract_scalar(binance_usdt_ticker, '$.bid_ask_spread_percentage') AS DECIMAL(10,6)) AS bid_ask_spread_percentage
FROM 
    expanded_data
WHERE binance_usdt_ticker IS NOT NULL
