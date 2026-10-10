WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_forecast') }}
),

rename_and_casted AS (
	SELECT
	
	TRIM("Referencia") AS id_producto,
	TRIM("Desc. item") AS descripcion_producto,
	CAST("Total Forecast" AS NUMERIC(15,2)) AS total_forecast,
	CAST("Fecha Inicio" AS DATE) AS fecha_inicio,
	CAST("Fecha Fin" AS DATE) AS fecha_fin,
	CAST("Forecast Ajustado" AS NUMERIC(15,2)) AS forecast_ajustado

	FROM source
)

SELECT * FROM rename_and_casted
