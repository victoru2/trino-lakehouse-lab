{% macro sample_rows(sample_rows=10) %}
    {#
    Applies a row sampling clause to a SQL query in non-production environments.
    This macro is used to limit the percentage of rows processed during development and testing,
    allowing for faster query execution and reduced resource usage.

    Args:
        sample_rows (int, optional): The percentage of rows to sample in non-production environments.
                                     Defaults to 10, which means 10% of rows will be sampled.

    Returns:
        str: A SQL clause for row sampling (`TABLESAMPLE`) or an empty string if in a production environment.

    Example:
        SELECT * FROM {{ ref('your_table') }} {{ sample_rows(10) }}

    Note:
        The sampling is only applied when the target environment is not set to 'prod'.
        In such cases, a percentage of the total rows (e.g., 10%) is selected.
    #}

  {% if target.name | lower != 'prod' %}
    TABLESAMPLE BERNOULLI ({{ sample_rows }})
  {% endif %}
{% endmacro %}
