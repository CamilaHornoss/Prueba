# Modelo relacional

- **Cliente**(`dni_cliente` PK, nombre, apellido, telefono UQ, calle, altura, localidad)
- **Metodo_pago**(`id_metodo` PK, nombre_metodo UQ)
- **Proveedor**(`id_proveedor` PK, cuit_proveedor UQ, nombre_proveedor, telefono_proveedor)
- **Categorias**(`id_categoria` PK, nombre_categoria UQ)
- **Producto**(`id_producto` PK, descripcion_producto UQ, stock_actual, precio_lista, `id_categoria` FK)
- **Venta**(`id_venta` PK, fecha_venta, hora_venta, estado_venta, `dni_cliente` FK)
- **Compra**(`id_compra` PK, fecha_compra, hora_compra, estado_compra, `id_proveedor` FK)
- **Detalle_compra**(`id_producto` PK/FK, `id_compra` PK/FK, precio_compra, cantidad_compra)
- **Detalle_venta**(`id_producto` PK/FK, `id_venta` PK/FK, precio_unitario, cantidad_venta)
- **Pago**(`id_pago` PK, `id_venta` FK, `id_metodo` FK, fecha_pago, hora_pago, monto, referencia)

## Cardinalidades principales
- Categorias 1:N Producto
- Cliente 1:N Venta
- Proveedor 1:N Compra
- Venta N:M Producto, resuelta por Detalle_venta
- Compra N:M Producto, resuelta por Detalle_compra
- Venta 1:N Pago
- Metodo_pago 1:N Pago
