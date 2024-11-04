create database Farmacia;
use Farmacia;

CREATE TABLE Medicamentos (
    id_medicamento INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    laboratorio VARCHAR(100)
);
ALTER TABLE Medicamentos
ADD id_proveedor INT;


CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    direccion VARCHAR(200),
    email VARCHAR(100)
);

CREATE TABLE Ventas (
    id_venta INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT,
    fecha DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Detalle_Venta (
    id_detalle INT PRIMARY KEY IDENTITY(1,1),
    id_venta INT,
    id_medicamento INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),
    FOREIGN KEY (id_medicamento) REFERENCES Medicamentos(id_medicamento)
);

CREATE TABLE Proveedores (
    id_proveedor INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100),
    telefono VARCHAR(15),
    direccion VARCHAR(200),
    email VARCHAR(100)
);
ALTER TABLE Medicamentos
ADD id_proveedor INT;

ALTER TABLE Medicamentos
ADD CONSTRAINT FK_Medicamentos_Proveedores
FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor);


CREATE TABLE Categorias (
    id_categoria INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE Medicamento_Categoria (
    id_medicamento INT,
    id_categoria INT,
    PRIMARY KEY (id_medicamento, id_categoria),
    FOREIGN KEY (id_medicamento) REFERENCES Medicamentos(id_medicamento),
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

CREATE TABLE Recetas (
    id_receta INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT,
    fecha DATE NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Receta_Detalle (
    id_detalle INT PRIMARY KEY IDENTITY(1,1),
    id_receta INT,
    id_medicamento INT,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_receta) REFERENCES Recetas(id_receta),
    FOREIGN KEY (id_medicamento) REFERENCES Medicamentos(id_medicamento)
);

CREATE TABLE Empleados (
    id_empleado INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    direccion VARCHAR(200),
    cargo VARCHAR(100),
    salario DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Ventas_Empleados (
    id_venta INT,
    id_empleado INT,
    PRIMARY KEY (id_venta, id_empleado),
    FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)
);

CREATE TABLE Historial_Stock (
    id_historial INT PRIMARY KEY IDENTITY(1,1),
    id_medicamento INT,
    fecha DATE NOT NULL,
    cambio_stock INT NOT NULL,
    razon VARCHAR(200),
    FOREIGN KEY (id_medicamento) REFERENCES Medicamentos(id_medicamento)
);

CREATE TABLE Promociones (
    id_promocion INT PRIMARY KEY IDENTITY(1,1),
    descripcion VARCHAR(200) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    descuento DECIMAL(5, 2) NOT NULL
);

CREATE TABLE Medicamento_Promocion (
    id_medicamento INT,
    id_promocion INT,
    PRIMARY KEY (id_medicamento, id_promocion),
    FOREIGN KEY (id_medicamento) REFERENCES Medicamentos(id_medicamento),
    FOREIGN KEY (id_promocion) REFERENCES Promociones(id_promocion)
);

CREATE TABLE Devoluciones (
    id_devolucion INT PRIMARY KEY IDENTITY(1,1),
    id_venta INT,
    fecha DATE NOT NULL,
    motivo VARCHAR(200),
    FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta)
);


INSERT INTO Medicamentos(nombre, descripcion, precio, stock, laboratorio)
VALUES
('Paracetamol', 'Paracetamol 500mg', 5.50, 100, 'Laboratorio A'),
('Ibuprofeno', 'Ibuprofeno 200mg', 7.20, 50, 'Laboratorio B'),
('Amoxicilina', 'Amoxicilina 500mg', 8.30, 75, 'Laboratorio C'),
('Loratadina', 'Loratadina 10mg', 4.00, 120, 'Laboratorio D'),
('Metformina', 'Metformina 850mg', 6.80, 200, 'Laboratorio E'),
('Enalapril', 'Enalapril 10mg', 9.50, 90, 'Laboratorio F'),
('Omeprazol', 'Omeprazol 20mg', 3.60, 110, 'Laboratorio G'),
('Aspirina', 'Aspirina 100mg', 2.50, 150, 'Laboratorio H'),
('Simvastatina', 'Simvastatina 20mg', 12.00, 40, 'Laboratorio I'),
('Losartan', 'Losartan 50mg', 11.00, 60, 'Laboratorio J'),
('Atorvastatina', 'Atorvastatina 10mg', 13.50, 80, 'Laboratorio K'),
('Diclofenaco', 'Diclofenaco 50mg', 2.80, 130, 'Laboratorio L'),
('Ranitidina', 'Ranitidina 150mg', 4.50, 55, 'Laboratorio M'),
('Metoclopramida', 'Metoclopramida 10mg', 7.10, 65, 'Laboratorio N'),
('Azitromicina', 'Azitromicina 500mg', 10.30, 35, 'Laboratorio O'),
('Furosemida', 'Furosemida 40mg', 9.80, 25, 'Laboratorio P'),
('Clopidogrel', 'Clopidogrel 75mg', 15.00, 45, 'Laboratorio Q'),
('Warfarina', 'Warfarina 5mg', 18.70, 30, 'Laboratorio R'),
('Levotiroxina', 'Levotiroxina 50mcg', 5.90, 95, 'Laboratorio S'),
('Bisoprolol', 'Bisoprolol 5mg', 14.20, 85, 'Laboratorio T');




INSERT INTO Clientes (nombre, apellido, telefono, direccion, email)
VALUES 
('Juan', 'Pérez', '555-1234', 'Calle Falsa 123', 'juan.perez@mail.com'),
('María', 'González', '555-5678', 'Av. Libertador 456', 'maria.gonzalez@hotmail.com'),
('Carlos', 'Ramírez', '555-9876', 'Jr. Los Rosales 789', 'carlos.ramirez@gmail.com'),
('Ana', 'Fernández', '555-4321', 'Pasaje Las Flores 321', 'ana.fernandez@outlook.com'),
('Luis', 'Martínez', '555-8765', 'Av. Los Pinos 654', 'luis.martinez@trentino.edu.pe'),
('Sofía', 'Torres', '555-2468', 'Calle Los Jazmines 135', 'sofia.torres@example.net'),
('Miguel', 'Sánchez', '555-1357', 'Jr. Las Palmeras 753', 'miguel.sanchez@gmail.com'),
('Laura', 'Castro', '555-9753', 'Av. Los Olivos 852', 'laura.castro@mail.com'),
('Pedro', 'Gómez', '555-2469', 'Calle Los Sauces 963', 'pedro.gomez@hotmail.com'),
('Carmen', 'Reyes', '555-7531', 'Pasaje Los Cedros 741', 'carmen.reyes@mail.com'),
('Fernando', 'López', '555-8642', 'Jr. Las Magnolias 258', 'fernando.lopez@outlook.com'),
('Gabriela', 'Morales', '555-9751', 'Av. Los Robles 357', 'gabriela.morales@trentino.edu.pe'),
('Jorge', 'Rojas', '555-7539', 'Calle Las Orquídeas 654', 'jorge.rojas@gmail.com'),
('Elena', 'Hernández', '555-2467', 'Jr. Las Acacias 987', 'elena.hernandez@hotmail.com'),
('Ricardo', 'Vega', '555-1359', 'Av. Los Tulipanes 456', 'ricardo.vega@gmail.com'),
('Paola', 'Muñoz', '555-8643', 'Calle Las Margaritas 159', 'paola.munoz@outlook.com'),
('Diego', 'Salas', '555-7538', 'Pasaje Las Violetas 753', 'diego.salas@gmail.com'),
('Mónica', 'Ortiz', '555-8641', 'Jr. Los Cipreses 951', 'monica.ortiz@hotmail.com'),
('Oscar', 'Valdez', '555-9750', 'Calle Los Nogales 753', 'oscar.valdez@example.net'),
('Patricia', 'Campos', '555-2465', 'Av. Las Gardenias 159', 'patricia.campos@mail.com');


INSERT INTO Ventas (id_cliente, fecha, total)
VALUES
    (1, '2024-09-10', 85.50),
    (2, '2024-09-11', 63.40),
    (3, '2024-09-12', 120.00),
    (4, '2024-09-13', 52.30),
    (5, '2024-09-14', 200.25),
    (6, '2024-09-15', 75.80),
    (7, '2024-09-16', 95.60),
    (8, '2024-09-17', 150.90),
    (9, '2024-09-18', 45.30),
    (10, '2024-09-19', 180.70),
    (11, '2024-09-20', 210.50),
    (12, '2024-09-21', 99.90),
    (13, '2024-09-22', 250.80),
    (14, '2024-09-23', 78.00),
    (15, '2024-09-24', 140.10),
    (16, '2024-09-25', 87.65),
    (17, '2024-09-26', 165.50),
    (18, '2024-09-27', 105.00),
    (19, '2024-09-28', 190.40),
    (20, '2024-09-29', 133.70);

INSERT INTO Detalle_Venta (id_venta, id_medicamento, cantidad, precio_unitario)
VALUES 
    (1, 2, 2, 5.50),   
    (2, 3, 1, 7.20),   
	(3, 4, 3, 8.30),
	(4, 5, 2, 4.00),
	(5, 6, 1, 6.80),
	(6, 7, 3, 9.50),
	(7, 8 , 1, 3.60),
	(8, 9 , 2, 2.50),
	(9, 10, 1, 12.00),
	(10, 11, 4, 11.00),
	(11, 12, 3, 13.50),
	(12, 13, 1, 2.80),
	(13,14, 1, 4.50),
	(14, 15, 4, 7.10),
	(15,16, 1, 10.30),
	(16,17, 2, 9.80),
	(17,18, 5, 15.00),
	(18,19,6, 18.70),
	(19,20,2, 5.90),
	(20,21, 4, 14.20);

INSERT INTO Proveedores (nombre, contacto, telefono, direccion, email) 
VALUES 
    ('Inretail Pharma S.A', 'Carlos Martínez', '555-0011', 'Av. Las Ciencias 100', 'contacto@inretailpharma.com'),
    ('Abbot', 'Sofía López', '555-0012', 'Calle Las Flores 200', 'contacto@abbot.com'),
    ('Farmindustria', 'Jorge Rodríguez', '555-0013', 'Jr. Las Palmeras 300', 'contacto@farmindustria.com'),
    ('INDEUREC S.A.', 'Patricia Gómez', '555-0014', 'Pasaje Los Abetos 400', 'contacto@indeurec.com'),
    ('Gennoma Lab', 'Ricardo Sánchez', '555-0015', 'Av. Los Olivos 500', 'contacto@gennomalab.com'),
    ('GlaxoSmithKline (GSK)', 'Fernando Pérez', '555-0016', 'Calle Las Magnolias 600', 'contacto@gsk.com'),
    ('Teva', 'Ana Fernández', '555-0017', 'Jr. Las Violetas 700', 'contacto@teva.com'),
    ('Vick', 'Diego Morales', '555-0018', 'Calle Los Jazmines 800', 'contacto@vick.com'),
    ('Bayer S.A.', 'Elena Torres', '555-0019', 'Av. Los Robles 900', 'contacto@bayer.com'),
    ('Pfizer', 'Juan Rojas', '555-0020', 'Jr. Los Cipreses 1000', 'contacto@pfizer.com'),
    ('Novartis', 'Carmen Valdez', '555-0021', 'Calle Las Gardenias 1100', 'contacto@novartis.com'),
    ('GlaxoSmithKline (GSK)', 'Mónica Salas', '555-0022', 'Av. Los Tulipanes 1200', 'contacto@gsk.com'),
    ('Teva Pharmaceuticals', 'Oscar Hernández', '555-0023', 'Calle Las Acacias 1300', 'contacto@tevapharma.com'),
    ('Redoxon', 'Gabriela Muñoz', '555-0024', 'Pasaje Los Cedros 1400', 'contacto@redoxon.com'),
    ('Roche', 'Luis Campos', '555-0025', 'Jr. Las Orquídeas 1500', 'contacto@roche.com'),
    ('Eli Lilly and Company', 'Miguel Vega', '555-0026', 'Av. Las Margaritas 1600', 'contacto@lilly.com'),
    ('Sanofi-Aventis', 'Laura Castro', '555-0027', 'Calle Los Nogales 1700', 'contacto@sanofi.com'),
    ('Novartis', 'Pedro Gómez', '555-0028', 'Av. Las Palmeras 1800', 'contacto@novartis.com'),
    ('Bayer S.A.', 'Fernando López', '555-0029', 'Calle Falsa 1900', 'contacto@bayer.com'),
    ('Pfizer', 'Sofía Torres', '555-0030', 'Av. Libertador 2000', 'contacto@pfizer.com');

INSERT INTO Categorias (nombre, descripcion)
VALUES 
    ('Analgésicos', 'Medicamentos que ayudan a aliviar el dolor.'),
    ('Antiinflamatorios', 'Fármacos que reducen la inflamación y alivian el dolor.'),
    ('Antibióticos', 'Medicamentos usados para tratar infecciones bacterianas.'),
    ('Antihistamínicos', 'Fármacos que ayudan a aliviar síntomas de alergias.'),
    ('Suplementos Vitaminicos', 'Productos que complementan la dieta y aportan vitaminas.'),
    ('Hepatoprotectores', 'Medicamentos que protegen el hígado.'),
    ('Antiácidos', 'Fármacos que ayudan a neutralizar la acidez estomacal.'),
    ('Mucolíticos', 'Medicamentos que ayudan a deshacer la mucosidad en las vías respiratorias.'),
    ('Antitusígenos', 'Fármacos que alivian la tos.'),
    ('Laxantes', 'Medicamentos que ayudan a aliviar el estreñimiento.'),
    ('Antidepresivos', 'Medicamentos usados para tratar la depresión y trastornos de ansiedad.'),
    ('Antivirales', 'Medicamentos que combaten infecciones virales.'),
    ('Hidratantes', 'Productos que ayudan a reponer líquidos y electrolitos.'),
    ('Vasodilatadores', 'Medicamentos que dilatan los vasos sanguíneos y mejoran la circulación.'),
    ('Antipiréticos', 'Fármacos que reducen la fiebre.'),
    ('Antieméticos', 'Medicamentos que previenen o alivian las náuseas y vómitos.'),
    ('Sedantes', 'Fármacos que inducen la calma y el sueño.'),
    ('Antiinfecciosos', 'Medicamentos que previenen o tratan infecciones.'),
    ('Antiparasitarios', 'Fármacos utilizados para eliminar parásitos.'),
    ('Inmunomoduladores', 'Medicamentos que modifican la respuesta inmune.'),
    ('Analgesicos Opioides', 'Medicamentos más potentes para el manejo del dolor severo.');

	select * from Medicamento_Categoria;

INSERT INTO Medicamento_Categoria (id_medicamento, id_categoria)
VALUES
    (2,1),
    (3,2),
    (4,3),
    (5,4),
    (6, 5),
    (7, 6),
    (8, 7),
    (9, 8),
    (10, 9),
    (11, 10),
    (12, 12),
    (13, 12),
    (14, 13),
    (15, 14),
    (16, 15),
    (17, 16),
    (18, 17),
    (19, 18),
    (20, 19),
    (21, 20);

INSERT INTO Recetas (id_cliente, fecha, descripcion)
VALUES 
    (1, '2023-09-10', 'Receta para tratamiento de migraña, incluye Bio Electro y Paracetamol.'),
    (2, '2023-09-11', 'Receta para infecciones, incluye Amoxicilina y Ibuprofeno.'),
    (3, '2023-09-12', 'Receta para dolor muscular, incluye Diclofenaco y Vick Vaporub.'),
    (4, '2023-09-13', 'Receta para alivio de alergias, incluye Loratadina y Cetirizina.'),
    (5, '2023-09-14', 'Receta para tratamiento de acidez, incluye Omeprazol y Sal de Andrews.'),
    (6, '2023-09-15', 'Receta para protección hepática, incluye Hepabionta Forte y Tioctan Plus.'),
    (7, '2023-09-16', 'Receta para fiebre y dolor, incluye Doloflam y Paracetamol.'),
    (8, '2023-09-17', 'Receta para hidratación, incluye Suerox y vitamina C.'),
    (9, '2023-09-18', 'Receta para infecciones virales, incluye antivirales y analgésicos.'),
    (10, '2023-09-19', 'Receta para tratamiento de tos, incluye Vick Vaporub y un antitusígeno.'),
    (11, '2023-09-20', 'Receta para tratar el estrés, incluye Clonazepam y un relajante.'),
    (12, '2023-09-21', 'Receta para tratamiento de gastritis, incluye Aci Basic y Omeprazol.'),
    (13, '2023-09-22', 'Receta para cuidado de la piel, incluye vitamina C y un hidratante.'),
    (14, '2023-09-23', 'Receta para tratamiento de diabetes, incluye Insulina y un antidiabético.'),
    (15, '2023-09-24', 'Receta para tratamiento de resfriados, incluye Gloranta y un descongestionante.'),
    (16, '2023-09-25', 'Receta para aliviar síntomas de resfriado, incluye Bio Electro y un mucolítico.'),
    (17, '2023-09-26', 'Receta para cuidado intestinal, incluye un laxante y un probiótico.'),
    (18, '2023-09-27', 'Receta para mejorar el sistema inmunológico, incluye Vitamina C y un inmunomodulador.'),
    (19, '2023-09-28', 'Receta para tratamiento de ansiedad, incluye Clonazepam y un antidepresivo.'),
    (20, '2023-09-29', 'Receta para tratamiento de alergias, incluye Cetirizina y Loratadina.');

INSERT INTO Receta_Detalle (id_receta, id_medicamento, cantidad)
VALUES 
    (1, 2, 2),
    (1, 3, 3),
    (2, 4, 1),
    (2, 5, 2),
    (3, 6, 1),
    (3, 7, 2),
    (4, 8, 3),
    (4, 9, 2),
    (5, 10, 1),
    (5, 11, 1),
    (6, 12, 2),
    (6, 13, 1),
    (7, 14, 3),
    (7, 15, 1),
    (8, 16, 5),
    (8, 17, 2),
    (9, 18, 2),
    (9, 19, 3),
    (10, 20, 2),
    (10, 21, 1);
    

INSERT INTO Empleados (nombre, apellido, telefono, direccion, cargo, salario)
VALUES 
    ('Juan', 'Pérez', '555-1010', 'Calle Mariquita, Barranco', 'Farmacéutico', 2500.00),
    ('María', 'González', '555-2020', 'Av. Nicolás de Piérola, La Colmena', 'Gerente', 4500.00),
    ('Carlos', 'Ramírez', '555-3030', 'Jr. La Unión, Centro Histórico', 'Técnico', 1800.00),
    ('Ana', 'Fernández', '555-4040', 'Pasaje 4, Ciudad D', 'Asistente', 1500.00),
    ('Luis', 'Martínez', '555-5050', 'Av. 5, Ciudad E', 'Contador', 3200.00),
    ('Sofía', 'Torres', '555-6060', 'Calle 6, Ciudad F', 'Vendedor', 2000.00),
    ('Miguel', 'Sánchez', '555-7070', 'Jr. 7, Ciudad G', 'Promotor', 1700.00),
    ('Laura', 'Castro', '555-8080', 'Av. 8, Ciudad H', 'Químico', 3600.00),
    ('Pedro', 'Gómez', '555-9090', 'Calle 9, Ciudad I', 'Gerente de Ventas', 4800.00),
    ('Carmen', 'Reyes', '555-1001', 'Pasaje 10, Ciudad J', 'Asistente de Ventas', 1400.00),
    ('Fernando', 'López', '555-1002', 'Jr. 11, Ciudad K', 'Administrador', 2900.00),
    ('Gabriela', 'Morales', '555-1003', 'Av. 12, Ciudad L', 'Recepcionista', 1300.00),
    ('Jorge', 'Rojas', '555-1004', 'Calle 13, Ciudad M', 'Encargado de Stock', 1600.00),
    ('Elena', 'Hernández', '555-1005', 'Jr. 14, Ciudad N', 'Supervisor', 3700.00),
    ('Ricardo', 'Vega', '555-1006', 'Av. 15, Ciudad O', 'Analista', 3000.00),
    ('Paola', 'Muñoz', '555-1007', 'Calle 16, Ciudad P', 'Auxiliar', 1200.00),
    ('Diego', 'Salas', '555-1008', 'Pasaje 17, Ciudad Q', 'Coordinador', 2500.00),
    ('Mónica', 'Ortiz', '555-1009', 'Jr. 18, Ciudad R', 'Técnico de Laboratorio', 2200.00),
    ('Oscar', 'Valdez', '555-1011', 'Av. 19, Ciudad S', 'Jefe de Calidad', 4000.00),
    ('Patricia', 'Campos', '555-1012', 'Calle 20, Ciudad T', 'Investigador', 3800.00);

INSERT INTO Ventas_Empleados (id_venta, id_empleado) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 4),
(3, 2),
(3, 5),
(4, 1),
(4, 3),
(5, 2),
(5, 6),
(6, 4),
(7, 3),
(8, 2),
(9, 1),
(10, 5),
(11, 3),
(12, 2),
(13, 4),
(14, 1),
(15, 6),
(16, 2),
(17, 3),
(18, 4),
(19, 5),
(20, 1),
(20, 2);

