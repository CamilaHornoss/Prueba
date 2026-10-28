# Triggers de auditoría

Se crea `Auditoria_Producto` y un trigger `AFTER UPDATE, DELETE` sobre Producto que registra usuario, fecha/hora, valores anteriores y nuevos, y tipo de operación.

Además se implementa un trigger `INSTEAD OF DELETE` sobre Proveedor que emite un error y bloquea la eliminación. Las pruebas demuestran ambos comportamientos.
