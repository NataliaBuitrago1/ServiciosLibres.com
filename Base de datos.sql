------------------------- CHOISETIME -------------------------------
--- CREACI�N, ESTRUCTURA E INSERTS DE BASE DE DATOS

CREATE DATABASE choisetime 
GO

USE choisetime 
GO

--------------------------------------------------------------------
--------------------- ESTRUCTURA TABLAS ----------------------------

CREATE TABLE cliente(
	id INT IDENTITY(1,1) NOT NULL,
	no_documento VARCHAR(32) NOT NULL,
	nombres VARCHAR(128) NOT NULL,
	apellidos VARCHAR(128) NOT NULL,
	email VARCHAR(64) NOT NULL,
	direccion VARCHAR(128) NOT NULL,
	telefono VARCHAR(32) NOT NULL,
	tipo_doc_id INT NOT NULL,
	enable BOOLEAN DEFAULT 1,
	CONSTRAINT [PK_cliente] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE disponibilidad(
	id INT IDENTITY(1,1) NOT NULL,
	jornada VARCHAR(2) NOT NULL,
	inicio TIME NOT NULL,
	fin TIME NOT NULL
	CONSTRAINT [PK_disponibilidad] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE empresa(
	id INT IDENTITY(1,1) NOT NULL,
	nit VARCHAR(32) NOT NULL,
	dv_nit VARCHAR(4) NOT NULL,
	razon_social VARCHAR(64) NOT NULL,
	descripcion VARCHAR(512) NULL,
	email VARCHAR(64) NOT NULL,
	estado_id INT NOT NULL,
	CONSTRAINT [PK_empresa] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE estado_empresa(
	id INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(32) NOT NULL,
	CONSTRAINT [PK_estado_empresa] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE estado_reserva(
	id INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(32) NOT NULL,
	CONSTRAINT [PK_estado_reserva] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE medio_pago(
	id INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(32) NOT NULL,
	CONSTRAINT [PK_medio_pago] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE pago(
	id INT IDENTITY(1,1) NOT NULL,
	valor DECIMAL(32) NOT NULL,
	fecha_pago DATETIME NOT NULL,
	mediopago_id INT NOT NULL,
	CONSTRAINT [PK_pago] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE pago_reserva(
	pago_id INT NOT NULL,
	reserva_id INT NOT NULL,
	CONSTRAINT [PK_pago_reserva] PRIMARY KEY CLUSTERED(pago_id, reserva_id)
)
GO

CREATE TABLE reserva(
	id INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(64) NOT NULL,
	fecha_realizacion DATE NOT NULL,
	fecha_registro DATETIME NOT NULL,
	cliente_id INT NOT NULL,
	estado_id INT NOT NULL,
	CONSTRAINT [PK_reserva] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE servicio(
	id INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(64) NOT NULL,
	descripcion VARCHAR(512) NULL,
	precio DECIMAL(32) NOT NULL,
	requisito VARCHAR(128) NULL,
	empresa_id INT NOT NULL,
	tipo_servicio_id INT NOT NULL,
	disponibilidad_id INT NOT NULL,
	CONSTRAINT [PK_servicio] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE servicio_reserva(
	servicio_id INT NOT NULL,
	reserva_id INT NOT NULL,
	CONSTRAINT [PK_servicio_reserva] PRIMARY KEY CLUSTERED(servicio_id, reserva_id)
)
GO

CREATE TABLE tipo_documento(
	id INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(64) NOT NULL,
	CONSTRAINT [PK_tipo_documento] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE tipo_servicio(
	id INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(64) NOT NULL,
	CONSTRAINT [PK_tipo_servicio] PRIMARY KEY CLUSTERED(id)
)
GO

--------------------------------------------------------------------
----------------------- LLAVES FOR�NEAS ----------------------------

ALTER TABLE cliente
	ADD FOREIGN KEY (tipo_doc_id) REFERENCES tipo_documento(id)
GO

ALTER TABLE empresa
	ADD FOREIGN KEY (estado_id) REFERENCES estado_empresa(id)
GO

ALTER TABLE pago
	ADD FOREIGN KEY (mediopago_id) REFERENCES medio_pago(id)
GO

ALTER TABLE pago_reserva
	ADD FOREIGN KEY (pago_id) REFERENCES pago(id),
		FOREIGN KEY (reserva_id) REFERENCES reserva(id)
GO

ALTER TABLE reserva
	ADD FOREIGN KEY (cliente_id) REFERENCES cliente(id),
		FOREIGN KEY (estado_id) REFERENCES estado_reserva(id)
GO

ALTER TABLE servicio
	ADD FOREIGN KEY (tipo_servicio_id) REFERENCES tipo_servicio(id),
		FOREIGN KEY (disponibilidad_id) REFERENCES disponibilidad(id),
		FOREIGN KEY (empresa_id) REFERENCES empresa(id)
GO

ALTER TABLE servicio_reserva
	ADD FOREIGN KEY (servicio_id) REFERENCES servicio(id),
		FOREIGN KEY (reserva_id) REFERENCES reserva(id)
GO

/*ALTER TABLE disponibilidad
      NOCHECK CONSTRAINT ALL;
GO

ALTER TABLE cliente
    CHECK CONSTRAINT ALL;
GO*/

--------------------------------------------------------------------
--------------------------- INSERTS --------------------------------

INSERT INTO tipo_documento (nombre)
VALUES
    ('C�dula de Ciudadan�a'),
    ('C�dula de Extranjer�a'),
    ('Pasaporte')
GO

INSERT INTO estado_empresa (nombre)
VALUES
    ('Activa'),
    ('Inactiva'),
    ('Suspendida'),
    ('En tr�mite')
GO

INSERT INTO estado_reserva (nombre)
VALUES
    ('Pendiente'),
    ('Confirmada'),
    ('Cancelada'),
    ('En proceso'),
    ('Completada'),
    ('No asistida'),
    ('Reprogramada'),
    ('En espera')
GO

INSERT INTO medio_pago (nombre)
VALUES
    ('Efectivo'),
    ('Tarjeta'),
    ('PSE')
GO

INSERT INTO tipo_servicio (nombre)
VALUES
    ('Peluquer�a'),
    ('Barber�a'),
    ('Veterinaria'),
    ('Lavadero de Autos'),
    ('Cancha de F�tbol'),
    ('Taller de Bicicletas'),
    ('Servicio de Spa'),
    ('Sal�n de Belleza'),
    ('Gimnasio'),
    ('Reparaci�n de Electrodom�sticos')
GO

INSERT INTO cliente (no_documento, nombres, apellidos, email, direccion, telefono, tipo_doc_id)
VALUES
    ('1234567890', 'Juan', 'P�rez', 'juan@example.com', 'Calle 123', '3206571927', 1),
    ('9876543210', 'Ana', 'G�mez', 'ana@example.com', 'Avenida 456', '3120918478', 1),
    ('2345678901', 'Pedro', 'L�pez', 'pedro@example.com', 'Carrera 789', '3015938471', 1),
    ('3456789012', 'Mar�a', 'Rodr�guez', 'maria@example.com', 'Calle 567', '3038672013', 3),
    ('4567890123', 'Luis', 'Gonz�lez', 'luis@example.com', 'Avenida 901', '3179283794', 1),
    ('5678901234', 'Laura', 'Mart�nez', 'laura@example.com', 'Carrera 123', '3180638273', 1),
    ('6789012345', 'Sof�a', 'Hern�ndez', 'sofia@example.com', 'Calle 234', '3158394726', 2),
    ('7890123456', 'Carlos', 'D�az', 'carlos@example.com', 'Avenida 345', '3168273610', 1),
    ('8901234567', 'Paola', 'Chac�n', 'paola@example.com', 'Carrera 456', '3101011010', 1),
    ('9012345678', 'Andr�s', 'Ram�rez', 'andres@example.com', 'Calle 678', '3210489585', 2)
GO

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion, email, estado_id)
VALUES
    ('900123456', '1', 'Peluquer�a BellaCorte', 'Sal�n de belleza especializado en cortes de cabello para hombres y mujeres.', 'bellacorte@example.com', 1),
    ('800987654', '2', 'Veterinaria Amigo Fiel', 'Cl�nica veterinaria dedicada al cuidado de mascotas y animales dom�sticos.', 'amigofiel@example.com', 1),
    ('700234567', '3', 'Lavadero de Autos LimpioAuto', 'Servicio de lavado de autos a mano con atenci�n personalizada.', 'limpioauto@example.com', 2),
    ('600345678', '4', 'Canchas de F�tbol F�tbolCity', 'Complejo de canchas de f�tbol con iluminaci�n y c�sped artificial.', 'futbolcity@example.com', 1),
    ('500456789', '5', 'Taller de Bicicletas BikeFix', 'Reparaci�n y mantenimiento de bicicletas de todas las marcas.', 'bikefix@example.com', 1),
    ('400567890', '6', 'Spa Tranquilidad Total', 'Centro de spa con masajes relajantes y tratamientos de belleza.', 'tranquilidadtotal@example.com', 1),
    ('300678901', '7', 'Sal�n de Belleza Elegancia', 'Servicios de belleza y estilismo para hombres y mujeres.', 'elegancia@example.com', 2),
    ('200789012', '8', 'Gimnasio FitnessLife', 'Gimnasio con entrenadores profesionales y equipos de �ltima generaci�n.', 'fitnesslife@example.com', 3),
    ('100890123', '9', 'Talleres Electromaq', 'Reparaci�n de electrodom�sticos a domicilio con garant�a de calidad.', 'electromaq@example.com', 1),
    ('001901234', '0', 'Centro Deportivo ActivaSport', 'Centro deportivo con actividades para todas las edades y niveles de condici�n f�sica.', 'activasport@example.com', 4)
GO

INSERT INTO disponibilidad (jornada, inicio, fin)
VALUES
    ('AM', '08:00:00', '09:00:00'),
    ('AM', '10:00:00', '10:30:00'),
    ('AM', '10:30:00', '11:00:00'),
    ('AM', '07:00:00', '09:00:00'),
	('PM', '13:00:00', '14:00:00'),
    ('PM', '14:00:00', '14:30:00'),
    ('PM', '16:30:00', '17:30:00'),
    ('PM', '19:00:00', '20:00:00')
GO

INSERT INTO reserva (nombre, fecha_realizacion, fecha_registro, cliente_id, estado_id)
VALUES
    ('Corte cabello', '2023-09-10', GETDATE(), 1, 2),
    ('Mantenimiento bicicleta', '2023-09-12', GETDATE(), 2, 1),
    ('Manicure', '2023-09-11', GETDATE(), 3, 2),
    ('Lavado auto', '2023-09-09', GETDATE(), 4, 1),
    ('Cancha sint�tica', '2023-09-08', GETDATE(), 5, 2),
    ('Mantenimiento auto', '2023-09-10', GETDATE(), 6, 1),
    ('Cita veterinaria', '2023-09-11', GETDATE(), 7, 2),
    ('Sesi�n pilates', '2023-09-09', GETDATE(), 8, 1),
    ('Masaje', '2023-09-08', GETDATE(), 9, 2),
    ('Mantenimiento licuadora', '2023-09-12', GETDATE(), 10, 1)
GO

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa_id, tipo_servicio_id, disponibilidad_id)
VALUES
    ('Corte de cabello', 'Corte de cabello para hombres', 15.00, 'Sin requisitos adicionales', 1, 1, 1),
    ('Manicura', 'Servicio de manicura b�sica', 20.00, 'Sin requisitos adicionales', 7, 8, 2),
    ('Consulta veterinaria', 'Consulta para mascotas', 30.00, 'Cita previa requerida', 2, 3, 3),
    ('Lavado de autos', 'Lavado exterior e interior', 25.00, 'Sin requisitos adicionales', 3, 4, 4),
    ('Reserva de cancha de f�tbol', 'Cancha de f�tbol para 5 jugadores', 50.00, 'Pago por adelantado', 4, 5, 5),
    ('Reparaci�n de bicicletas', 'Reparaci�n de bicicletas de cualquier marca', 40.00, 'Requiere diagn�stico previo', 5, 6, 6),
    ('Masaje relajante', 'Masaje de cuerpo completo', 45.00, 'Reserva con anticipaci�n', 6, 7, 7),
    ('Corte de cabello y peinado', 'Servicio completo de belleza capilar', 30.00, 'Reserva con anticipaci�n', 1, 1, 8),
    ('Clases de yoga', 'Clases de yoga para principiantes', 20.00, 'Traer su propia esterilla', 10, 9, 1),
    ('Reparaci�n de electrodom�sticos', 'Reparaci�n de electrodom�sticos a domicilio', 60.00, 'Revisi�n inicial sin costo', 9, 10, 6)
GO

INSERT INTO servicio_reserva (servicio_id, reserva_id)
VALUES
	(1, 1),
	(2, 3),
	(3, 7),
	(4, 4), 
	(5, 5),
	(6, 2),
	(7, 9),
	(8, 1),
	(9, 8),
	(10, 10);