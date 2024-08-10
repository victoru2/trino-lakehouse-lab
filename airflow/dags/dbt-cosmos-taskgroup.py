import datetime as dt
from pathlib import Path

from airflow import DAG
from airflow.operators.empty import EmptyOperator

from cosmos import (
    DbtTaskGroup,
    ProjectConfig,
    ProfileConfig,
    ExecutionConfig)
from cosmos.profiles import SnowflakeUserPasswordProfileMapping

SNOWFLAKE_CONN_ID = "snowflake_connection"
default_dbt_root_path = Path(__file__).parent / "dbt/snowflake"

project_config = ProjectConfig(
    dbt_project_path=default_dbt_root_path,
)

profile_config = ProfileConfig(
    profile_name="dbt_cosmos",
    target_name="prod",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id=SNOWFLAKE_CONN_ID,
        profile_args={"schema": "staging"}
    )
)

execution_config = ExecutionConfig(
    dbt_executable_path=default_dbt_root_path
)

args = {
    "owner": "victor",
    "start_date": dt.datetime(2024, 7, 31),
    "retries": 5,
    "retry_delay": dt.timedelta(minutes=5),
    "snowflake_conn_id": SNOWFLAKE_CONN_ID
}

with DAG(
    catchup=False,
    dag_id="dbt_cosmos",
    max_active_runs=1,
    schedule_interval=None,
    default_args=args,
    tags=["ETL", "Snowflake", "Cosmos", "DBT"]
) as dag:

    inicio = EmptyOperator(
        task_id="inicio"
    )

    test_dbt = DbtTaskGroup(
        group_id="test_task_group",
        project_config=project_config,
        profile_config=profile_config,
        execution_config=execution_config
        # operator_args={
        #     "vars": '{"my_name": {{ params.my_name }} }',
        # }
    )

    inicio >> test_dbt
