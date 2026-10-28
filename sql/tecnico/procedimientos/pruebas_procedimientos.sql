USE ProyectoTiendaOGA;
GO
-- Lote directo
INSERT INTO Producto(descripcion_producto,stock_actual,precio_lista,id_categoria) VALUES
('Producto directo A',5,10000,7),('Producto directo B',6,12000,7),('Producto directo C',7,14000,7);
-- Lote por procedimiento
EXEC dbo.sp_InsertarProducto 'Producto proc A',5,11000,7;
EXEC dbo.sp_InsertarProducto 'Producto proc B',6,13000,7;
EXEC dbo.sp_InsertarProducto 'Producto proc C',7,15000,7;
DECLARE @id INT=(SELECT id_producto FROM Producto WHERE descripcion_producto='Producto proc A');
EXEC dbo.sp_ModificarProducto @id,'Producto proc A actualizado',9,12500,7;
DECLARE @id_borrar INT=(SELECT id_producto FROM Producto WHERE descripcion_producto='Producto proc C');
EXEC dbo.sp_EliminarProducto @id_borrar;
SELECT * FROM Producto WHERE descripcion_producto LIKE 'Producto%';
GO
