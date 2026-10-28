USE ProyectoTiendaOGA;
GO

IF DATABASE_PRINCIPAL_ID('rol_lectura_productos') IS NULL
    CREATE ROLE rol_lectura_productos;

GRANT SELECT ON dbo.Producto TO rol_lectura_productos;

IF USER_ID('usuario_con_rol') IS NULL
    CREATE USER usuario_con_rol WITHOUT LOGIN;

IF USER_ID('usuario_sin_rol') IS NULL
    CREATE USER usuario_sin_rol WITHOUT LOGIN;

IF NOT EXISTS (
    SELECT 1
    FROM sys.database_role_members drm
    JOIN sys.database_principals r ON r.principal_id = drm.role_principal_id
    JOIN sys.database_principals m ON m.principal_id = drm.member_principal_id
    WHERE r.name = 'rol_lectura_productos'
      AND m.name = 'usuario_con_rol'
)
    ALTER ROLE rol_lectura_productos ADD MEMBER usuario_con_rol;
GO

-- Usuario con rol: lectura permitida.
EXECUTE AS USER = 'usuario_con_rol';
SELECT TOP 3 'USUARIO_CON_ROL_OK' AS prueba, *
FROM Producto
ORDER BY id_producto;
REVERT;
GO

-- Usuario sin rol: lectura denegada.
EXECUTE AS USER = 'usuario_sin_rol';
BEGIN TRY
    SELECT TOP 3 * FROM Producto;
END TRY
BEGIN CATCH
    SELECT 'USUARIO_SIN_ROL_DENEGADO' AS prueba, ERROR_MESSAGE() AS resultado;
END CATCH;
REVERT;
GO
