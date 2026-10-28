USE ProyectoTiendaOGA;
GO

/*
Demostración de transacciones anidadas en SQL Server.
SQL Server incrementa @@TRANCOUNT con cada BEGIN TRANSACTION, pero un COMMIT interno
no confirma definitivamente los cambios: la confirmación real ocurre recién con el
COMMIT de la transacción externa. En esta prueba se usa ROLLBACK externo para demostrarlo
sin dejar datos residuales.
*/

DECLARE @id_venta INT;
DECLARE @stock_inicial INT = (SELECT stock_actual FROM Producto WHERE id_producto = 1);

BEGIN TRY
    BEGIN TRANSACTION TransaccionExterna;

    INSERT INTO Venta(fecha_venta, hora_venta, estado_venta, dni_cliente)
    VALUES (CAST(GETDATE() AS DATE), CAST(GETDATE() AS TIME(0)), 'PENDIENTE', '38456123');

    SET @id_venta = SCOPE_IDENTITY();

    SELECT 'Después de BEGIN externa' AS etapa, @@TRANCOUNT AS tran_count;

    BEGIN TRANSACTION TransaccionInterna;

    INSERT INTO Detalle_venta(id_producto, id_venta, precio_unitario, cantidad_venta)
    VALUES (1, @id_venta, 45000, 1);

    UPDATE Producto
    SET stock_actual = stock_actual - 1
    WHERE id_producto = 1;

    SELECT 'Después de BEGIN interna' AS etapa, @@TRANCOUNT AS tran_count;

    COMMIT TRANSACTION TransaccionInterna;

    SELECT 'Después de COMMIT interna' AS etapa, @@TRANCOUNT AS tran_count;

    -- La venta sigue dentro de la transacción externa y todavía puede revertirse.
    ROLLBACK TRANSACTION TransaccionExterna;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    THROW;
END CATCH;

SELECT
    @@TRANCOUNT AS tran_count_final,
    (SELECT COUNT(*) FROM Venta WHERE id_venta = @id_venta) AS venta_persistida,
    (SELECT COUNT(*) FROM Detalle_venta WHERE id_venta = @id_venta) AS detalle_persistido,
    @stock_inicial AS stock_inicial,
    (SELECT stock_actual FROM Producto WHERE id_producto = 1) AS stock_final;
GO

/*
Resultado esperado:
- tran_count_final = 0
- venta_persistida = 0
- detalle_persistido = 0
- stock_final = stock_inicial
Esto demuestra que el COMMIT interno no independiza la transacción anidada de la externa.
*/
