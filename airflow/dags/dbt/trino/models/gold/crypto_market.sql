{{
    config(
        materialized='table',
        tags=["silver"]
    )
}}
WITH 
    binancecoin_silver AS (
        SELECT
            id
            ,symbol
            ,name
            ,last_updated
            ,base
            ,target
            ,market
            ,last_value
            ,volume
            ,converted_volume_usd
            ,trust_score
            ,timestamp
            ,bid_ask_spread_percentage
        FROM 
            {{ source('iceberg_silver', 'binancecoin_silver') }}
    )
    ,bitcoin_silver AS (
        SELECT
            id
            ,symbol
            ,name
            ,last_updated
            ,base
            ,target
            ,market
            ,last_value
            ,volume
            ,converted_volume_usd
            ,trust_score
            ,timestamp
            ,bid_ask_spread_percentage
        FROM 
            {{ source('iceberg_silver', 'bitcoin_silver') }}
    )
    ,cardano_silver AS (
        SELECT
            id
            ,symbol
            ,name
            ,last_updated
            ,base
            ,target
            ,market
            ,last_value
            ,volume
            ,converted_volume_usd
            ,trust_score
            ,timestamp
            ,bid_ask_spread_percentage
        FROM 
            {{ source('iceberg_silver', 'cardano_silver') }}
    )
    ,ethereum_silver AS (
        SELECT
            id
            ,symbol
            ,name
            ,last_updated
            ,base
            ,target
            ,market
            ,last_value
            ,volume
            ,converted_volume_usd
            ,trust_score
            ,timestamp
            ,bid_ask_spread_percentage
        FROM 
            {{ source('iceberg_silver', 'ethereum_silver') }}
    )
    ,solana_silver AS (
        SELECT
            id
            ,symbol
            ,name
            ,last_updated
            ,base
            ,target
            ,market
            ,last_value
            ,volume
            ,converted_volume_usd
            ,trust_score
            ,timestamp
            ,bid_ask_spread_percentage
        FROM 
            {{ source('iceberg_silver', 'solana_silver') }}
    )
SELECT * FROM binancecoin_silver
UNION
SELECT * FROM bitcoin_silver
UNION
SELECT * FROM cardano_silver
UNION
SELECT * FROM ethereum_silver
UNION
SELECT * FROM solana_silver
