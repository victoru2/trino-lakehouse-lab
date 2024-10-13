kubectl exec -it trino-coordinator-75cdf47cbd-7lqsd -n warehouse -- trino

SHOW CATALOGS;

SHOW SCHEMAS IN minio;
SHOW SCHEMAS IN iceberg;

SHOW TABLES FROM <nombre_catalogo>.<nombre_schema>;


CREATE SCHEMA IF NOT EXISTS minio.landing WITH (location = 's3://lakehouse-data/landing');
CREATE SCHEMA IF NOT EXISTS iceberg.landing WITH (location = 's3://lakehouse-data/landing');
CREATE SCHEMA IF NOT EXISTS minio.bronze WITH (location = 's3://lakehouse-data/bronze');
CREATE SCHEMA IF NOT EXISTS iceberg.bronze WITH (location = 's3://lakehouse-data/bronze');


SELECT * FROM read_csv('s3a://lakehouse-data/landing/bitcoin/*.csv');


DROP TABLE minio.landing.bitcoinvii;

CREATE TABLE minio.landing.bitcoinvii (
    _airbyte_raw_id VARCHAR,
    _airbyte_extracted_at VARCHAR,
    _airbyte_generation_id VARCHAR,
    _airbyte_meta VARCHAR,
    _airbyte_data VARCHAR
) WITH (
    format = 'CSV',
    external_location = 's3a://lakehouse-data/landing/bitcoin'
);

SELECT * FROM minio.landing.bitcoinvii LIMIT 100;

SELECT _airbyte_raw_id AS id, _airbyte_data AS data_raw FROM minio.landing.bitcoinvii LIMIT 10;

SELECT 
    _airbyte_raw_id AS id,
    price[1] AS timestamp,
    price[2] AS price
FROM 
    minio.landing.bitcoinvii,
    UNNEST(cast(json_extract(cast(_airbyte_data AS varchar), '$.prices') AS array(array(double)))) AS t(price)
LIMIT 10;

CREATE TABLE iceberg.bronze.btc AS
SELECT 
    'BTC' AS coin,
    _airbyte_raw_id AS id,
    CAST(from_unixtime(CAST(price[1] / 1000 AS bigint)) AS varchar) AS ctimestamp,
    price[2] AS price
FROM 
    minio.landing.bitcoinvii,
    UNNEST(cast(json_extract(cast(_airbyte_data AS varchar), '$.prices') AS array(array(double)))) AS t(price);

SELECT * FROM iceberg.bronze.btc LIMIT 10;




CREATE TABLE iceberg.landing.bitcoinvii (
    _airbyte_raw_id VARCHAR,
    _airbyte_extracted_at VARCHAR,
    _airbyte_generation_id VARCHAR,
    _airbyte_meta VARCHAR,
    _airbyte_data VARCHAR
) WITH (
    format = 'PARQUET',
    location = 's3a://lakehouse-data/landing/bitcoin/bitcoin_iceberg'
);

SELECT * FROM iceberg.landing.bitcoinvii LIMIT 10;