# Justificación de decisiones de diseño

## Precios históricos
`Producto.precio_lista` representa el precio vigente, mientras que `Detalle_venta.precio_unitario` y `Detalle_compra.precio_compra` registran el precio efectivamente aplicado en cada operación.

## Pagos múltiples
`Pago` utiliza `id_pago` como PK. Así una venta puede recibir varios pagos, incluso mediante el mismo método, sin perder trazabilidad.

## Estado de venta
Se usa `VARCHAR(15)` restringido por `CHECK`, porque se necesitan cinco estados de negocio y un `BIT` sería insuficiente.

## Domicilio
Calle, altura y localidad se almacenan por separado para facilitar filtros y mantener atomicidad sin introducir tablas adicionales que el alcance actual no necesita.
