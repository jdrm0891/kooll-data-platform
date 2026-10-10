WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_t200_mm_terceros') }}
),

rename_and_casted AS (
	SELECT

	CAST(id_cia AS NUMERIC(15,2)) AS id_cia,
	CAST(rowid_tercero AS NUMERIC (15,2)) AS rowid_tercero,
	TRIM(nit) AS nit,
	TRIM(dv_nit) AS dv_nit,
	TRIM(id_tipo_ident) AS id_tipo_ident,
	TRIM(razon_social) AS razon_social,
	CAST(ind_cliente AS NUMERIC(15,2)) AS ind_cliente,
	CAST(ind_estado AS NUMERIC(15,2)) AS ind_estado,
	TRIM(desc_zona) AS desc_zona

	FROM source
)

SELECT * FROM rename_and_casted