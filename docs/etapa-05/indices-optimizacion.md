# Optimización mediante índices

El script `carga_masiva.sql` crea una tabla técnica con campo fecha y carga al menos 1.000.000 de registros mediante una operación set-based.

La evaluación se realiza con la misma consulta por período en tres escenarios:
1. Sin índice.
2. Con índice `CLUSTERED` sobre `fecha` (y `id` como desempate).
3. Con un segundo índice `CLUSTERED` cuya primera columna es `fecha` y que incorpora además las columnas seleccionadas como parte de la clave.

En cada caso se deben registrar el plan de ejecución real, `STATISTICS IO` y `STATISTICS TIME` para comparar lecturas lógicas, CPU y tiempo transcurrido.

## Nota técnica
SQL Server no permite usar `INCLUDE` en un índice `CLUSTERED`. Por eso, para respetar la consigna de un segundo índice agrupado que también contemple las columnas seleccionadas, dichas columnas se agregan como columnas clave del índice. Esta decisión se documenta expresamente para diferenciarla de un índice de cobertura `NONCLUSTERED`, que sí admitiría `INCLUDE`.
