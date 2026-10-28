# Procedimientos y funciones almacenadas

Se implementan tres procedimientos CRUD sobre Producto: insertar, modificar y eliminar. También se desarrollan tres funciones: total de una venta, total comprado por cliente y cantidad histórica vendida de un producto.

Las pruebas comparan operaciones directas con ejecución mediante procedimientos. La principal mejora observada no se limita al tiempo: los procedimientos centralizan validaciones, permiten reutilizar lógica y facilitan el control de permisos mediante `GRANT EXECUTE`.

Scripts: `sql/tecnico/procedimientos/` y `sql/tecnico/funciones/`.
