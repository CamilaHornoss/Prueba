USE ProyectoTiendaOGA;
GO
DECLARE @id_venta INT = 1;

SELECT v.id_venta AS numero_comprobante, v.fecha_venta, v.hora_venta, v.estado_venta,
       c.dni_cliente, CONCAT(c.nombre,' ',c.apellido) AS cliente,
       p.descripcion_producto, dv.cantidad_venta, dv.precio_unitario,
       dv.cantidad_venta * dv.precio_unitario AS subtotal_linea,
       SUM(dv.cantidad_venta * dv.precio_unitario) OVER (PARTITION BY v.id_venta) AS total_venta
FROM Venta v
JOIN Cliente c ON c.dni_cliente=v.dni_cliente
JOIN Detalle_venta dv ON dv.id_venta=v.id_venta
JOIN Producto p ON p.id_producto=dv.id_producto
WHERE v.id_venta=@id_venta;

SELECT mp.nombre_metodo, pa.monto, pa.fecha_pago, pa.hora_pago, pa.referencia
FROM Pago pa JOIN Metodo_pago mp ON mp.id_metodo=pa.id_metodo
WHERE pa.id_venta=@id_venta
ORDER BY pa.id_pago;
GO
