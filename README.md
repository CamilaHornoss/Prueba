<div align="center">

# 🗄️ Proyecto Bases de Datos I — Tienda OGA

### Equipo 30 · FaCENA | UNNE · 2026

**Diseño, normalización e implementación de una base de datos relacional para la gestión de ventas, stock, compras y cobranzas de Tienda OGA.**

<br>

[![Last Commit](https://img.shields.io/github/last-commit/CamilaHornoss/Prueba?style=for-the-badge&logo=git&logoColor=white&color=7c3aed)](https://github.com/CamilaHornoss/Prueba/commits/main)
[![Commits](https://img.shields.io/github/commit-activity/t/CamilaHornoss/Prueba?style=for-the-badge&logo=github&logoColor=white&color=10b981)](https://github.com/CamilaHornoss/Prueba/commits/main)
![SQL Server](https://img.shields.io/badge/SQL%20Server-T--SQL-CC292B?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![3FN](https://img.shields.io/badge/Normalización-3FN-0ea5e9?style=for-the-badge)
![ERDPlus](https://img.shields.io/badge/ERDPlus-DER-f59e0b?style=for-the-badge&logo=diagramsdotnet&logoColor=white)
![GitHub](https://img.shields.io/badge/Git%20%26%20GitHub-Control%20de%20versiones-181717?style=for-the-badge&logo=github&logoColor=white)
![Etapa V](https://img.shields.io/badge/Etapa%20V-Implementada-22c55e?style=for-the-badge)

<br>

</div>

---

<div align="center">

![GIF épico de Tienda OGA](https://github.com/user-attachments/assets/28ef8640-dde2-497b-95b0-6c0df0e6ea0b)

</div>

---

## 📖 Sobre el proyecto

Proyecto integrador de **Bases de Datos I** orientado a **Tienda OGA**, un comercio minorista polirrubro.

La solución centraliza la información necesaria para administrar las operaciones principales del negocio mediante **Microsoft SQL Server** y aplica los contenidos desarrollados durante la asignatura: modelado conceptual, transformación al modelo relacional, normalización hasta **Tercera Forma Normal (3FN)**, DDL, DML, consultas SQL y mecanismos avanzados del SGBD.

### ✨ El sistema contempla

- 👤 **Clientes:** datos personales, contacto y domicilio.
- 📦 **Productos y stock:** catálogo, categorías, precios y existencias.
- 🚚 **Compras:** proveedores, órdenes y detalle de productos adquiridos.
- 🛒 **Ventas:** encabezado, detalle y conservación del precio histórico.
- 💳 **Pagos y cobranzas:** múltiples medios de pago y referencias de cobro.
- 📊 **Consultas de negocio:** comprobantes, reportes agregados y análisis avanzados.
- 🧠 **Temas técnicos:** procedimientos, funciones, transacciones simples y anidadas, triggers, seguridad, roles e índices.

---

## 🛠️ Tecnologías

<div align="center">

| Herramienta | Uso en el proyecto |
| :--- | :--- |
| **Microsoft SQL Server / T-SQL** | Implementación y administración de la base de datos |
| **SQL Server Management Studio (SSMS)** | Ejecución, pruebas y análisis de consultas |
| **ERDPlus** | Diagrama Entidad–Relación con notación P. Chen |
| **Git & GitHub** | Versionado, trazabilidad y trabajo colaborativo |

</div>

---

## 🎯 Etapas del proyecto

| Etapa | Pregunta que responde | Producto | Ubicación | Estado |
| :--- | :--- | :--- | :--- | :---: |
| **I. Requerimientos** | ¿Qué necesita el negocio? | Requerimientos + reglas de negocio | `docs/etapa-01/` | ✅ |
| **II. Modelado** | ¿Cómo representamos la información? | DER + modelo relacional + 3FN | `docs/etapa-02/` | ✅ |
| **III. Implementación** | ¿Cómo construimos la BD? | DDL + DML | `docs/etapa-03/`, `sql/ddl/`, `sql/dml/` | ✅ |
| **IV. Consultas** | ¿Cómo obtenemos información? | SQL + casos de uso | `docs/etapa-04/`, `sql/consultas/` | ✅ |
| **V. Temas técnicos** | ¿Cómo hacemos la solución más robusta? | Procedimientos, funciones, transacciones, triggers, seguridad e índices | `docs/etapa-05/`, `sql/tecnico/` | ✅ |

> La implementación de Etapa V está completa. Los valores de rendimiento, planes de ejecución y verificación del modo de autenticación deben obtenerse ejecutando los scripts en la instancia real de SQL Server; el repositorio incluye una hoja específica para registrar esas evidencias sin inventar resultados.

---

## 📂 Estructura del repositorio

```text
Prueba/
│
├── docs/
│   ├── etapa-01/        # Requerimientos y reglas de negocio
│   ├── etapa-02/        # Modelo relacional y normalización
│   ├── etapa-03/        # Implementación e integridad
│   ├── etapa-04/        # Consultas y casos de uso
│   └── etapa-05/        # Temas técnicos + checklist + evidencias
│
├── sql/
│   ├── ddl/             # Creación de la base y tablas
│   ├── dml/             # Datos de prueba
│   ├── consultas/       # Consultas de negocio
│   └── tecnico/
│       ├── procedimientos/
│       ├── funciones/
│       ├── transacciones/
│       ├── triggers/
│       ├── seguridad/
│       └── indices/
│
└── README.md
```

---

## 🚀 Puesta en marcha

Ejecutar los scripts en **SQL Server Management Studio (SSMS)** siguiendo este orden inicial:

1. `sql/ddl/crear_bd.sql`
2. `sql/dml/datos_prueba.sql`
3. Scripts de `sql/consultas/`
4. Para la Etapa V, seguir el orden detallado en `docs/etapa-05/README.md`

La base utilizada por los scripts es:

```text
ProyectoTiendaOGA
```

---

## 🔎 Consultas implementadas

- 🧾 **Comprobante de venta:** encabezado, detalle, subtotales y total acumulado.
- 📈 **Informe de ventas:** agregación por categoría y rango de fechas.
- 🧮 **Consulta avanzada:** combinación de múltiples tablas mediante `JOIN`, agregaciones, `HAVING` y subconsultas.

---

## ⚙️ Etapa V — Temas técnicos

La Etapa V cubre los requisitos 2026 de la cátedra:

- **3 procedimientos CRUD:** `INSERT`, `UPDATE` y `DELETE` sobre Producto.
- **3 funciones almacenadas:** total de venta, total comprado por cliente y cantidad vendida por producto.
- **Benchmark:** comparación directa vs procedimientos/funciones con medición reproducible.
- **Transacciones:** caso exitoso, error intencional con `ROLLBACK` y transacciones anidadas.
- **Triggers:** auditoría de `UPDATE`/`DELETE` y bloqueo de eliminación de proveedores.
- **Seguridad:** verificación de modo mixto, usuarios administrador/lector, `GRANT EXECUTE` y roles.
- **Índices:** carga automática de 1.000.000 de filas, `STATISTICS IO/TIME` y comparación de índices agrupados.
- **Validación final:** script que verifica objetos técnicos, usuarios, permisos, auditoría e índices.

Documentación central: `docs/etapa-05/README.md`.

---

## 👥 Integrantes

<div align="center">

| Integrante | GitHub |
| :--- | :--- |
| **Christian Gabriel Jesús Gómez** | [@Chris10TS](https://github.com/Chris10TS) |
| **Camila Paloma Hornos** | [@CamilaHornoss](https://github.com/CamilaHornoss) |
| **Selenia Agustina Gómez** | [@seleniagomez](https://github.com/seleniagomez) |
| **Camila Hernández González** | [@CamilaHernande7](https://github.com/CamilaHernande7) |
| **Bruno Fabricio González Oviedo** | [@FabricioGonzalez99](https://github.com/FabricioGonzalez99) |

</div>

---

<div align="center">

### 🛒 Tienda OGA · Bases de Datos I · Equipo 30

**De la planilla al SQL. De la venta al dato.** ✨

⭐ **FaCENA · UNNE · 2026** ⭐

</div>
