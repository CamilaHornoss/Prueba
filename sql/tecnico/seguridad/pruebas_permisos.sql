USE ProyectoTiendaOGA;
GO

/*
Prerequisito: ejecutar usuarios_permisos.sql.
Este archivo separa las pruebas para que puedan repetirse y documentarse sin recrear usuarios.
*/

-- Limpieza de posibles ejecuciones previas.
DELETE FROM Producto
WHERE descripcion_producto IN ('SEG_ADMIN_TEST', 'SEG_PROC_TEST');
GO

-- PRUEBA A: usuario administrador -> INSERT directo permitido.
EXECUTE AS USER = 'oga_admin';
INSERT INTO Producto(descripcion_producto, stock_actual, precio_lista, id_categoria)
VALUES ('SEG_ADMIN_TEST', 1, 2000, 1);
SELECT 'ADMIN_INSERT_OK' AS prueba, descripcion_producto, stock_actual, precio_lista
FROM Producto
WHERE descripcion_producto = 'SEG_ADMIN_TEST';
REVERT;
GO

-- PRUEBA B: usuario lector -> SELECT permitido.
EXECUTE AS USER = 'oga_lector';
SELECT TOP 3 'LECTOR_SELECT_OK' AS prueba, *
FROM Producto
ORDER BY id_producto;
REVERT;
GO

-- PRUEBA C: usuario lector -> INSERT directo denegado.
EXECUTE AS USER = 'oga_lector';
BEGIN TRY
    INSERT INTO Producto(descripcion_producto, stock_actual, precio_lista, id_categoria)
    VALUES ('NO_DEBE_INSERTARSE', 1, 1000, 1);
END TRY
BEGIN CATCH
    SELECT 'LECTOR_INSERT_DENEGADO' AS prueba, ERROR_MESSAGE() AS resultado;
END CATCH;
REVERT;
GO

-- PRUEBA D: usuario lector -> ejecución del procedimiento permitida.
EXECUTE AS USER = 'oga_lector';
EXEC dbo.sp_InsertarProducto
    @descripcion = 'SEG_PROC_TEST',
    @stock = 1,
    @precio = 1500,
    @id_categoria = 1;
REVERT;
GO

SELECT 'LECTOR_PROC_OK' AS prueba, descripcion_producto, stock_actual, precio_lista
FROM Producto
WHERE descripcion_producto = 'SEG_PROC_TEST';
GO

-- Limpieza final de datos generados por esta práctica.
DELETE FROM Producto
WHERE descripcion_producto IN ('SEG_ADMIN_TEST', 'SEG_PROC_TEST');
GO
