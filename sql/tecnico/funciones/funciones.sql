USE ProyectoTiendaOGA;
GO
CREATE OR ALTER FUNCTION dbo.fn_TotalVenta(@id_venta INT) RETURNS DECIMAL(18,2) AS
BEGIN DECLARE @r DECIMAL(18,2); SELECT @r=COALESCE(SUM(cantidad_venta*precio_unitario),0) FROM Detalle_venta WHERE id_venta=@id_venta; RETURN @r; END;
GO
CREATE OR ALTER FUNCTION dbo.fn_TotalCompradoCliente(@dni CHAR(8)) RETURNS DECIMAL(18,2) AS
BEGIN DECLARE @r DECIMAL(18,2); SELECT @r=COALESCE(SUM(dv.cantidad_venta*dv.precio_unitario),0) FROM Venta v JOIN Detalle_venta dv ON dv.id_venta=v.id_venta WHERE v.dni_cliente=@dni AND v.estado_venta<>'CANCELADA'; RETURN @r; END;
GO
CREATE OR ALTER FUNCTION dbo.fn_CantidadVendidaProducto(@id_producto INT) RETURNS INT AS
BEGIN DECLARE @r INT; SELECT @r=COALESCE(SUM(cantidad_venta),0) FROM Detalle_venta WHERE id_producto=@id_producto; RETURN @r; END;
GO
SELECT dbo.fn_TotalVenta(1) total_venta_1, dbo.fn_TotalCompradoCliente('38456123') total_cliente, dbo.fn_CantidadVendidaProducto(1) unidades_producto_1;
GO
