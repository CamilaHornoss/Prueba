USE ProyectoTiendaOGA;
GO

/*
Validación final de Etapa V.
Ejecutar después de haber creado los objetos técnicos correspondientes.
El objetivo es reunir en una única salida evidencias verificables de la implementación.
*/

PRINT '=== PROCEDIMIENTOS CRUD ===';
SELECT name, type_desc
FROM sys.objects
WHERE name IN ('sp_InsertarProducto','sp_ModificarProducto','sp_EliminarProducto')
ORDER BY name;

PRINT '=== FUNCIONES ===';
SELECT name, type_desc
FROM sys.objects
WHERE name IN ('fn_TotalVenta','fn_TotalCompradoCliente','fn_CantidadVendidaProducto')
ORDER BY name;

PRINT '=== TRIGGERS ===';
SELECT tr.name AS trigger_name, OBJECT_NAME(tr.parent_id) AS tabla, tr.is_disabled
FROM sys.triggers tr
WHERE tr.name IN ('tr_AuditoriaProducto','tr_ImpedirEliminarProveedor');

PRINT '=== TABLA DE AUDITORIA ===';
SELECT OBJECT_ID('dbo.Auditoria_Producto') AS auditoria_producto_object_id;
IF OBJECT_ID('dbo.Auditoria_Producto') IS NOT NULL
    SELECT COUNT(*) AS registros_auditoria FROM dbo.Auditoria_Producto;

PRINT '=== USUARIOS Y ROLES ===';
SELECT name, type_desc
FROM sys.database_principals
WHERE name IN ('oga_admin','oga_lector','usuario_con_rol','usuario_sin_rol','rol_lectura_productos')
ORDER BY name;

PRINT '=== PERMISOS EXPLICITOS SOBRE PRODUCTO / PROCEDIMIENTO ===';
SELECT pr.name AS principal,
       pe.permission_name,
       pe.state_desc,
       COALESCE(OBJECT_NAME(pe.major_id), '(base de datos)') AS objeto
FROM sys.database_permissions pe
JOIN sys.database_principals pr ON pr.principal_id = pe.grantee_principal_id
WHERE pr.name IN ('oga_admin','oga_lector','rol_lectura_productos')
ORDER BY pr.name, objeto, pe.permission_name;

PRINT '=== TABLA DE RENDIMIENTO E INDICES ===';
IF OBJECT_ID('dbo.VentaRendimiento') IS NOT NULL
BEGIN
    SELECT COUNT_BIG(*) AS registros_venta_rendimiento FROM dbo.VentaRendimiento;

    SELECT i.name, i.type_desc, i.is_unique,
           STRING_AGG(c.name, ', ') WITHIN GROUP (ORDER BY ic.key_ordinal) AS columnas_clave
    FROM sys.indexes i
    JOIN sys.index_columns ic
      ON ic.object_id = i.object_id
     AND ic.index_id = i.index_id
     AND ic.key_ordinal > 0
    JOIN sys.columns c
      ON c.object_id = ic.object_id
     AND c.column_id = ic.column_id
    WHERE i.object_id = OBJECT_ID('dbo.VentaRendimiento')
    GROUP BY i.name, i.type_desc, i.is_unique
    ORDER BY i.name;
END
ELSE
    PRINT 'VentaRendimiento todavía no fue creada. Ejecutar sql/tecnico/indices/carga_masiva.sql';

PRINT '=== FUNCIONES: DEMOSTRACION ===';
IF OBJECT_ID('dbo.fn_TotalVenta') IS NOT NULL
    SELECT dbo.fn_TotalVenta(1) AS total_venta_1;

IF OBJECT_ID('dbo.fn_TotalCompradoCliente') IS NOT NULL
    SELECT dbo.fn_TotalCompradoCliente('38456123') AS total_cliente_38456123;

IF OBJECT_ID('dbo.fn_CantidadVendidaProducto') IS NOT NULL
    SELECT dbo.fn_CantidadVendidaProducto(1) AS unidades_vendidas_producto_1;
GO
