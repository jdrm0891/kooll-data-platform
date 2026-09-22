WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_compras_t41851_import_movto') }}
),

rename_and_casted AS (
	SELECT
	TRIM(CAST(f41851_rowid_item_ext AS TEXT)) AS id_movimientos,
	CAST(f41851_cant_importacion AS NUMERIC(15,2)) AS cant_importacion

	FROM source
)

SELECT * FROM rename_and_casted