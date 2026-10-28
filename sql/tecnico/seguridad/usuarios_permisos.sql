/* Requiere permisos administrativos de instancia. Verificar previamente que SQL Server esté en modo mixto. */
USE master;
GO
IF NOT EXISTS(SELECT 1 FROM sys.server_principals WHERE name='oga_admin') CREATE LOGIN oga_admin WITH PASSWORD='Oga_Admin#2026!';
IF NOT EXISTS(SELECT 1 FROM sys.server_principals WHERE name='oga_lector') CREATE LOGIN oga_lector WITH PASSWORD='Oga_Lector#2026!';
GO
USE ProyectoTiendaOGA;
GO
IF USER_ID('oga_admin') IS NULL CREATE USER oga_admin FOR LOGIN oga_admin;
IF USER_ID('oga_lector') IS NULL CREATE USER oga_lector FOR LOGIN oga_lector;
ALTER ROLE db_owner ADD MEMBER oga_admin;
ALTER ROLE db_datareader ADD MEMBER oga_lector;
DENY INSERT, UPDATE, DELETE ON dbo.Producto TO oga_lector;
GRANT EXECUTE ON dbo.sp_InsertarProducto TO oga_lector;
GO
-- Pruebas sugeridas con EXECUTE AS USER:
EXECUTE AS USER='oga_lector';
SELECT TOP 3 * FROM Producto;
BEGIN TRY INSERT INTO Producto(descripcion_producto,stock_actual,precio_lista,id_categoria) VALUES('No permitido directo',1,1000,1); END TRY BEGIN CATCH SELECT ERROR_MESSAGE() AS insert_directo_denegado; END CATCH;
EXEC dbo.sp_InsertarProducto 'Permitido por procedimiento',1,1500,1;
REVERT;
GO
