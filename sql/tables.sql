kubectl exec -it trino-coordinator-pod-name -n warehouse -- trino

SHOW CATALOGS;

SHOW SCHEMAS IN minio;

SHOW TABLES FROM minio.landing;


CREATE SCHEMA IF NOT EXISTS minio.landing WITH (location = 's3://lakehouse-data/landing');

DROP TABLE minio.landing.binancecoin;
CREATE TABLE minio.landing.binancecoin (
    _airbyte_raw_id VARCHAR,
    _airbyte_extracted_at VARCHAR,
    _airbyte_generation_id VARCHAR,
    _airbyte_meta VARCHAR,
    _airbyte_data VARCHAR
) WITH (
    format = 'CSV',
    external_location = 's3a://lakehouse-data/landing/binancecoin'
);

DROP TABLE minio.landing.bitcoin;
CREATE TABLE minio.landing.bitcoin (
    _airbyte_raw_id VARCHAR,
    _airbyte_extracted_at VARCHAR,
    _airbyte_generation_id VARCHAR,
    _airbyte_meta VARCHAR,
    _airbyte_data VARCHAR
) WITH (
    format = 'CSV',
    external_location = 's3a://lakehouse-data/landing/bitcoin'
);

DROP TABLE minio.landing.cardano;
CREATE TABLE minio.landing.cardano (
    _airbyte_raw_id VARCHAR,
    _airbyte_extracted_at VARCHAR,
    _airbyte_generation_id VARCHAR,
    _airbyte_meta VARCHAR,
    _airbyte_data VARCHAR
) WITH (
    format = 'CSV',
    external_location = 's3a://lakehouse-data/landing/cardano'
);

DROP TABLE minio.landing.ethereum;
CREATE TABLE minio.landing.ethereum (
    _airbyte_raw_id VARCHAR,
    _airbyte_extracted_at VARCHAR,
    _airbyte_generation_id VARCHAR,
    _airbyte_meta VARCHAR,
    _airbyte_data VARCHAR
) WITH (
    format = 'CSV',
    external_location = 's3a://lakehouse-data/landing/ethereum'
);

DROP TABLE minio.landing.solana;
CREATE TABLE minio.landing.solana (
    _airbyte_raw_id VARCHAR,
    _airbyte_extracted_at VARCHAR,
    _airbyte_generation_id VARCHAR,
    _airbyte_meta VARCHAR,
    _airbyte_data VARCHAR
) WITH (
    format = 'CSV',
    external_location = 's3a://lakehouse-data/landing/solana'
);
