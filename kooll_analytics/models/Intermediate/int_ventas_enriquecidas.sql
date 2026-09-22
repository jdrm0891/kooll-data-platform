-- 1. Traemos la tabla de ventas (El corazón)
WITH ventas AS (
    SELECT * FROM {{ ref('stg_ventas_BI_T461_1') }}
),

-- 4. Aquí unimos las 3 tablas
SELECT 
    -- Columnas de la tabla de Ventas
    v.fecha,
    v.id_cliente,
    v.id_producto,
    v.und_vendidas,
    v.ciudad_despacho,
    v.cond_pago,
    v.costo_venta,
    v.valor_venta,
    v.id_vendedor,
    
FROM ventas v