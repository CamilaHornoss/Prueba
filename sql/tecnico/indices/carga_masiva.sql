USE ProyectoTiendaOGA;
GO
DROP TABLE IF EXISTS VentaRendimiento;
CREATE TABLE VentaRendimiento(
 id BIGINT IDENTITY(1,1) NOT NULL,
 fecha DATE NOT NULL,
 id_producto INT NOT NULL,
 cantidad INT NOT NULL,
 monto DECIMAL(12,2) NOT NULL
);
GO
;WITH n AS (
 SELECT TOP (1000000) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
 FROM sys.all_objects a CROSS JOIN sys.all_objects b
)
INSERT INTO VentaRendimiento(fecha,id_producto,cantidad,monto)
SELECT DATEADD(DAY,(rn-1)%730,'2025-01-01'), ((rn-1)%8)+1, ((rn-1)%5)+1, 1000+((rn-1)%50000)
FROM n;
GO
SELECT COUNT(*) AS registros_cargados FROM VentaRendimiento;
