WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_t201_mm_clientes') }}
),

rename_and_casted AS (
	SELECT

	CAST(f201_id_cia AS NUMERIC(15,2)) AS id_cia,
	CAST(f201_rowid_tercero AS NUMERIC(15,2)) AS rowid_tercero,
	CAST(f201_id_sucursal AS NUMERIC(15,2)) AS id_sucursal,
	CAST(f201_id_vendedor AS NUMERIC(15,2)) AS id_vendedor,
	TRIM(f201_id_cond_pago) AS id_cond_pago,
	CAST(f201_cupo_credito AS NUMERIC(15,2)) AS cupo_credito,
	CAST(f201_id_lista_precio AS NUMERIC(15,2)) AS id_lista_precio,
	CAST(f201_ind_estado_activo AS NUMERIC(15,2)) AS ind_estado_activo

	FROM source
)

SELECT * FROM rename_and_casted