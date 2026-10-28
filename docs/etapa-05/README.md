# Etapa V — Temas Técnicos

Esta etapa implementa los mecanismos solicitados para robustez, consistencia, seguridad, trazabilidad y optimización de la base de datos de Tienda OGA.

## Checklist contra la consigna 2026

| Tema | Requisito | Implementación |
|---|---|---|
| Procedimientos | 3 procedimientos: insertar, modificar y borrar | ✅ `sp_InsertarProducto`, `sp_ModificarProducto`, `sp_EliminarProducto` |
| Procedimientos | Lote directo + lote por procedimientos | ✅ `pruebas_procedimientos.sql` |
| Procedimientos | UPDATE y DELETE invocando procedimientos | ✅ `pruebas_procedimientos.sql` |
| Funciones | Al menos 3 funciones | ✅ 3 funciones escalares de negocio |
| Eficiencia | Comparar directo vs procedimientos/funciones | ✅ `comparacion_eficiencia.sql` |
| Transacciones | INSERT + INSERT + UPDATE atómicos | ✅ `transaccion_venta.sql` |
| Transacciones | Error intencional y ROLLBACK | ✅ `transaccion_venta.sql` |
| Transacciones | Transacciones anidadas | ✅ `transacciones_anidadas.sql` |
| Triggers | Auditoría de UPDATE y DELETE | ✅ `tr_AuditoriaProducto` |
| Triggers | Fecha, hora, usuario y valores anterior/nuevo | ✅ `Auditoria_Producto` |
| Triggers | Bloquear un DELETE | ✅ `tr_ImpedirEliminarProveedor` |
| Seguridad | Verificar modo mixto | ✅ `verificar_modo_mixto.sql` |
| Seguridad | Admin vs lector + EXECUTE de procedimiento | ✅ `usuarios_permisos.sql` + `pruebas_permisos.sql` |
| Seguridad | Roles y comparación de acceso | ✅ `roles.sql` |
| Índices | Carga de 1.000.000 registros con fecha | ✅ `carga_masiva.sql` |
| Índices | Consulta sin índice + plan/tiempos | ✅ `pruebas_indices.sql` |
| Índices | Índice CLUSTERED sobre fecha | ✅ `pruebas_indices.sql` |
| Índices | Índice de cobertura NONCLUSTERED sobre fecha + INCLUDE | ✅ `pruebas_indices.sql` |
| Índices | Eliminar índices | ✅ `eliminar_indices.sql` |

## Orden recomendado de ejecución en SSMS

1. `sql/ddl/crear_bd.sql`
2. `sql/dml/datos_prueba.sql`
3. `sql/tecnico/procedimientos/procedimientos_crud.sql`
4. `sql/tecnico/funciones/funciones.sql`
5. `sql/tecnico/procedimientos/pruebas_procedimientos.sql`
6. `sql/tecnico/procedimientos/comparacion_eficiencia.sql`
7. `sql/tecnico/transacciones/transaccion_venta.sql`
8. `sql/tecnico/transacciones/transacciones_anidadas.sql`
9. `sql/tecnico/triggers/triggers_auditoria.sql`
10. `sql/tecnico/triggers/pruebas_triggers.sql`
11. `sql/tecnico/seguridad/verificar_modo_mixto.sql`
12. `sql/tecnico/seguridad/usuarios_permisos.sql`
13. `sql/tecnico/seguridad/pruebas_permisos.sql`
14. `sql/tecnico/seguridad/roles.sql`
15. `sql/tecnico/indices/carga_masiva.sql`
16. Activar **Actual Execution Plan** (`Ctrl+M`).
17. `sql/tecnico/indices/pruebas_indices.sql`
18. `sql/tecnico/validacion_final_etapa05.sql`
19. Opcional al terminar: `sql/tecnico/indices/eliminar_indices.sql`.

## Evidencias que dependen de la instancia

El repositorio contiene el código para producir todas las pruebas. Sin embargo, los siguientes resultados deben obtenerse ejecutando realmente en SQL Server/SSMS porque dependen de la instancia:

- salida de `SERVERPROPERTY('IsIntegratedSecurityOnly')`;
- comportamiento real de permisos para cada usuario;
- salida de `STATISTICS IO` y `STATISTICS TIME`;
- planes de ejecución reales antes y después de crear los índices;
- tiempos medidos por `comparacion_eficiencia.sql`.

No se incorporan valores ficticios. La plantilla `evidencias-ssms.md` indica qué registrar durante la ejecución final.

## Archivos de documentación

- `procedimientos-funciones.md`
- `transacciones.md`
- `triggers-auditoria.md`
- `seguridad.md`
- `indices-optimizacion.md`
- `evidencias-ssms.md`
