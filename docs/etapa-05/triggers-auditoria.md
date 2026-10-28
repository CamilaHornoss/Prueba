# Triggers de auditoría y control de operaciones

## 1. Definición y objetivo

Un trigger es un objeto de base de datos que se ejecuta automáticamente ante determinados eventos, como `INSERT`, `UPDATE` o `DELETE`. En este proyecto se aplican para trazabilidad y control.

## 2. Auditoría de productos

Se creó la tabla `Auditoria_Producto` para registrar cambios sobre `Producto`.

El trigger `dbo.tr_AuditoriaProducto` se ejecuta después de `UPDATE` o `DELETE` y almacena:

- producto afectado;
- tipo de operación;
- descripción anterior y nueva;
- precio anterior y nuevo;
- stock anterior y nuevo;
- fecha y hora;
- usuario de base de datos que ejecutó la operación.

La implementación utiliza las tablas lógicas `deleted` e `inserted`, por lo que funciona también cuando una sentencia afecta más de una fila.

## 3. Trigger de bloqueo de borrado

Se implementó `dbo.tr_ImpedirEliminarProveedor` como trigger `INSTEAD OF DELETE` sobre `Proveedor`. Cuando se intenta eliminar un proveedor, el trigger emite un mensaje de error y evita la operación, preservando la trazabilidad histórica de las compras.

## 4. Pruebas

El archivo `sql/tecnico/triggers/pruebas_triggers.sql` demuestra:

1. un `UPDATE` sobre Producto y su registro de auditoría;
2. la creación, modificación y eliminación de un producto temporal para comprobar auditoría de `UPDATE` y `DELETE`;
3. un intento de eliminar un proveedor y la verificación posterior de que continúa existiendo.

## 5. Conclusión

Los triggers permiten registrar automáticamente cambios críticos sin depender de que cada aplicación cliente recuerde hacerlo. En el caso de Tienda OGA aportan trazabilidad sobre precio y stock y evitan eliminaciones que podrían comprometer el historial de operaciones.
