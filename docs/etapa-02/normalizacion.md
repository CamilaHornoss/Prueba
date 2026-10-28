# Normalización hasta 3FN

## 1FN
Todos los atributos almacenan valores atómicos. Las listas de productos no se guardan dentro de Venta o Compra: se separan en `Detalle_venta` y `Detalle_compra`. Los pagos tampoco se modelan mediante columnas repetidas, sino mediante la tabla `Pago`.

## 2FN
Las tablas con PK simple cumplen 2FN al no poder presentar dependencias parciales. En las tablas con clave compuesta:
- `(id_producto, id_venta) -> precio_unitario, cantidad_venta`
- `(id_producto, id_compra) -> precio_compra, cantidad_compra`
Los atributos dependen de la clave completa.

## 3FN
Los atributos no clave dependen únicamente de la clave de su relación. Los datos de categoría no se duplican en Producto; los del cliente no se duplican en Venta; los del proveedor no se duplican en Compra; y los datos del método de pago no se duplican en Pago. Esto elimina dependencias transitivas y reduce anomalías de inserción, actualización y borrado.