INSERT INTO Historial_Stock (id_medicamento, fecha, cambio_stock, razon) VALUES
(2, '2024-01-15', 50, 'Recepción de nuevo stock'),
(3, '2024-01-16', -10, 'Devolución de medicamentos defectuosos'),
(4, '2024-01-17', 30, 'Ajuste de inventario'),
(5, '2024-01-18', -5, 'Venta de productos'),
(6, '2024-01-19', 20, 'Promoción de productos'),
(7, '2024-01-20', -15, 'Consumo interno'),
(8, '2024-01-21', 25, 'Compra de medicamentos'),
(9, '2024-01-22', -10, 'Destrucción de medicamentos caducados'),
(10, '2024-01-23', 40, 'Recepción de nuevo stock'),
(11, '2024-01-24', -20, 'Venta de productos'),
(12, '2024-01-25', 15, 'Ajuste de inventario'),
(13, '2024-01-26', -5, 'Devolución de productos'),
(14, '2024-01-27', 10, 'Compra de medicamentos'),
(15, '2024-01-28', -12, 'Consumo interno'),
(16, '2024-01-29', 18, 'Recepción de nuevo stock'),
(17, '2024-01-30', -8, 'Destrucción de medicamentos caducados'),
(18, '2024-01-31', 22, 'Ajuste de inventario'),
(19, '2024-02-01', -25, 'Venta de productos'),
(20, '2024-02-02', 35, 'Promoción de productos'),
(21, '2024-02-03', -10, 'Devolución de productos');

