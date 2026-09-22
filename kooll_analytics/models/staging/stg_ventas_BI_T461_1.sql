WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_ventas_BI_T461_1') }}
),

rename_and_casted AS (
	SELECT
	TRIM(f_cliente_fact) AS id_cliente,
	TRIM(f_ref_item) AS id_producto,
	CAST(f_fecha AS DATE) AS fecha,
	CAST(f_cant_inv AS NUMERIC(15,2)) AS und_vendidas,
	TRIM(f_ciudad_desp) AS ciudad_despacho,
	TRIM(f_cond_pago_cli) AS cond_pago,
	TRIM(f_vendedor) AS id_vendedor,
	CAST(f_costo_prom_tot AS NUMERIC(15,2)) AS costo_venta,
	CAST(f_valor_subtotal_local AS NUMERIC(15,2)) AS valor_venta

	FROM source
)

SELECT * FROM rename_and_casted