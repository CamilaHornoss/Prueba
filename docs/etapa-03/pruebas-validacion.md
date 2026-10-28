# Pruebas de validación

1. Ejecutar `sql/ddl/crear_bd.sql` sin errores.
2. Ejecutar `sql/dml/datos_prueba.sql`.
3. Verificar conteos por tabla.
4. Probar que un precio negativo sea rechazado por `CHECK`.
5. Probar que una FK inexistente sea rechazada.
6. Probar que un CUIT duplicado sea rechazado por `UNIQUE`.
7. Verificar que los pagos de una venta puedan usar el mismo método en operaciones distintas gracias a `id_pago`.
