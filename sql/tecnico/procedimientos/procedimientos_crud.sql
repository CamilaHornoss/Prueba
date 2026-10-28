USE ProyectoTiendaOGA;
GO
CREATE OR ALTER PROCEDURE dbo.sp_InsertarProducto @descripcion VARCHAR(100),@stock INT,@precio DECIMAL(12,2),@id_categoria INT AS
BEGIN SET NOCOUNT ON; INSERT INTO Producto(descripcion_producto,stock_actual,precio_lista,id_categoria) VALUES(@descripcion,@stock,@precio,@id_categoria); END;
GO
CREATE OR ALTER PROCEDURE dbo.sp_ModificarProducto @id_producto INT,@descripcion VARCHAR(100),@stock INT,@precio DECIMAL(12,2),@id_categoria INT AS
BEGIN SET NOCOUNT ON; UPDATE Producto SET descripcion_producto=@descripcion,stock_actual=@stock,precio_lista=@precio,id_categoria=@id_categoria WHERE id_producto=@id_producto; END;
GO
CREATE OR ALTER PROCEDURE dbo.sp_EliminarProducto @id_producto INT AS
BEGIN SET NOCOUNT ON; DELETE FROM Producto WHERE id_producto=@id_producto; END;
GO
