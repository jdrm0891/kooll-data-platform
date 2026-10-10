WITH ventas AS (
    SELECT * FROM {{ ref('stg_ventas_BI_T461_1') }}
),

clientes AS(
    SELECT
        id_cliente as id_tipo_ident,
        razon_social, 
        desc_zona
    FROM {{ ref('fct_clientes') }}
),

productos AS(
    SELECT
        id_producto AS ref_producto,
        desc_producto
    FROM {{ ref('stg_productos_t120_mc_items') }}
)

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
    p.desc_producto,
    c.razon_social,
    c.desc_zona
FROM ventas v
LEFT JOIN clientes c ON v.id_cliente = c.id_tipo_ident
LEFT JOIN productos p ON v.id_producto = p.ref_producto