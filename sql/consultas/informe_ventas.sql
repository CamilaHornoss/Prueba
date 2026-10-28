USE ProyectoTiendaOGA;
GO
DECLARE @desde DATE='2026-09-01', @hasta DATE='2026-09-30';
SELECT c.id_categoria,c.nombre_categoria,
       COUNT(DISTINCT v.id_venta) AS cantidad_ventas,
       SUM(dv.cantidad_venta) AS unidades_vendidas,
       SUM(dv.cantidad_venta*dv.precio_unitario) AS total_recaudado
FROM Venta v
JOIN Detalle_venta dv ON dv.id_venta=v.id_venta
JOIN Producto p ON p.id_producto=dv.id_producto
JOIN Categorias c ON c.id_categoria=p.id_categoria
WHERE v.estado_venta<>'CANCELADA' AND v.fecha_venta BETWEEN @desde AND @hasta
GROUP BY c.id_categoria,c.nombre_categoria
ORDER BY total_recaudado DESC;
GO
