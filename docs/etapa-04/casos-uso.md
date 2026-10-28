# Casos de uso — Etapa IV

## CU-01 Comprobante de venta
Obtiene encabezado y detalle de una venta, subtotales por renglón y total acumulado.

Archivo: `sql/consultas/comprobante_venta.sql`.

## CU-02 Informe agregado por categoría
Resume cantidad de ventas, unidades vendidas y total recaudado por categoría dentro de un rango de fechas.

Archivo: `sql/consultas/informe_ventas.sql`.

## CU-03 Clientes destacados
Combina Cliente, Venta y Detalle_venta y selecciona clientes cuyo gasto acumulado supera el promedio por cliente mediante `HAVING` y subconsulta.

Archivo: `sql/consultas/consulta_avanzada.sql`.
