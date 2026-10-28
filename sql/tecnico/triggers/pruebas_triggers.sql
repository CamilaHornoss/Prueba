USE ProyectoTiendaOGA;
GO
UPDATE Producto SET precio_lista=precio_lista+1000 WHERE id_producto=1;
SELECT TOP 10 * FROM Auditoria_Producto ORDER BY id_auditoria DESC;
BEGIN TRY DELETE FROM Proveedor WHERE id_proveedor=1; END TRY BEGIN CATCH SELECT ERROR_MESSAGE() AS mensaje; END CATCH;
SELECT * FROM Proveedor WHERE id_proveedor=1;
GO
