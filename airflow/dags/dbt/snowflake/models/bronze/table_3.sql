
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

-- {{ config(materialized='view') }}

WITH raw_data AS (
SELECT DISTINCT
	v:data.body.data.objectId AS column_id,
    v:data.column_1 AS column_1,
	v:data.column_2 AS column_2
FROM
	{{ source('staging', 'table_3') }})
SELECT
	*
FROM
	raw_data
