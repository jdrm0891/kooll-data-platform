WITH source AS (
    SELECT * FROM {{ source('erp_siesa', 'raw_t210_mm_vendedores') }}
),

rename_and_casted AS (
    SELECT
        -- Llaves y relaciones
        CAST(id_cia AS INTEGER) AS id_cia,
        TRIM(CAST(id_vendedor AS VARCHAR)) AS id_vendedor, -- TRIM elimina los espacios extra que trae SIESA
        CAST(rowid_tercero AS INTEGER) AS rowid_tercero,

        -- Indicadores (0 o 1)
        CAST(ind_vendedor AS INTEGER) AS ind_vendedor,
        CAST(ind_cobrador AS INTEGER) AS ind_cobrador,

        -- Información descriptiva (Las nuevas columnas de tu JOIN)
        TRIM(CAST(nit AS VARCHAR)) AS nit,
        TRIM(CAST(nombre_vendedor AS VARCHAR)) AS nombre_vendedor

    FROM source
)

SELECT * FROM rename_and_casted