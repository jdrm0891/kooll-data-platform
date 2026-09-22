WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_clasif_ABC') }}
),

rename_and_casted AS (
	SELECT
	
	TRIM(Referencia) AS id_producto,
	(Desc. item) AS desc_producto,
	TRIM(ABC) AS abc_producto,
	TRIM(XYZ) AS xyz_producto

	FROM source
)

SELECT * FROM rename_and_casted