# Evidencias de ejecución en SSMS — Etapa V

Esta hoja se completa durante la ejecución final en SQL Server Management Studio. Su objetivo es conservar evidencia real de las pruebas sin inventar resultados que dependen del equipo o de la instancia.

## 1. Procedimientos y funciones

Ejecutar `sql/tecnico/procedimientos/comparacion_eficiencia.sql` y registrar:

| Prueba | Resultado |
|---|---|
| Tiempo lote INSERT directo | Pendiente de ejecución |
| Tiempo lote por procedimiento | Pendiente de ejecución |
| Tiempo consulta directa | Pendiente de ejecución |
| Tiempo mediante función | Pendiente de ejecución |

Adjuntar o copiar también los mensajes de `STATISTICS IO/TIME`.

### Conclusión a redactar

Indicar si hubo diferencia medible y aclarar que el principal beneficio de procedimientos y funciones también se relaciona con reutilización, mantenibilidad, control de permisos y centralización de lógica.

---

## 2. Transacciones

### Prueba exitosa

- Venta registrada: Pendiente de ejecución.
- Detalle registrado: Pendiente de ejecución.
- Stock actualizado: Pendiente de ejecución.

### Prueba con error intencional

- Mensaje de error obtenido: Pendiente de ejecución.
- Venta parcial persistida: debe ser **NO**.
- Detalle parcial persistido: debe ser **NO**.
- Stock modificado: debe ser **NO**.

### Transacción anidada

Registrar los valores de `@@TRANCOUNT` observados:

| Momento | Valor esperado | Valor obtenido |
|---|---:|---:|
| Después de BEGIN externa | 1 | Pendiente |
| Después de BEGIN interna | 2 | Pendiente |
| Después de COMMIT interna | 1 | Pendiente |
| Después de ROLLBACK externa | 0 | Pendiente |

---

## 3. Triggers

Registrar evidencia de:

- fila de auditoría generada por `UPDATE`;
- fila de auditoría generada por `DELETE`;
- usuario registrado por el trigger;
- fecha/hora registrada;
- mensaje obtenido al intentar eliminar un proveedor;
- comprobación de que el proveedor continúa existiendo.

---

## 4. Seguridad

### Modo de autenticación

Resultado de `verificar_modo_mixto.sql`:

- `IsIntegratedSecurityOnly`: Pendiente.
- Diagnóstico: Pendiente.

### Usuarios

| Operación | Resultado esperado | Resultado obtenido |
|---|---|---|
| Admin: INSERT directo | Permitido | Pendiente |
| Lector: SELECT | Permitido | Pendiente |
| Lector: INSERT directo | Denegado | Pendiente |
| Lector: EXEC sp_InsertarProducto | Permitido | Pendiente |

### Roles

| Usuario | SELECT sobre Producto |
|---|---|
| `usuario_con_rol` | Permitido / Pendiente de ejecución |
| `usuario_sin_rol` | Denegado / Pendiente de ejecución |

---

## 5. Índices

Antes de ejecutar `pruebas_indices.sql`, activar **Include Actual Execution Plan** (`Ctrl+M`).

### Escenario A — Sin índice

- Tipo de acceso observado: Pendiente.
- Lecturas lógicas: Pendiente.
- CPU: Pendiente.
- Tiempo transcurrido: Pendiente.
- Captura/plan guardado: Pendiente.

### Escenario B — Índice CLUSTERED sobre fecha

- Tipo de acceso observado: Pendiente.
- Lecturas lógicas: Pendiente.
- CPU: Pendiente.
- Tiempo transcurrido: Pendiente.
- Captura/plan guardado: Pendiente.

### Escenario C — Índice de cobertura NONCLUSTERED sobre fecha + INCLUDE

- Tipo de acceso observado: Pendiente.
- Lecturas lógicas: Pendiente.
- CPU: Pendiente.
- Tiempo transcurrido: Pendiente.
- Captura/plan guardado: Pendiente.

### Conclusión

Comparar los tres escenarios usando datos reales de la instancia y explicar si disminuyeron las lecturas y tiempos, qué cambios se observaron en el plan y qué costo adicional implica mantener índices.
