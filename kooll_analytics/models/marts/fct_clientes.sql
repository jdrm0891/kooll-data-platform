-- models/marts/fct_clientes.sql
{{ config(materialized='table') }}

SELECT DISTINCT ON (nit)
    nit AS id_cliente,
    razon_social,
    desc_zona

FROM {{ ref('stg_t200_mm_terceros') }}
ORDER BY nit, razon_social