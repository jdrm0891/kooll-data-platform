WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_t210_mm_vendedores') }}
),

rename_and_casted AS (
	SELECT

	CAST(f210_id_cia AS NUMERIC(15,2)) AS id_cia,
	CAST(f210_id AS NUMERIC(15,2)) AS id_vendedor,
	CAST(f210_rowid_tercero AS NUMERIC(15,2)) AS rowid_tercero,
	CAST(f210_ind_vendedor AS NUMERIC(15,2)) AS ind_vendedor,
	CAST(f210_ind_cobrador AS NUMERIC(15,2)) AS ind_cobrador

	FROM source
)

SELECT * FROM rename_and_casted