WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_presupuesto_ventas') }}
),

rename_and_casted AS (
	SELECT
	
	TRIM(VENDEDOR) AS nombre_vendedor,
	TRIM(REFERENCIA) AS id_producto,
	TRIM(DESCRIPCION) AS descripcion_producto,
	TRIM(LINEA) AS linea_producto,
	TRIM(SUBLINEA) AS sublinea_producto,
	CAST(FECHA AS DATE) AS fecha,
	CAST(CANTIDAD AS NUMERIC(15,2)) AS cantidad,
	CAST(PRECIO_VENTA AS NUMERIC(15,2)) AS precio_venta

	FROM source
)

SELECT * FROM rename_and_casted