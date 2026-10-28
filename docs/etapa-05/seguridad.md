# Seguridad, usuarios, permisos y roles

## 1. Definición y objetivo

SQL Server permite controlar el acceso mediante logins, usuarios de base de datos, roles y permisos. El objetivo de esta práctica es demostrar el principio de mínimo privilegio: cada usuario recibe únicamente los permisos necesarios.

## 2. Verificación de modo mixto

El archivo `sql/tecnico/seguridad/verificar_modo_mixto.sql` consulta `SERVERPROPERTY('IsIntegratedSecurityOnly')` para determinar si la instancia acepta autenticación de Windows y autenticación de SQL Server.

Si la instancia está configurada solo para Windows, el script explica los pasos necesarios en SSMS para habilitar el modo mixto y volver a verificarlo.

## 3. Permisos a nivel de usuario

El archivo `usuarios_permisos.sql` crea los usuarios académicos utilizados en la práctica y configura:

- `oga_admin`: permisos amplios mediante `db_owner`;
- `oga_lector`: lectura mediante `db_datareader`;
- denegación de `INSERT`, `UPDATE` y `DELETE` directos sobre `Producto` para el lector;
- `GRANT EXECUTE` sobre `dbo.sp_InsertarProducto` para el lector.

El archivo `pruebas_permisos.sql` demuestra cuatro comportamientos:

1. el administrador puede insertar directamente;
2. el lector puede consultar productos;
3. el lector no puede insertar directamente;
4. el lector sí puede insertar mediante el procedimiento autorizado.

Este último caso evidencia una ventaja de los procedimientos almacenados como capa controlada de acceso a los datos.

## 4. Permisos a nivel de roles

El archivo `roles.sql` crea `rol_lectura_productos`, concede `SELECT` sobre `Producto`, agrega `usuario_con_rol` y deja `usuario_sin_rol` fuera del rol.

La demostración verifica que:

- el usuario miembro del rol puede leer la tabla;
- el usuario no asignado al rol recibe un error de permisos.

## 5. Conclusión

El uso combinado de usuarios, roles, `GRANT` y `DENY` permite separar responsabilidades y reducir accesos innecesarios. La práctica también muestra que un usuario sin permiso de escritura directa puede ejecutar una operación específica mediante un procedimiento expresamente autorizado.
