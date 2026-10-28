# Decisiones de diseño

- Se utiliza `dni_cliente` como PK natural de Cliente.
- Proveedor utiliza `id_proveedor` como PK sustituta y `cuit_proveedor` como clave alternativa `UNIQUE`.
- Los productos se identifican con `id_producto IDENTITY`.
- Las relaciones N:M Venta–Producto y Compra–Producto se resuelven mediante `Detalle_venta` y `Detalle_compra`.
- El precio aplicado se guarda en las tablas de detalle para preservar el histórico.
- `Pago` posee una PK propia (`id_pago`) para permitir más de un pago con el mismo método sobre una misma venta.
- Los estados se implementan con `VARCHAR` + `CHECK` para mantener el modelo principal dentro del rango de complejidad esperado.
