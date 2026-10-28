# Optimización mediante índices

El script crea una tabla técnica de prueba con campo fecha y carga al menos 1.000.000 de filas de forma set-based. Se ejecuta una búsqueda por período con `STATISTICS IO/TIME` y plan de ejecución.

Luego se crea un índice agrupado sobre fecha, se repite la prueba y se elimina. Finalmente se crea un índice no agrupado de cobertura sobre fecha con columnas `INCLUDE`. Se documenta esta elección porque SQL Server no admite columnas `INCLUDE` en un índice `CLUSTERED`; un índice agrupado ya contiene la fila completa en el nivel hoja.
