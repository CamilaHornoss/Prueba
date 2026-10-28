# 🗄️ Proyecto Bases de Datos I — Tienda OGA

**Equipo 30 — FaCENA | UNNE — 2026**

Base de datos relacional para la gestión de clientes, productos, stock, compras, ventas y cobranzas de Tienda OGA.

---

<div align="center">

![GIF épico de Tienda OGA](https://github.com/user-attachments/assets/28ef8640-dde2-497b-95b0-6c0df0e6ea0b)

</div>

---

## Tecnologías
- Microsoft SQL Server / T-SQL
- ERDPlus para modelado conceptual
- Git y GitHub para control de versiones

## Etapas
| Etapa | Producto | Ubicación |
|---|---|---|
| I. Requerimientos | Requerimientos + reglas de negocio | `docs/etapa-01/` |
| II. Modelado | DER + modelo relacional + 3FN | `docs/etapa-02/` |
| III. Implementación | DDL + DML | `docs/etapa-03/`, `sql/ddl/`, `sql/dml/` |
| IV. Consultas | SQL + casos de uso | `docs/etapa-04/`, `sql/consultas/` |
| V. Temas técnicos | Procedimientos, funciones, transacciones, triggers, seguridad e índices | `docs/etapa-05/`, `sql/tecnico/` |

## Estructura
```text
proyecto-bd1-equipo_30/
├── docs/
│   ├── etapa-01/
│   ├── etapa-02/
│   ├── etapa-03/
│   ├── etapa-04/
│   └── etapa-05/
├── sql/
│   ├── ddl/
│   ├── dml/
│   ├── consultas/
│   └── tecnico/
│       ├── procedimientos/
│       ├── funciones/
│       ├── transacciones/
│       ├── triggers/
│       ├── seguridad/
│       └── indices/
└── README.md
```

## Ejecución
1. Ejecutar `sql/ddl/crear_bd.sql`.
2. Ejecutar `sql/dml/datos_prueba.sql`.
3. Ejecutar las consultas de `sql/consultas/`.
4. Ejecutar los scripts de `sql/tecnico/` según cada tema.

> Los scripts fueron organizados para ser ejecutados sobre SQL Server y la base `ProyectoTiendaOGA`.
