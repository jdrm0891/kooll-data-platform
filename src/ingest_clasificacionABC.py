import os
import logging
import polars as pl
from dotenv import load_dotenv
from sqlalchemy import create_engine

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def get_target_engine():
    """Crea la conexión hacia nuestro Data Warehouse (PostgreSQL)"""
    user = os.getenv("DWH_USER")
    password = os.getenv("DWH_PASSWORD")
    host = os.getenv("DWH_HOST")
    port = os.getenv("DWH_PORT")
    db = os.getenv("DWH_DB")
    return create_engine(f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{db}")

def main():
    load_dotenv()
    
    try:
        logging.info("Iniciando extracción desde OneDrive...")
        target_engine = get_target_engine()

        ruta_excel = "C:/Users/Kooll/OneDrive - 900199289_KOOLL IMPORTACIONES SAS/Fuentes BI/Clasificacion ABC.xlsx"
        
        logging.info(f"Leyendo archivo Excel: {ruta_excel}")        
        df_excel = pl.read_excel(ruta_excel)
        
        filas = df_excel.height
        logging.info(f"Se extrajeron {filas} registros del Excel exitosamente.")

        if filas > 0:
            logging.info("Cargando datos en PostgreSQL (Capa Staging)...")
            df_excel.write_database(
                table_name="raw_clasif_ABC",
                connection=target_engine, 
                if_table_exists="replace"
            )
            logging.info("¡Carga del Excel completada con éxito en el Data Warehouse!")
        else:
            logging.warning("El archivo Excel está vacío.")

    except Exception as e:
        logging.error(f"Error crítico en el flujo de datos: {e}")

if __name__ == "__main__":
    main()