INSERT INTO Promociones (descripcion, fecha_inicio, fecha_fin, descuento) VALUES
('Descuento del 10% en medicamentos de uso general', '2024-01-01', '2024-01-15', 10.00),
('2x1 en analgésicos', '2024-01-16', '2024-01-31', 50.00),
('Descuento del 15% en vitaminas', '2024-02-01', '2024-02-14', 15.00),
('Promoción de año nuevo: 20% en todos los productos', '2024-02-15', '2024-03-01', 20.00),
('Descuento del 5% en compras superiores a $50', '2024-03-02', '2024-03-15', 5.00),
('Descuento del 30% en productos seleccionados', '2024-03-16', '2024-03-31', 30.00),
('Promoción de primavera: 10% en todos los medicamentos', '2024-04-01', '2024-04-15', 10.00),
('Descuento del 25% en productos para el cuidado de la piel', '2024-04-16', '2024-04-30', 25.00),
('Descuento del 15% en medicamentos recetados', '2024-05-01', '2024-05-15', 15.00),
('Promoción de verano: 2x1 en protector solar', '2024-05-16', '2024-05-31', 50.00),
('Descuento del 20% en productos de salud mental', '2024-06-01', '2024-06-15', 20.00),
('Promoción de mitad de año: 10% en todos los productos', '2024-06-16', '2024-06-30', 10.00),
('Descuento del 15% en medicamentos para enfermedades crónicas', '2024-07-01', '2024-07-15', 15.00),
('2x1 en suplementos deportivos', '2024-07-16', '2024-07-31', 50.00),
('Descuento del 30% en productos para bebés', '2024-08-01', '2024-08-15', 30.00),
('Promoción de regreso a clases: 10% en productos de cuidado personal', '2024-08-16', '2024-08-31', 10.00),
('Descuento del 20% en medicamentos para alergias', '2024-09-01', '2024-09-15', 20.00),
('Promoción de otoño: 15% en todos los productos', '2024-09-16', '2024-09-30', 15.00),
('Descuento del 25% en productos de limpieza', '2024-10-01', '2024-10-15', 25.00),
('Promoción de Halloween: 2x1 en vitaminas', '2024-10-16', '2024-10-31', 50.00);

