USE ProyectoTiendaOGA;
GO

SET STATISTICS IO ON;
SET STATISTICS TIME ON;

-- 1) PRUEBA SIN INDICE
SELECT fecha, id_producto, cantidad, monto
FROM VentaRendimiento
WHERE fecha BETWEEN '2026-01-01' AND '2026-01-31';
GO

-- 2) INDICE AGRUPADO SOBRE FECHA
CREATE CLUSTERED INDEX IX_VentaRendimiento_Fecha
ON VentaRendimiento(fecha, id);
GO

SELECT fecha, id_producto, cantidad, monto
FROM VentaRendimiento
WHERE fecha BETWEEN '2026-01-01' AND '2026-01-31';
GO

DROP INDEX IX_VentaRendimiento_Fecha ON VentaRendimiento;
GO

-- 3) SEGUNDA PRUEBA CON INDICE AGRUPADO SOBRE FECHA Y LAS COLUMNAS CONSULTADAS
-- SQL Server no permite INCLUDE en un indice CLUSTERED. Para respetar literalmente
-- la consigna, las columnas seleccionadas se incorporan como columnas clave.
CREATE CLUSTERED INDEX IX_VentaRendimiento_Fecha_Columnas
ON VentaRendimiento(fecha, id_producto, cantidad, monto, id);
GO

SELECT fecha, id_producto, cantidad, monto
FROM VentaRendimiento
WHERE fecha BETWEEN '2026-01-01' AND '2026-01-31';
GO

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
