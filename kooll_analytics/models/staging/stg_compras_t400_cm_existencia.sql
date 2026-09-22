WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_compras_t400_cm_existencia') }}
),

rename_and_casted AS (
	SELECT
	TRIM(CAST(f400_rowid_item_ext AS TEXT)) AS id_existencia,
	CAST(f400_cant_existencia_1 AS NUMERIC(15,2)) AS cant_existencia,
	CAST(f400_cant_pendiente_entrar_1 AS NUMERIC(15,2)) AS cant_entrar_OC,
	CAST(f400_costo_prom_uni AS NUMERIC(15,2)) AS costo_prom_und

	FROM source
)

SELECT * FROM rename_and_casted