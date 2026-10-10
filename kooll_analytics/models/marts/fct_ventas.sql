-- models/marts/fct_ventas.sql
{{ config(materialized='table') }}

WITH ventas_enriquecidas AS (
    SELECT * FROM {{ ref('int_ventas_enriquecidas') }}
),

ventas_final AS (
    SELECT
        fecha,
        id_cliente,
        id_producto,
        und_vendidas,
        ciudad_despacho,
        cond_pago,
        costo_venta,
        valor_venta,
        desc_zona,
        razon_social,
        desc_producto
        /*desc_producto,
        linea_producto,
        sublinea_producto, 
        marca_producto,
        CASE 
            WHEN fecha >= '2026-02-01' 
             AND id_vendedor = '1100958065'
             AND desc_zona = 'ANTIOQUIA'
            THEN '11009580652'
            ELSE id_vendedor 
        END AS id_vendedor*/
    FROM ventas_enriquecidas
    /*WHERE TRIM(desc_producto) NOT IN ('FLETE', 'REINTEGRO COSTOS Y GASTOS', 'INTERESES DE MORA')*/
)
SELECT * FROM ventas_final