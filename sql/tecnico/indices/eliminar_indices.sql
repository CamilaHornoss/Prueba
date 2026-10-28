USE ProyectoTiendaOGA;
GO
IF EXISTS(
    SELECT 1 FROM sys.indexes
    WHERE name='IX_VentaRendimiento_Fecha'
      AND object_id=OBJECT_ID('VentaRendimiento')
)
    DROP INDEX IX_VentaRendimiento_Fecha ON VentaRendimiento;

IF EXISTS(
    SELECT 1 FROM sys.indexes
    WHERE name='IX_VentaRendimiento_Fecha_Columnas'
      AND object_id=OBJECT_ID('VentaRendimiento')
)
    DROP INDEX IX_VentaRendimiento_Fecha_Columnas ON VentaRendimiento;
GO
