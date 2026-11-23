# End-to-End Open Source Data Engineering Platform

Plataforma analítica portable, modular y desacoplada construida con tecnologías Open Source para integrar fuentes transaccionales (ERP SQL Server) y archivos planos hacia un Data Warehouse dimensional listo para Business Intelligence e Inteligencia Artificial.

##  Objetivo Arquitectónico
Migrar de un flujo monolítico acoplado en Power Query hacia una arquitectura moderna de Ingeniería de Datos donde la extracción, transformación y orquestación estén versionadas, containerizadas y desacopladas de la capa de visualización.

##  Arquitectura de la Plataforma

```mermaid
flowchart LR
    subgraph Fuentes
        ERP[(SQL Server ERP)]
        XLS[Archivos Excel / OneDrive]
    end

    subgraph Ingesta_EL [Ingesta EL]
        PY[Python + Polars]
    end

    subgraph Almacenamiento_y_Transformacion [Data Warehouse & Transformación]
        PG[(PostgreSQL DWH)]
        DBT[dbt Core: raw -> stg -> marts]
    end

    subgraph Orquestacion [Orquestación]
        AF[Apache Airflow]
    end

    subgraph Consumo [Analítica & Futuro IA]
        PBI[Power BI - Modelo Estrella]
        AI[MLflow / FastAPI / AI Agents]
    end

    ERP --> PY
    XLS --> PY
    PY -->|Truncate & Append| PG
    PG <--> DBT
    AF -.->|Orquesta| PY
    AF -.->|Orquesta| DBT
    DBT --> PBI
    DBT -.-> AI


##  Stack Tecnologico
Infraestructura: Docker & Docker Compose (portabilidad multi-entorno).

Ingesta (EL): Python 3.10 + Polars (procesamiento en memoria con Apache Arrow) + SQLAlchemy.

Data Warehouse: PostgreSQL 15.

Transformación (T): dbt Core (arquitectura por capas raw, staging y marts en Modelo Estrella).

Orquestación: Apache Airflow (LocalExecutor).

Visualización: Microsoft Power BI (conexión directa al modelo dimensional).