INSERT INTO Medicamento_Promocion (id_medicamento, id_promocion) VALUES
(2, 1),
(3, 2),
(4, 3),
(5, 4),
(6, 5),
(7, 6),
(8, 7),
(9, 8),
(10, 9),
(11, 10),
(12, 11),
(13, 12),
(14, 13),
(15, 14),
(16, 15),
(17, 16),
(18, 17),
(19, 18),
(20, 19),
(21, 20),
(2, 10),
(3, 15),
(4, 20),
(5, 1),
(6, 7),
(7, 3),
(8, 12),
(9, 5),
(10, 14),
(11, 18);

INSERT INTO Devoluciones (id_venta, fecha, motivo) VALUES
(1, '2024-01-10', 'Producto defectuoso'),
(2, '2024-01-11', 'El cliente cambió de opinión'),
(3, '2024-01-12', 'Producto no coincidente con el pedido'),
(4, '2024-01-13', 'Error en la venta'),
(5, '2024-01-14', 'Falta de piezas en el producto'),
(6, '2024-01-15', 'Producto caducado'),
(7, '2024-01-16', 'No es lo que esperaba'),
(8, '2024-01-17', 'Daño en el embalaje'),
(9, '2024-01-18', 'Recibí el artículo equivocado'),
(10, '2024-01-19', 'Problemas con la calidad'),
(11, '2024-01-20', 'Cancelación de pedido por parte del cliente'),
(12, '2024-01-21', 'El producto llegó tarde'),
(13, '2024-01-22', 'Error en la talla'),
(14, '2024-01-23', 'El producto no cumple con las expectativas'),
(15, '2024-01-24', 'Reembolso solicitado'),
(16, '2024-01-25', 'Producto no funcional'),
(17, '2024-01-26', 'Error en el monto facturado'),
(18, '2024-01-27', 'Insatisfacción con el servicio'),
(19, '2024-01-28', 'Cambio de modelo'),
(20, '2024-01-29', 'Fallo en el producto recibido');

select * from Medicamentos;
select * from Clientes;
select * from Ventas;
select * from Detalle_Venta;
select * from Proveedores;
select * from Categorias;
select * from Medicamento_Categoria;
select * from Recetas;
select * from Receta_Detalle;
select * from Empleados;
select * from Ventas_Empleados;

