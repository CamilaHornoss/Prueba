USE ProyectoTiendaOGA;
GO
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
-- 1) Sin índice
SELECT fecha,id_producto,cantidad,monto FROM VentaRendimiento WHERE fecha BETWEEN '2026-01-01' AND '2026-01-31';
GO
-- 2) Índice agrupado sobre fecha
CREATE CLUSTERED INDEX IX_VentaRendimiento_Fecha ON VentaRendimiento(fecha,id);
GO
SELECT fecha,id_producto,cantidad,monto FROM VentaRendimiento WHERE fecha BETWEEN '2026-01-01' AND '2026-01-31';
GO
DROP INDEX IX_VentaRendimiento_Fecha ON VentaRendimiento;
GO
-- 3) Índice de cobertura. INCLUDE solo está permitido en NONCLUSTERED en SQL Server.
CREATE NONCLUSTERED INDEX IX_VentaRendimiento_Fecha_Cover ON VentaRendimiento(fecha) INCLUDE(id_producto,cantidad,monto);
GO
SELECT fecha,id_producto,cantidad,monto FROM VentaRendimiento WHERE fecha BETWEEN '2026-01-01' AND '2026-01-31';
GO
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
