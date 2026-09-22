import os
import logging
import urllib.parse
import pandas as pd
import polars as pl
from dotenv import load_dotenv
from sqlalchemy import create_engine, text

# 1. Configuración de logging
logging.basicConfig(
    level=logging.INFO, 
    format='%(asctime)s - %(levelname)s - %(message)s'
)

def get_source_engine():
    """Crea la conexión hacia el ERP Siesa (SQL Server)"""    
    driver = "{ODBC Driver 18 for SQL Server}" 
    server = os.getenv("SIESA_SERVER")
    database = os.getenv("SIESA_DB")
    username = os.getenv("SIESA_USER")
    password = os.getenv("SIESA_PASSWORD")

    params = urllib.parse.quote_plus(
        f"DRIVER={driver};SERVER={server};DATABASE={database};"
        f"UID={username};PWD={password};TrustServerCertificate=yes"
    )    
    return create_engine(f"mssql+pyodbc:///?odbc_connect={params}")

def get_target_engine():
    """Crea la conexión hacia el Data Warehouse (PostgreSQL)"""
    user = os.getenv("DWH_USER")
    password = os.getenv("DWH_PASSWORD")
    host = os.getenv("DWH_HOST")
    port = os.getenv("DWH_PORT")
    db = os.getenv("DWH_DB")
    
    return create_engine(f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{db}")

def main():
    load_dotenv()
    
    try:
        logging.info("Iniciando proceso de extracción...")
        source_engine = get_source_engine()
        target_engine = get_target_engine()

        # 2. Extracción
        query = "SELECT * FROM BI_T120_1"
        
        logging.info("Consultando datos de Siesa en AWS RDS...")
        df_ventas = pl.read_database(query=query, connection=source_engine)
        
        filas = df_ventas.height
        logging.info(f"Se extrajeron {filas} registros exitosamente.")

        # 3. Carga en Staging (PostgreSQL)
        if filas > 0:
            logging.info("Vaciando tabla anterior en PostgreSQL...")
            try:
                with target_engine.begin() as conn:
                    conn.execute(text('TRUNCATE TABLE public."raw_ventas_BI_T120_1";'))
            except Exception as e:               
                logging.warning(f"No se pudo truncar la tabla (puede que no exista aún): {e}")

            logging.info("Cargando nuevos datos en PostgreSQL (Capa Staging)...")
            df_ventas.write_database(
                table_name="raw_ventas_BI_T120_1", 
                connection=target_engine, 
                if_table_exists="append"
            )
            logging.info("¡Carga completada con éxito en el Data Warehouse!")
        else:
            logging.warning("La consulta no devolvió datos.")

    except Exception as e:
        logging.error(f"Error crítico en el flujo de datos: {e}")

if __name__ == "__main__":
    main()