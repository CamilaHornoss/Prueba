USE ProyectoTiendaOGA;
GO

/*
Práctica académica de permisos a nivel de usuarios de base de datos.
El modo mixto de autenticación se verifica por separado con verificar_modo_mixto.sql.
Para no publicar credenciales en un repositorio público, estos usuarios se crean WITHOUT LOGIN.
Las pruebas de permisos se realizan con EXECUTE AS USER.
*/

IF USER_ID('oga_admin') IS NULL
    CREATE USER oga_admin WITHOUT LOGIN;

IF USER_ID('oga_lector') IS NULL
    CREATE USER oga_lector WITHOUT LOGIN;
GO

-- Administrador: miembro de db_owner.
IF ISNULL(IS_ROLEMEMBER('db_owner', 'oga_admin'), 0) = 0
    ALTER ROLE db_owner ADD MEMBER oga_admin;

-- Lector: lectura general de la base.
IF ISNULL(IS_ROLEMEMBER('db_datareader', 'oga_lector'), 0) = 0
    ALTER ROLE db_datareader ADD MEMBER oga_lector;

-- Se niega escritura directa sobre Producto.
DENY INSERT, UPDATE, DELETE ON dbo.Producto TO oga_lector;

-- Pero se habilita la ejecución controlada del procedimiento de inserción.
GRANT EXECUTE ON dbo.sp_InsertarProducto TO oga_lector;
GO

-- Resumen de usuarios y pertenencia a roles.
SELECT dp.name AS usuario,
       rp.name AS rol
FROM sys.database_principals dp
LEFT JOIN sys.database_role_members drm
    ON drm.member_principal_id = dp.principal_id
LEFT JOIN sys.database_principals rp
    ON rp.principal_id = drm.role_principal_id
WHERE dp.name IN ('oga_admin', 'oga_lector')
ORDER BY dp.name, rp.name;
GO

-- Permisos explícitos relevantes.
SELECT pr.name AS usuario,
       pe.state_desc,
       pe.permission_name,
       OBJECT_NAME(pe.major_id) AS objeto
FROM sys.database_permissions pe
JOIN sys.database_principals pr
  ON pr.principal_id = pe.grantee_principal_id
WHERE pr.name IN ('oga_admin', 'oga_lector')
ORDER BY pr.name, pe.permission_name;
GO
