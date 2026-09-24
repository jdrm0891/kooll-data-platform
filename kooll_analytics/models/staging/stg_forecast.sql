WITH source AS (
	SELECT * FROM {{ source('erp_siesa', 'raw_forecast') }}
),

rename_and_casted AS (
	SELECT
	
	TRIM("Referencia_producto") AS id_producto,
	TRIM("Descripcion_item") AS descripcion_producto,
	CAST("Total_Forecast" AS NUMERIC(15,2)) AS total_forecast,
	CAST("Fecha_Inicio" AS DATE) AS fecha_inicio,
	CAST("Fecha_Fin" AS DATE) AS fecha_fin,
	CAST("Forecast_Ajustado" AS NUMERIC(15,2)) AS forecast_ajustado

	FROM source
)

SELECT * FROM rename_and_casted
