USE ProyectoTiendaOGA;
GO
-- PRUEBA EXITOSA
DECLARE @id_venta INT, @producto INT=2, @cantidad INT=1, @precio DECIMAL(12,2)=38500;
BEGIN TRY
 BEGIN TRANSACTION;
 IF (SELECT stock_actual FROM Producto WITH (UPDLOCK,HOLDLOCK) WHERE id_producto=@producto) < @cantidad THROW 50001,'Stock insuficiente',1;
 INSERT INTO Venta(fecha_venta,hora_venta,estado_venta,dni_cliente) VALUES(CAST(GETDATE() AS DATE),CAST(GETDATE() AS TIME(0)),'PAGADA','38456123');
 SET @id_venta=SCOPE_IDENTITY();
 INSERT INTO Detalle_venta VALUES(@producto,@id_venta,@precio,@cantidad);
 UPDATE Producto SET stock_actual=stock_actual-@cantidad WHERE id_producto=@producto;
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
 IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;
 THROW;
END CATCH;
GO

-- PRUEBA CON ERROR INTENCIONAL: la FK debe provocar ROLLBACK
BEGIN TRY
 BEGIN TRANSACTION;
 INSERT INTO Venta(fecha_venta,hora_venta,estado_venta,dni_cliente) VALUES(CAST(GETDATE() AS DATE),CAST(GETDATE() AS TIME(0)),'PAGADA','40123987');
 DECLARE @venta_error INT=SCOPE_IDENTITY();
 INSERT INTO Detalle_venta VALUES(999999,@venta_error,1000,1);
 UPDATE Producto SET stock_actual=stock_actual-1 WHERE id_producto=1;
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
 IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;
 SELECT ERROR_MESSAGE() AS error_controlado;
END CATCH;
GO
