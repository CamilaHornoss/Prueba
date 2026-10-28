# Manejo de transacciones y transacciones anidadas

## 1. Definición y objetivo

Una transacción agrupa varias operaciones SQL como una única unidad lógica de trabajo. Su objetivo es preservar las propiedades ACID, especialmente atomicidad y consistencia: si una parte falla, ninguna modificación parcial debe quedar persistida.

En Tienda OGA una venta involucra al menos tres acciones relacionadas: crear la cabecera, crear el detalle y descontar stock.

## 2. Transacción simple con control de errores

El archivo `sql/tecnico/transacciones/transaccion_venta.sql` implementa:

1. `INSERT` sobre `Venta`;
2. `INSERT` sobre `Detalle_venta`;
3. `UPDATE` de `Producto.stock_actual`;
4. control de stock mediante bloqueo `UPDLOCK, HOLDLOCK`;
5. `TRY/CATCH`, `COMMIT` y `ROLLBACK`.

Se incluyen dos casos:

- **Caso exitoso:** las tres operaciones se completan y se confirma la transacción.
- **Caso con error intencional:** se intenta insertar un detalle con un producto inexistente, la FK genera un error y se ejecuta `ROLLBACK`.

El resultado esperado del segundo caso es que no quede ni la venta parcial ni el detalle y que el stock no se modifique.

## 3. Transacciones anidadas

El archivo `sql/tecnico/transacciones/transacciones_anidadas.sql` demuestra el comportamiento de `@@TRANCOUNT` al utilizar una transacción externa y otra interna.

La prueba evidencia que en SQL Server un `COMMIT` de la transacción interna solamente disminuye `@@TRANCOUNT`: los cambios no quedan definitivamente confirmados hasta que se confirma la transacción externa. Por ese motivo, un `ROLLBACK` externo revierte también los cambios realizados dentro de la transacción interna.

## 4. Conclusión

El uso de transacciones evita estados inconsistentes, por ejemplo una venta registrada sin detalle o un detalle registrado sin descontar stock. El manejo con `TRY/CATCH` permite controlar fallos y garantizar que el sistema vuelva a un estado válido. Las transacciones anidadas muestran que la unidad de confirmación definitiva sigue dependiendo de la transacción externa.
