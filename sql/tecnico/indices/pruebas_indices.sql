USE ProyectoTiendaOGA;
GO

SET STATISTICS IO ON;
SET STATISTICS TIME ON;

-- 1) PRUEBA SIN INDICE
SELECT fecha, id_producto, cantidad, monto
FROM VentaRendimiento
WHERE fecha BETWEEN '2026-01-01' AND '2026-01-31';
GO

-- 2) INDICE AGRUPADO SOBRE LA COLUMNA FECHA
CREATE CLUSTERED INDEX IX_VentaRendimiento_Fecha
ON VentaRendimiento(fecha);
GO

SELECT fecha, id_producto, cantidad, monto
FROM VentaRendimiento
WHERE fecha BETWEEN '2026-01-01' AND '2026-01-31';
GO

-- Se elimina el indice agrupado antes del tercer escenario.
DROP INDEX IX_VentaRendimiento_Fecha ON VentaRendimiento;
GO

-- 3) INDICE DE COBERTURA (NONCLUSTERED + INCLUDE)
-- Este escenario sigue la guia oficial de Etapa V 2026.
CREATE NONCLUSTERED INDEX IX_VentaRendimiento_Fecha_Cobertura
ON VentaRendimiento(fecha)
INCLUDE (id_producto, cantidad, monto);
GO

SELECT fecha, id_producto, cantidad, monto
FROM VentaRendimiento
WHERE fecha BETWEEN '2026-01-01' AND '2026-01-31';
GO

-- En SSMS registrar para los tres escenarios:
-- * plan de ejecucion real
-- * tiempo de CPU
-- * tiempo total
-- * lecturas logicas
-- * operacion principal (Table Scan / Index Seek / etc.)

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
