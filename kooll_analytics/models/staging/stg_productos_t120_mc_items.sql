WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_productos_t120_mc_items') }}
),

rename_and_casted AS (
	SELECT

	CAST(f120_id_cia AS NUMERIC(15,2)) AS id_cia,
	TRIM(f120_referencia) AS id_producto,
	TRIM(f120_descripcion) AS desc_producto,
	TRIM(f120_descripcion_corta) AS desc_producto_corta,
	TRIM(f120_id_grupo_impositivo) AS id_grupo_impositivo,
	TRIM(f120_id_tipo_inv_serv) AS id_tipo_inv_serv,
	TRIM(f120_id_unidad_inventario) AS unidad_inventario

	FROM source
)

SELECT * FROM rename_and_casted