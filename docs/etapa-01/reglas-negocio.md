# Reglas de negocio

1. **Clientes:** toda venta debe asociarse a un cliente existente identificado por DNI.
2. **Productos:** todo producto pertenece a una única categoría y posee descripción, precio de lista y stock actual.
3. **Stock:** el stock no puede ser negativo y una venta no puede descontar más unidades que las disponibles.
4. **Histórico de ventas:** cada detalle de venta conserva el precio unitario aplicado en el momento de la operación.
5. **Compras:** cada compra se realiza a un único proveedor y puede incluir varios productos con su costo unitario histórico.
6. **Pagos:** una venta puede recibir uno o varios pagos; cada pago registra fecha, hora, método, monto y referencia.
7. **Estados de venta:** una venta puede estar `PENDIENTE`, `PAGADA`, `PREPARADA`, `ENTREGADA` o `CANCELADA`.
8. **Unicidad de ítems:** un mismo producto no puede repetirse como dos renglones distintos dentro de la misma venta o compra.
9. **Integridad de importes:** precios, cantidades y montos deben ser mayores que cero.
10. **Integridad referencial:** no se puede registrar una operación que haga referencia a clientes, proveedores, productos, categorías o métodos inexistentes.
