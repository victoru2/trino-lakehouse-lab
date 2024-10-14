import os
import logging
from datetime import datetime, timedelta
from pathlib import Path

from airflow.decorators import dag
from airflow.operators.empty import EmptyOperator
from cosmos import (
    DbtTaskGroup,
    ProfileConfig,
    ProjectConfig,
    RenderConfig
)

logger = logging.getLogger(__name__)

default_args = {
    "owner": "victor",
    "retries": 2,
    "retry_delay": timedelta(minutes=5)
}

default_dbt_root_path = Path(__file__).parent / "dbt/trino"
dbt_root_path = Path(os.getenv("DBT_ROOT_PATH", default_dbt_root_path))

profile_bronze = ProfileConfig(
    profile_name="iceberg_bronze",
    target_name="prod",
    profiles_yml_filepath=(dbt_root_path / "profiles.yml")
)

profile_silver = ProfileConfig(
    profile_name="iceberg_silver",
    target_name="prod",
    profiles_yml_filepath=(dbt_root_path / "profiles.yml")
)

project_config = ProjectConfig(
    dbt_project_path=(dbt_root_path)
)

@dag(
    dag_id="dbt_iceberg_transform_with_schemas",
    schedule_interval=timedelta(minutes=5),
    start_date=datetime(2024, 2, 23),
    catchup=False,
    max_active_runs=1,
    default_args=default_args,
    tags=["ETL", "trino", "iceberg", "DBT", "Cosmos"]
)
def dbt_iceberg_dag():

    start_task = EmptyOperator(task_id="start")

    bronze_task_group = DbtTaskGroup(
        group_id="bronze_models",
        project_config=project_config,
        profile_config=profile_bronze,
        render_config=RenderConfig(select=['path:models/bronze'])
    )

    silver_task_group = DbtTaskGroup(
        group_id="silver_models",
        project_config=project_config,
        profile_config=profile_silver,
        render_config=RenderConfig(select=['path:models/silver'])
    )

    start_task >> bronze_task_group >> silver_task_group

dbt_iceberg_dag = dbt_iceberg_dag()
