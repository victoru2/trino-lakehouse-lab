kubectl exec -it trino-coordinator-pod-name -n warehouse -- trino

SHOW CATALOGS;

SHOW SCHEMAS IN minio;

CREATE SCHEMA IF NOT EXISTS minio.landing WITH (location = 's3://raw-data-lake/landing');

SHOW TABLES FROM minio.landing;


CREATE TABLE minio.landing.binancecoin (
    raw_data VARCHAR
) WITH (
    format = 'TEXTFILE',
    external_location = 's3a://raw-data-lake/landing/binancecoin'
);

CREATE TABLE minio.landing.bitcoin (
    raw_data VARCHAR
) WITH (
    format = 'TEXTFILE',
    external_location = 's3a://raw-data-lake/landing/bitcoin'
);

CREATE TABLE minio.landing.cardano (
    raw_data VARCHAR
) WITH (
    format = 'TEXTFILE',
    external_location = 's3a://raw-data-lake/landing/cardano'
);

CREATE TABLE minio.landing.ethereum (
    raw_data VARCHAR
) WITH (
    format = 'TEXTFILE',
    external_location = 's3a://raw-data-lake/landing/ethereum'
);

CREATE TABLE minio.landing.solana (
    raw_data VARCHAR
) WITH (
    format = 'TEXTFILE',
    external_location = 's3a://raw-data-lake/landing/solana'
);
