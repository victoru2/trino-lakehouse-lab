"""Example DAG
"""

from airflow import DAG
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator

from datetime import datetime


def exemplo_extracao():
    print("Extraindo dados do Hubspot para S3")


def exemplo_carga():
    print("Carregando dados do S3 para Snowflake")


def exemplo_transformacao():
    print("Transformando dados do Hubspot")


with DAG(
    dag_id="example_dag",
    start_date=datetime(2024, 7, 28),
    schedule=None
) as dag:

    extract_task = EmptyOperator(task_id="extract_task")

    extract_execute = PythonOperator(
        task_id="extract_execute",
        python_callable=exemplo_extracao)

    transform_task = EmptyOperator(task_id="transform_task")

    transform_execute = PythonOperator(
        task_id="transform_execute",
        python_callable=exemplo_carga)

    load_task = EmptyOperator(task_id="load_task")

    load_execute = PythonOperator(
        task_id="load_execute",
        python_callable=exemplo_transformacao)

    (extract_task >>
     extract_execute >>
     transform_task >>
     transform_execute >>
     load_task >>
     load_execute)
