WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_t200_mm_terceros') }}
),

rename_and_casted AS (
	SELECT

	CAST(f200_id_cia AS NUMERIC(15,2)) AS id_cia,
	CAST(f200_rowid AS NUMERIC (15,2)) AS rowid_tercero,
	TRIM(f200_nit) AS nit,
	TRIM(f200_dv_nit) AS dv_nit,
	TRIM(f200_id_tipo_ident) AS id_tipo_ident,
	TRIM(f200_razon_social) AS razon_social,
	CAST(f200_ind_cliente AS NUMERIC(15,2)) AS ind_cliente,
	CAST(f200_ind_estado AS NUMERIC(15,2)) AS ind_estado

	FROM source
)

SELECT * FROM rename_and_casted