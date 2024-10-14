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

# Configuración predeterminada para la DAG
default_args = {
    "owner": "victor",
    "retries": 2,
    "retry_delay": timedelta(minutes=5)
}

# Definir la ruta del proyecto DBT
default_dbt_root_path = Path(__file__).parent / "dbt/trino"
dbt_root_path = Path(os.getenv("DBT_ROOT_PATH", default_dbt_root_path))

# Configuración del perfil de Iceberg
profile_config = ProfileConfig(
    profile_name="iceberg",
    target_name="prod",
    profiles_yml_filepath=(dbt_root_path / "profiles.yml")
)

# Configuración del proyecto DBT
project_config = ProjectConfig(
    dbt_project_path=(dbt_root_path)#.as_posix()
)

# Configuración de render para la capa bronze
render_config_bronze = RenderConfig(
    select=['path:models/bronze']
)

# # Configuración de render para la capa silver
# render_config_silver = RenderConfig(
#     select=['path:models/silver']
# )

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

    # Tarea inicial
    start_task = EmptyOperator(task_id="start")

    # Grupo de tareas para el modelo bronze en el esquema bronze
    bronze_task_group = DbtTaskGroup(
        group_id="bronze_models",
        project_config=project_config,
        profile_config=profile_config,
        render_config=render_config_bronze,
        operator_args={
            "install_deps": True,
            "full_refresh": True,
            "schema": "bronze"  # Esquema específico para la capa bronze
        }
    )

    # # Grupo de tareas para el modelo silver en el esquema silver
    # silver_task_group = DbtTaskGroup(
    #     group_id="silver_models",
    #     project_config=project_config,
    #     profile_config=profile_config,
    #     render_config=render_config_silver,
    #     operator_args={
    #         "install_deps": True,
    #         "full_refresh": True
    #     },
    #     config={
    #         "schema": "silver"  # Esquema específico para la capa silver
    #     }
    # )

    # Definir las dependencias de la DAG
    start_task >> bronze_task_group# >> silver_task_group

dbt_iceberg_dag = dbt_iceberg_dag()
