USE ProyectoTiendaOGA;
GO
WITH gasto_cliente AS (
    SELECT v.dni_cliente,
           COUNT(DISTINCT v.id_venta) AS operaciones,
           SUM(dv.cantidad_venta*dv.precio_unitario) AS total_gastado
    FROM Venta v JOIN Detalle_venta dv ON dv.id_venta=v.id_venta
    WHERE v.estado_venta<>'CANCELADA'
    GROUP BY v.dni_cliente
)
SELECT c.dni_cliente, CONCAT(c.nombre,' ',c.apellido) AS cliente, c.localidad,
       g.operaciones, g.total_gastado
FROM gasto_cliente g JOIN Cliente c ON c.dni_cliente=g.dni_cliente
WHERE g.total_gastado > (SELECT AVG(CAST(total_gastado AS DECIMAL(18,2))) FROM gasto_cliente)
ORDER BY g.total_gastado DESC;
GO
