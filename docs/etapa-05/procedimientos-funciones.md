# Procedimientos y funciones almacenadas

## 1. Definición y objetivo

Los procedimientos almacenados son rutinas T-SQL guardadas en el SGBD que permiten encapsular operaciones y reglas de negocio. Las funciones almacenadas reciben parámetros y devuelven un valor reutilizable dentro de consultas.

En Tienda OGA se utilizaron para centralizar operaciones CRUD sobre productos y cálculos frecuentes del negocio.

## 2. Procedimientos implementados

Se implementaron tres procedimientos sobre `Producto`:

- `dbo.sp_InsertarProducto`: inserta un producto.
- `dbo.sp_ModificarProducto`: modifica descripción, stock, precio y categoría.
- `dbo.sp_EliminarProducto`: elimina un producto.

Archivo: `sql/tecnico/procedimientos/procedimientos_crud.sql`.

## 3. Pruebas CRUD

El archivo `sql/tecnico/procedimientos/pruebas_procedimientos.sql` incluye:

1. un lote de productos insertado con `INSERT` directo;
2. otro lote insertado invocando `sp_InsertarProducto`;
3. un `UPDATE` mediante `sp_ModificarProducto`;
4. un `DELETE` mediante `sp_EliminarProducto`;
5. una consulta final para verificar el resultado.

## 4. Funciones implementadas

Se desarrollaron tres funciones escalares:

- `dbo.fn_TotalVenta(@id_venta)`: calcula el importe total histórico de una venta.
- `dbo.fn_TotalCompradoCliente(@dni)`: calcula el gasto acumulado de un cliente excluyendo ventas canceladas.
- `dbo.fn_CantidadVendidaProducto(@id_producto)`: devuelve la cantidad histórica de unidades vendidas de un producto.

Archivo: `sql/tecnico/funciones/funciones.sql`.

## 5. Comparación de eficiencia

El archivo `sql/tecnico/procedimientos/comparacion_eficiencia.sql` compara:

- inserciones directas vs inserciones mediante procedimiento;
- una agregación escrita directamente vs la misma lógica encapsulada en `fn_TotalVenta`.

La prueba devuelve tiempos medidos en la misma sesión y además habilita `STATISTICS IO` y `STATISTICS TIME` para observar lecturas y tiempo de CPU.

Las operaciones de benchmark se realizan dentro de transacciones que finalizan con `ROLLBACK`, evitando contaminar los datos definitivos.

## 6. Conclusión

Los procedimientos no se justifican únicamente por velocidad. Su principal valor es centralizar lógica, reutilizar operaciones, reducir código repetido y permitir otorgar `EXECUTE` sin conceder acceso directo de escritura sobre las tablas. Las funciones facilitan reutilizar cálculos y mantener una única definición de la lógica, aunque su rendimiento debe evaluarse según el caso y el volumen de datos.
