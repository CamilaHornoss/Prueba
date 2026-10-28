USE ProyectoTiendaOGA;
GO

/*
Comparación reproducible: sentencias directas vs procedimientos y funciones.
Los tiempos dependen del hardware, carga de la instancia y caché. Por eso el script
mide en la misma sesión y devuelve resultados para documentar la prueba real.

Prerequisito: ejecutar procedimientos_crud.sql y funciones/funciones.sql.
*/
SET NOCOUNT ON;

DECLARE @repeticiones INT = 200;
DECLARE @i INT;
DECLARE @inicio DATETIME2(7);
DECLARE @ms_directo DECIMAL(18,3);
DECLARE @ms_proc DECIMAL(18,3);
DECLARE @descripcion VARCHAR(100);

-- 1) INSERT directo. Se usa ROLLBACK para no alterar los datos definitivos.
SET @i = 1;
BEGIN TRANSACTION;
SET @inicio = SYSDATETIME();
WHILE @i <= @repeticiones
BEGIN
    INSERT INTO Producto(descripcion_producto, stock_actual, precio_lista, id_categoria)
    VALUES (CONCAT('BENCH_DIRECTO_', @i), 1, 1000 + @i, 1);
    SET @i += 1;
END;
SET @ms_directo = DATEDIFF_BIG(MICROSECOND, @inicio, SYSDATETIME()) / 1000.0;
ROLLBACK TRANSACTION;

-- 2) INSERT mediante procedimiento almacenado. También se revierte al terminar.
SET @i = 1;
BEGIN TRANSACTION;
SET @inicio = SYSDATETIME();
WHILE @i <= @repeticiones
BEGIN
    SET @descripcion = CONCAT('BENCH_PROC_', @i);
    EXEC dbo.sp_InsertarProducto
        @descripcion = @descripcion,
        @stock = 1,
        @precio = 1000,
        @id_categoria = 1;
    SET @i += 1;
END;
SET @ms_proc = DATEDIFF_BIG(MICROSECOND, @inicio, SYSDATETIME()) / 1000.0;
ROLLBACK TRANSACTION;

SELECT
    @repeticiones AS repeticiones,
    @ms_directo AS ms_insert_directo,
    @ms_proc AS ms_insert_procedimiento,
    CAST(@ms_proc - @ms_directo AS DECIMAL(18,3)) AS diferencia_ms;
GO

-- 3) Comparación: expresión SQL directa vs función escalar.
DECLARE @vueltas INT = 5000;
DECLARE @n INT = 1;
DECLARE @inicio2 DATETIME2(7) = SYSDATETIME();
DECLARE @resultado DECIMAL(18,2);
DECLARE @ms_consulta DECIMAL(18,3);
DECLARE @ms_funcion DECIMAL(18,3);

WHILE @n <= @vueltas
BEGIN
    SELECT @resultado = COALESCE(SUM(cantidad_venta * precio_unitario), 0)
    FROM Detalle_venta
    WHERE id_venta = 1;
    SET @n += 1;
END;
SET @ms_consulta = DATEDIFF_BIG(MICROSECOND, @inicio2, SYSDATETIME()) / 1000.0;

SET @n = 1;
SET @inicio2 = SYSDATETIME();
WHILE @n <= @vueltas
BEGIN
    SET @resultado = dbo.fn_TotalVenta(1);
    SET @n += 1;
END;
SET @ms_funcion = DATEDIFF_BIG(MICROSECOND, @inicio2, SYSDATETIME()) / 1000.0;

SELECT
    @vueltas AS repeticiones,
    @ms_consulta AS ms_consulta_directa,
    @ms_funcion AS ms_funcion,
    CAST(@ms_funcion - @ms_consulta AS DECIMAL(18,3)) AS diferencia_ms;
GO

-- Métricas del motor para una ejecución representativa.
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT COALESCE(SUM(cantidad_venta * precio_unitario), 0) AS total_directo
FROM Detalle_venta
WHERE id_venta = 1;

SELECT dbo.fn_TotalVenta(1) AS total_mediante_funcion;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
