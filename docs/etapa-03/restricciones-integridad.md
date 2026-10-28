# Restricciones de integridad

## Entidad
Cada tabla posee PK. Las tablas de detalle utilizan PK compuestas para impedir productos repetidos dentro de una misma operación.

## Dominio
- Precios, cantidades y montos: `CHECK (> 0)`.
- Stock: `CHECK (stock_actual >= 0)`.
- Altura: `CHECK (altura > 0)`.
- Estados: `CHECK` con valores válidos.

## Claves alternativas
- Cliente.telefono
- Proveedor.cuit_proveedor
- Categorias.nombre_categoria
- Producto.descripcion_producto
- Metodo_pago.nombre_metodo
- Pago.referencia

## Referencial
Todas las FK usan `ON UPDATE NO ACTION` y `ON DELETE NO ACTION`.
