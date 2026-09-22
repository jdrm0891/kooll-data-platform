WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_leadtime') }}
),

rename_and_casted AS (
	SELECT
	
	TRIM(REFERENCIA) AS id_producto,
	TRIM(DESCRIPCION) AS desc_producto,
	CAST(DIAS APROVISIONAMIENTO AS NUMERIC(15,2)) AS dias_aprovisionamiento

	FROM source
)

SELECT * FROM rename_and_casted