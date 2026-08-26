import os
import logging
import urllib.parse
import pandas as pd
import polars as pl
from dotenv import load_dotenv
from sqlalchemy import create_engine

# 1. Configuración de buenas prácticas: Logging en lugar de "print"
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

    # Codificamos la contraseña por si tiene caracteres especiales (@, #, etc.)
    params = urllib.parse.quote_plus(f"DRIVER={driver};SERVER={server};DATABASE={database};UID={username};PWD={password};TrustServerCertificate=yes")    
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
    # Cargar las credenciales del archivo .env oculto
    load_dotenv()
    
    try:
        logging.info("Iniciando proceso de extracción...")
        source_engine = get_source_engine()
        target_engine = get_target_engine()

        # 2. Extracción de la tabla
        query = "SELECT * FROM BI_T201_2"
        
        logging.info("Consultando datos de Siesa en AWS RDS...")
        # Polars ejecuta la consulta y la carga en memoria a una velocidad increíble
        df_ventas = pl.read_database(query=query, connection=source_engine)
        
        filas = df_ventas.height
        logging.info(f"Se extrajeron {filas} registros exitosamente.")

        # 3. Carga en Staging (PostgreSQL)
        if filas > 0:
            logging.info("Cargando datos en PostgreSQL (Capa Staging)...")
            # if_table_exists="replace" borrará la tabla y la volverá a crear en esta fase de pruebas
            df_ventas.write_database(
                table_name="stg_ventas_BI_T201_2", 
                connection=target_engine,
                if_table_exists="replace"
            )
            logging.info("¡Carga completada con éxito en el Data Warehouse!")
        else:
            logging.warning("La consulta no devolvió datos.")

    except Exception as e:
        logging.error(f"Error crítico en el flujo de datos: {e}")

if __name__ == "__main__":
    main()