IF DB_ID('ProyectoTiendaOGA') IS NULL
    CREATE DATABASE ProyectoTiendaOGA;
GO

USE ProyectoTiendaOGA;
GO

DROP TABLE IF EXISTS Pago, Detalle_venta, Detalle_compra, Venta, Compra, Producto, Categorias, Proveedor, Metodo_pago, Cliente;
GO

CREATE TABLE Cliente (
    dni_cliente CHAR(8) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL UNIQUE,
    calle VARCHAR(70) NOT NULL,
    altura INT NOT NULL CHECK (altura > 0),
    localidad VARCHAR(50) NOT NULL
);

CREATE TABLE Metodo_pago (
    id_metodo INT IDENTITY(1,1) PRIMARY KEY,
    nombre_metodo VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE Proveedor (
    id_proveedor INT IDENTITY(1,1) PRIMARY KEY,
    cuit_proveedor CHAR(11) NOT NULL UNIQUE,
    nombre_proveedor VARCHAR(70) NOT NULL,
    telefono_proveedor VARCHAR(20) NOT NULL
);

CREATE TABLE Categorias (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre_categoria VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE Producto (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    descripcion_producto VARCHAR(100) NOT NULL UNIQUE,
    stock_actual INT NOT NULL CHECK (stock_actual >= 0),
    precio_lista DECIMAL(12,2) NOT NULL CHECK (precio_lista > 0),
    id_categoria INT NOT NULL,
    CONSTRAINT fk_Producto_Categoria FOREIGN KEY (id_categoria)
        REFERENCES Categorias(id_categoria) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE Venta (
    id_venta INT IDENTITY(1,1) PRIMARY KEY,
    fecha_venta DATE NOT NULL,
    hora_venta TIME(0) NOT NULL,
    estado_venta VARCHAR(15) NOT NULL,
    dni_cliente CHAR(8) NOT NULL,
    CONSTRAINT ck_Venta_Estado CHECK (estado_venta IN ('PENDIENTE','PAGADA','PREPARADA','ENTREGADA','CANCELADA')),
    CONSTRAINT fk_Venta_Cliente FOREIGN KEY (dni_cliente)
        REFERENCES Cliente(dni_cliente) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE Compra (
    id_compra INT IDENTITY(1,1) PRIMARY KEY,
    fecha_compra DATE NOT NULL,
    hora_compra TIME(0) NOT NULL,
    estado_compra VARCHAR(15) NOT NULL,
    id_proveedor INT NOT NULL,
    CONSTRAINT ck_Compra_Estado CHECK (estado_compra IN ('PENDIENTE','RECIBIDA','CANCELADA')),
    CONSTRAINT fk_Compra_Proveedor FOREIGN KEY (id_proveedor)
        REFERENCES Proveedor(id_proveedor) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE Detalle_compra (
    id_producto INT NOT NULL,
    id_compra INT NOT NULL,
    precio_compra DECIMAL(12,2) NOT NULL CHECK (precio_compra > 0),
    cantidad_compra INT NOT NULL CHECK (cantidad_compra > 0),
    CONSTRAINT pk_Detalle_compra PRIMARY KEY (id_producto, id_compra),
    CONSTRAINT fk_DetalleCompra_Producto FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto) ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_DetalleCompra_Compra FOREIGN KEY (id_compra)
        REFERENCES Compra(id_compra) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE Detalle_venta (
    id_producto INT NOT NULL,
    id_venta INT NOT NULL,
    precio_unitario DECIMAL(12,2) NOT NULL CHECK (precio_unitario > 0),
    cantidad_venta INT NOT NULL CHECK (cantidad_venta > 0),
    CONSTRAINT pk_Detalle_venta PRIMARY KEY (id_producto, id_venta),
    CONSTRAINT fk_DetalleVenta_Producto FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto) ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_DetalleVenta_Venta FOREIGN KEY (id_venta)
        REFERENCES Venta(id_venta) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE Pago (
    id_pago INT IDENTITY(1,1) PRIMARY KEY,
    id_venta INT NOT NULL,
    id_metodo INT NOT NULL,
    fecha_pago DATE NOT NULL,
    hora_pago TIME(0) NOT NULL,
    monto DECIMAL(12,2) NOT NULL CHECK (monto > 0),
    referencia VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT fk_Pago_Venta FOREIGN KEY (id_venta)
        REFERENCES Venta(id_venta) ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_Pago_Metodo FOREIGN KEY (id_metodo)
        REFERENCES Metodo_pago(id_metodo) ON UPDATE NO ACTION ON DELETE NO ACTION
);
GO
