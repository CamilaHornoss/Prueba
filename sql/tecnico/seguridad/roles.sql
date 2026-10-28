USE ProyectoTiendaOGA;
GO
IF DATABASE_PRINCIPAL_ID('rol_lectura_productos') IS NULL CREATE ROLE rol_lectura_productos;
GRANT SELECT ON dbo.Producto TO rol_lectura_productos;
IF USER_ID('usuario_con_rol') IS NULL CREATE USER usuario_con_rol WITHOUT LOGIN;
IF USER_ID('usuario_sin_rol') IS NULL CREATE USER usuario_sin_rol WITHOUT LOGIN;
ALTER ROLE rol_lectura_productos ADD MEMBER usuario_con_rol;
EXECUTE AS USER='usuario_con_rol'; SELECT TOP 3 * FROM Producto; REVERT;
EXECUTE AS USER='usuario_sin_rol'; BEGIN TRY SELECT TOP 3 * FROM Producto; END TRY BEGIN CATCH SELECT ERROR_MESSAGE() AS lectura_denegada; END CATCH; REVERT;
GO
