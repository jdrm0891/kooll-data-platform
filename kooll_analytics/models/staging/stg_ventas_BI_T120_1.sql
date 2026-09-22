WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_ventas_BI_T120_1') }}
),

rename_and_casted AS (
	SELECT
	TRIM(CAST(f121_rowid AS TEXT)) AS id_t120_1,
	TRIM(CAST(f120_referencia AS TEXT)) AS id_producto,
	TRIM(f120_descripcion) AS desc_producto,
	TRIM(desc_cri_mayor_item_1) AS linea_producto,
	TRIM(desc_cri_mayor_item_2) AS sublinea_producto,
	TRIM(desc_cri_mayor_item_3) AS marca_producto

	FROM source
)

SELECT * FROM rename_and_casted