WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_ventas_BI_T201_2') }}
),

rename_and_casted AS (
	SELECT
	TRIM(CAST("f200_Id" AS TEXT)) AS id_t201_2,
	TRIM(desc_cri_mayor_cli_1) AS desc_zona,
	TRIM(f200_razon_social) AS razon_social

	FROM source
)

SELECT * FROM rename_and_casted