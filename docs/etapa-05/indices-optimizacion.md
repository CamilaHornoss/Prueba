# Optimización de consultas mediante índices

## 1. Definición y objetivo

Los índices son estructuras auxiliares que permiten reducir el costo de acceso a los datos. Su conveniencia depende del patrón de consultas, la selectividad y el costo adicional que introducen sobre operaciones de escritura.

La práctica busca comparar el comportamiento de una consulta por rango de fechas antes y después de aplicar distintos índices.

## 2. Carga masiva

El archivo `sql/tecnico/indices/carga_masiva.sql` crea la tabla técnica `VentaRendimiento`, que contiene un campo `fecha`, y genera automáticamente **1.000.000 de registros** mediante una operación set-based.

Al finalizar, el script ejecuta `COUNT(*)` para comprobar la cantidad cargada.

## 3. Escenarios de prueba

El archivo `sql/tecnico/indices/pruebas_indices.sql` ejecuta exactamente la misma búsqueda por período en tres escenarios:

1. **Sin índice:** permite observar el plan base y el costo de recorrer la tabla.
2. **Índice `CLUSTERED` sobre `fecha, id`:** ordena físicamente las filas comenzando por la fecha y favorece búsquedas por rango.
3. **Segundo índice `CLUSTERED` sobre `fecha` y las columnas consultadas:** incorpora `id_producto`, `cantidad`, `monto` e `id` como columnas clave para respetar literalmente la consigna de la cátedra.

Entre el segundo y el tercer escenario se elimina el índice anterior para que las pruebas sean comparables.

## 4. Medición

El script habilita:

- `SET STATISTICS IO ON`: informa lecturas lógicas y físicas;
- `SET STATISTICS TIME ON`: informa CPU y tiempo transcurrido.

Además, en SSMS debe activarse **Include Actual Execution Plan** (`Ctrl+M`) antes de ejecutar cada escenario y conservar el plan como evidencia.

Los valores de tiempo y lecturas dependen del equipo, memoria, caché y carga de la instancia. Por ese motivo no se incluyen números inventados en el repositorio: deben registrarse a partir de la ejecución real.

## 5. Nota técnica

SQL Server no permite usar `INCLUDE` en un índice `CLUSTERED`. Un índice agrupado almacena la fila completa en el nivel hoja. Para cumplir literalmente con la consigna de un segundo índice agrupado que contemple también las columnas seleccionadas, dichas columnas se incorporaron como columnas clave.

## 6. Conclusión esperada

La prueba permite comprobar si el índice reduce lecturas y cambia el plan desde un recorrido completo hacia una estrategia de acceso más eficiente por rango de fecha. También permite observar que agregar columnas a una clave de índice aumenta su tamaño, por lo que la optimización debe evaluarse como un equilibrio entre velocidad de lectura, espacio y costo de mantenimiento.
