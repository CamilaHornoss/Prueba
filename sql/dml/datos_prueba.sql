USE ProyectoTiendaOGA;
GO

INSERT INTO Cliente VALUES
('38456123','Carlos','Gomez','3794112233','Junin',1240,'Corrientes'),
('40123987','Lucia','Fernandez','3794998877','San Martin',850,'Resistencia'),
('42555111','Ana','Lopez','3624551100','Brown',330,'Resistencia'),
('36777222','Martin','Diaz','3794772200','Belgrano',1540,'Corrientes'),
('44999333','Sofia','Benitez','3624993300','Mitre',910,'Barranqueras'),
('39888444','Pablo','Romero','3794884400','Cordoba',745,'Corrientes'),
('43111555','Laura','Acosta','3624115500','Sarmiento',222,'Fontana'),
('35666677','Diego','Ruiz','3794666777','Mendoza',1800,'Corrientes');

INSERT INTO Metodo_pago(nombre_metodo) VALUES
('Efectivo'),('Transferencia'),('Tarjeta de debito'),('Tarjeta de credito'),('Mercado Pago'),('QR bancario'),('Cuenta corriente'),('Deposito bancario');

INSERT INTO Proveedor(cuit_proveedor,nombre_proveedor,telefono_proveedor) VALUES
('20123456789','Distribuidora Litoral','3794223344'),
('30987654321','Importaciones Norte','3794556677'),
('30700111222','Electro Mayorista','3624221100'),
('30666555444','Ferreteria Central','3624554400'),
('27222333444','Iluminacion NEA','3794334400'),
('20333444555','Seguridad Total','3794778800'),
('30777888999','Hogar Mayorista','3624889900'),
('30666111222','Tecnologia Corrientes','3794112200');

INSERT INTO Categorias(nombre_categoria) VALUES
('Seguridad y Vigilancia'),('Herramientas'),('Iluminacion LED'),('Electronica'),('Hogar'),('Ferreteria'),('Accesorios'),('Conectividad');

INSERT INTO Producto(descripcion_producto,stock_actual,precio_lista,id_categoria) VALUES
('Camara IP Wifi Domo Exterior',15,45000,1),
('Cortadora Profesional V9',8,38500,2),
('Reflector LED Solar 100W',30,22000,3),
('Tablet 10 pulgadas',12,185000,4),
('Secaplatos Acero',20,28000,5),
('Taladro Percutor 650W',10,76000,6),
('Cable HDMI 2 metros',40,8500,7),
('Router WiFi AC1200',18,54000,8);

INSERT INTO Compra(fecha_compra,hora_compra,estado_compra,id_proveedor) VALUES
('2026-09-01','09:10','RECIBIDA',1),('2026-09-03','11:25','RECIBIDA',2),('2026-09-05','15:00','RECIBIDA',3),('2026-09-08','10:40','RECIBIDA',4),
('2026-09-10','16:20','RECIBIDA',5),('2026-09-12','12:05','RECIBIDA',6),('2026-09-15','14:30','RECIBIDA',7),('2026-09-18','17:10','RECIBIDA',8);

INSERT INTO Detalle_compra VALUES
(1,1,32000,10),(2,2,27000,8),(3,3,15000,20),(4,4,142000,10),(5,5,19000,15),(6,6,56000,8),(7,7,5200,30),(8,8,39000,15),(1,6,31500,5),(3,5,14800,10);

INSERT INTO Venta(fecha_venta,hora_venta,estado_venta,dni_cliente) VALUES
('2026-09-20','10:15','ENTREGADA','38456123'),('2026-09-21','11:30','ENTREGADA','40123987'),('2026-09-22','12:45','PAGADA','42555111'),('2026-09-23','16:10','PREPARADA','36777222'),
('2026-09-24','17:25','ENTREGADA','44999333'),('2026-09-25','09:50','PAGADA','39888444'),('2026-09-26','14:20','ENTREGADA','43111555'),('2026-09-27','18:05','PENDIENTE','35666677');

INSERT INTO Detalle_venta VALUES
(1,1,45000,1),(3,1,22000,2),(2,2,38500,1),(4,3,185000,1),(5,4,28000,2),(6,5,76000,1),(7,6,8500,3),(8,7,54000,1),(3,7,22000,1),(1,8,45000,1);

INSERT INTO Pago(id_venta,id_metodo,fecha_pago,hora_pago,monto,referencia) VALUES
(1,1,'2026-09-20','10:20',40000,'PAG-0001'),(1,2,'2026-09-20','10:21',49000,'PAG-0002'),(2,3,'2026-09-21','11:35',38500,'PAG-0003'),(3,4,'2026-09-22','12:50',185000,'PAG-0004'),
(4,5,'2026-09-23','16:15',56000,'PAG-0005'),(5,2,'2026-09-24','17:30',76000,'PAG-0006'),(6,1,'2026-09-25','09:55',25500,'PAG-0007'),(7,6,'2026-09-26','14:25',30000,'PAG-0008'),
(7,1,'2026-09-26','14:26',46000,'PAG-0009'),(8,1,'2026-09-27','18:10',15000,'PAG-0010');
GO

SELECT 'Cliente' tabla, COUNT(*) registros FROM Cliente UNION ALL
SELECT 'Metodo_pago',COUNT(*) FROM Metodo_pago UNION ALL SELECT 'Proveedor',COUNT(*) FROM Proveedor UNION ALL SELECT 'Categorias',COUNT(*) FROM Categorias UNION ALL SELECT 'Producto',COUNT(*) FROM Producto UNION ALL
SELECT 'Compra',COUNT(*) FROM Compra UNION ALL SELECT 'Detalle_compra',COUNT(*) FROM Detalle_compra UNION ALL SELECT 'Venta',COUNT(*) FROM Venta UNION ALL SELECT 'Detalle_venta',COUNT(*) FROM Detalle_venta UNION ALL SELECT 'Pago',COUNT(*) FROM Pago;
GO
