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


def create_profile_config(profile_name, target_name):
    return ProfileConfig(
        profile_name=profile_name,
        target_name=target_name,
        profiles_yml_filepath=(dbt_root_path / "profiles.yml")
    )


def create_dbt_task_group(group_id,
                          profile_name,
                          target_name,
                          project_config,
                          path):
    return DbtTaskGroup(
        group_id=group_id,
        project_config=project_config,
        profile_config=create_profile_config(profile_name, target_name),
        render_config=RenderConfig(select=[f"path:models/{path}"])
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

    task_groups = ["bronze", "silver", "gold"]
    tasks = {}

    for group in task_groups:
        tasks[group] = create_dbt_task_group(
            f"{group}_models",
            f"iceberg_{group}",
            "prod",
            project_config,
            group)

    (
        start_task >>
        tasks['bronze'] >>
        tasks['silver'] >>
        tasks['gold']
    )


dbt_iceberg_dag = dbt_iceberg_dag()
