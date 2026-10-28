# Optimización de consultas mediante índices

## 1. Definición y objetivo

Los índices son estructuras que SQL Server utiliza para localizar información de forma más eficiente. Su objetivo es reducir el trabajo necesario para resolver consultas frecuentes, especialmente sobre tablas con gran volumen de datos.

La práctica compara una misma consulta por rango de fechas en tres escenarios para observar cambios en tiempos, lecturas lógicas y plan de ejecución.

## 2. Ventajas y aplicaciones

- Reducen tiempos de respuesta en búsquedas selectivas.
- Disminuyen lecturas lógicas cuando el optimizador puede realizar búsquedas por índice.
- Mejoran consultas frecuentes por fechas, códigos, clientes o productos.
- Como contrapartida, consumen espacio y agregan costo de mantenimiento a `INSERT`, `UPDATE` y `DELETE`.

## 3. Caso aplicado a Tienda OGA

El archivo `sql/tecnico/indices/carga_masiva.sql` crea la tabla técnica `VentaRendimiento`, con una columna `fecha`, y genera automáticamente **1.000.000 de registros** para simular un historial de operaciones suficientemente grande.

El script finaliza con `COUNT(*)` para verificar la cantidad de filas cargadas.

## 4. Escenarios de prueba

El archivo `sql/tecnico/indices/pruebas_indices.sql` ejecuta la misma búsqueda por período en tres situaciones:

1. **Sin índice.** Se registra el comportamiento base de SQL Server.
2. **Índice agrupado (`CLUSTERED`) sobre `fecha`.** Se repite exactamente la consulta y se registra el nuevo plan y las métricas.
3. **Índice de cobertura (`NONCLUSTERED`) sobre `fecha` con columnas `INCLUDE`.** Luego de eliminar el índice agrupado, se crea un índice no agrupado que incluye `id_producto`, `cantidad` y `monto`, siguiendo la guía oficial de Etapa V 2026.

## 5. Medición y evidencia

El script habilita:

```sql
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
```

En SSMS también debe activarse **Include Actual Execution Plan** (`Ctrl+M`). Para cada escenario se deben registrar:

- tiempo de CPU;
- tiempo total de ejecución;
- lecturas lógicas;
- operación principal del plan (`Table Scan`, `Index Seek`, etc.);
- captura del plan de ejecución.

Los valores dependen del hardware, memoria, caché e instancia utilizada, por lo que deben obtenerse mediante ejecución real y no se incorporan valores inventados al repositorio.

## 6. Scripts

- `sql/tecnico/indices/carga_masiva.sql`
- `sql/tecnico/indices/pruebas_indices.sql`
- `sql/tecnico/indices/eliminar_indices.sql`

## 7. Conclusión

La comparación permite verificar empíricamente el efecto de la indexación. Se espera que la consulta sin índice requiera mayor trabajo; que el índice sobre fecha facilite una búsqueda por rango; y que el índice de cobertura pueda resolver la consulta con menos accesos adicionales a la tabla al contener las columnas necesarias para responderla.
