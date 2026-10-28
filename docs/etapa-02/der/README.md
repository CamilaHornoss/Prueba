# Diagrama Entidad–Relación (DER)

El DER conceptual del proyecto fue elaborado por el equipo en **ERDPlus** utilizando notación **P. Chen**, según la consigna de Bases de Datos I.

## DER conceptual elaborado en ERDPlus

El diagrama original se conserva como evidencia histórica de la Etapa II y se muestra directamente desde el repositorio del equipo:

![DER conceptual Tienda OGA](https://raw.githubusercontent.com/CamilaHornoss/proyecto-bd1-equipo_30/main/docs/etapa-02/der/der-etapa02.png)

Fuente: `proyecto-bd1-equipo_30/docs/etapa-02/der/der-etapa02.png`.

## Control de consistencia con el modelo final

Durante el refinamiento e implementación se ajustaron nombres, tipos y algunas decisiones de integridad. El siguiente diagrama resume las relaciones del **modelo final vigente** y sirve como control visual frente a `modelo-relacional.md` y `sql/ddl/crear_bd.sql`.

```mermaid
erDiagram
    CATEGORIAS ||--o{ PRODUCTO : clasifica
    CLIENTE ||--o{ VENTA : realiza
    PROVEEDOR ||--o{ COMPRA : abastece
    VENTA ||--|{ DETALLE_VENTA : contiene
    PRODUCTO ||--o{ DETALLE_VENTA : vendido_en
    COMPRA ||--|{ DETALLE_COMPRA : contiene
    PRODUCTO ||--o{ DETALLE_COMPRA : comprado_en
    VENTA ||--o{ PAGO : recibe
    METODO_PAGO ||--o{ PAGO : utiliza

    CLIENTE {
        char dni_cliente PK
        varchar nombre
        varchar apellido
        varchar telefono UK
        varchar calle
        int altura
        varchar localidad
    }

    CATEGORIAS {
        int id_categoria PK
        varchar nombre_categoria UK
    }

    PRODUCTO {
        int id_producto PK
        varchar descripcion_producto UK
        int stock_actual
        decimal precio_lista
        int id_categoria FK
    }

    PROVEEDOR {
        int id_proveedor PK
        char cuit_proveedor UK
        varchar nombre_proveedor
        varchar telefono_proveedor
    }

    COMPRA {
        int id_compra PK
        date fecha_compra
        time hora_compra
        varchar estado_compra
        int id_proveedor FK
    }

    DETALLE_COMPRA {
        int id_producto PK,FK
        int id_compra PK,FK
        decimal precio_compra
        int cantidad_compra
    }

    VENTA {
        int id_venta PK
        date fecha_venta
        time hora_venta
        varchar estado_venta
        char dni_cliente FK
    }

    DETALLE_VENTA {
        int id_producto PK,FK
        int id_venta PK,FK
        decimal precio_unitario
        int cantidad_venta
    }

    METODO_PAGO {
        int id_metodo PK
        varchar nombre_metodo UK
    }

    PAGO {
        int id_pago PK
        int id_venta FK
        int id_metodo FK
        date fecha_pago
        time hora_pago
        decimal monto
        varchar referencia UK
    }
```

La especificación formal de claves, restricciones y tipos se encuentra en `../modelo-relacional.md` y en `../../../sql/ddl/crear_bd.sql`.
