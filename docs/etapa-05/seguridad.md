# Seguridad y permisos

La práctica distingue usuarios y roles.

- Usuario administrador: permisos amplios sobre la base.
- Usuario de solo lectura: `SELECT`, sin `INSERT` directo, pero con `EXECUTE` sobre `sp_InsertarProducto`.
- Rol `rol_lectura_productos`: otorga lectura sobre Producto a un usuario asignado.

La configuración de modo mixto debe verificarse en la instancia de SQL Server; el script documenta los pasos que sí pueden automatizarse en T-SQL.
