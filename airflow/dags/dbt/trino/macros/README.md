## DBT Macros Documentation

### `sample_rows`

The `sample_rows` macro adds a SQL `TABLESAMPLE` clause to limit the percentage of rows processed in non-production environments. This is useful for development and testing purposes, where working with a full dataset may be unnecessary and could lead to longer query times and increased resource usage.

**Parameters:**

- `sample_rows (int, optional)`: The percentage of rows to sample when the environment is not 'production' (`prod`). The default value is 10, which means 10% of rows will be sampled during testing or development unless specified otherwise.

**Returns:**

- `str`: A SQL `TABLESAMPLE` clause that limits the percentage of rows processed, or an empty string if the environment is set to 'production'.

**Example Usage:**

To apply row sampling of 10% in a query in non-production environments:

```sql
SELECT * FROM {{ ref('your_table') }} {{ sample_rows(10) }}
```
