USE ProyectoTiendaOGA;
GO
DROP TABLE IF EXISTS Auditoria_Producto;
CREATE TABLE Auditoria_Producto(
 id_auditoria BIGINT IDENTITY PRIMARY KEY,
 id_producto INT NOT NULL,
 operacion VARCHAR(10) NOT NULL,
 descripcion_anterior VARCHAR(100) NULL, descripcion_nueva VARCHAR(100) NULL,
 precio_anterior DECIMAL(12,2) NULL, precio_nuevo DECIMAL(12,2) NULL,
 stock_anterior INT NULL, stock_nuevo INT NULL,
 fecha_hora DATETIME2 NOT NULL DEFAULT SYSDATETIME(), usuario_bd SYSNAME NOT NULL DEFAULT SUSER_SNAME()
);
GO
CREATE OR ALTER TRIGGER dbo.tr_AuditoriaProducto ON dbo.Producto AFTER UPDATE, DELETE AS
BEGIN
 SET NOCOUNT ON;
 INSERT INTO Auditoria_Producto(id_producto,operacion,descripcion_anterior,descripcion_nueva,precio_anterior,precio_nuevo,stock_anterior,stock_nuevo)
 SELECT d.id_producto, CASE WHEN i.id_producto IS NULL THEN 'DELETE' ELSE 'UPDATE' END,
        d.descripcion_producto,i.descripcion_producto,d.precio_lista,i.precio_lista,d.stock_actual,i.stock_actual
 FROM deleted d LEFT JOIN inserted i ON i.id_producto=d.id_producto;
END;
GO
CREATE OR ALTER TRIGGER dbo.tr_ImpedirEliminarProveedor ON dbo.Proveedor INSTEAD OF DELETE AS
BEGIN
 RAISERROR('No se permite eliminar proveedores. Deben conservarse por trazabilidad.',16,1);
END;
GO
