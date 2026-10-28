USE ProyectoTiendaOGA;
GO

/* PRUEBA 1: auditoría de UPDATE */
UPDATE Producto
SET precio_lista = precio_lista + 1000
WHERE id_producto = 1;

SELECT TOP 10 *
FROM Auditoria_Producto
ORDER BY id_auditoria DESC;
GO

/* PRUEBA 2: auditoría de DELETE sobre un producto temporal sin relaciones */
DECLARE @id_producto_prueba INT;

INSERT INTO Producto(descripcion_producto, stock_actual, precio_lista, id_categoria)
VALUES ('Producto temporal auditoria', 1, 9999, 1);

SET @id_producto_prueba = SCOPE_IDENTITY();

UPDATE Producto
SET precio_lista = 10999,
    stock_actual = 2
WHERE id_producto = @id_producto_prueba;

DELETE FROM Producto
WHERE id_producto = @id_producto_prueba;

SELECT id_auditoria, id_producto, operacion,
       descripcion_anterior, descripcion_nueva,
       precio_anterior, precio_nuevo,
       stock_anterior, stock_nuevo,
       fecha_hora, usuario_bd
FROM Auditoria_Producto
WHERE id_producto = @id_producto_prueba
ORDER BY id_auditoria;
GO

/* PRUEBA 3: trigger que impide DELETE de proveedores */
BEGIN TRY
    DELETE FROM Proveedor WHERE id_proveedor = 1;
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS mensaje_bloqueo_delete;
END CATCH;

-- Debe seguir existiendo.
SELECT * FROM Proveedor WHERE id_proveedor = 1;
GO
