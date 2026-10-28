# Implementación física

La base se implementa en SQL Server mediante `sql/ddl/crear_bd.sql`. El script crea `ProyectoTiendaOGA`, define las 10 relaciones del modelo, claves primarias, claves foráneas y restricciones `NOT NULL`, `UNIQUE` y `CHECK`.

Los datos iniciales se cargan con `sql/dml/datos_prueba.sql`, que contiene entre 8 y 10 registros coherentes por tabla para permitir pruebas de integridad y consultas.

Las claves foráneas declaran `ON UPDATE NO ACTION` y `ON DELETE NO ACTION` para impedir modificaciones o eliminaciones que rompan la integridad referencial.
