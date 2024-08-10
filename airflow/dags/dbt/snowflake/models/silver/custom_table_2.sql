
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

-- {{ config(materialized='view') }}

SELECT
	column_id,
    column_1,
	column_2
FROM
	{{ ref('table_2') }}
QUALIFY ROW_NUMBER() OVER (PARTITION BY column_id ORDER BY column_2 DESC) = 1
