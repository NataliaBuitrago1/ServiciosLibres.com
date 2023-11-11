USE serviciosLibres
GO

CREATE TABLE usuario(
	id INT IDENTITY(1,1) NOT NULL,
	email VARCHAR(64) NOT NULL,
	password VARCHAR(256) NOT NULL,
	direccion VARCHAR(128) NOT NULL,
	telefono VARCHAR(32) NOT NULL,
	nonce VARCHAR(32) NOT NULL,
	oauth VARCHAR(256) NOT NULL,
	activo BIT DEFAULT 1,
	CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE tipo_documento(
	id INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(64) NOT NULL,
	CONSTRAINT [PK_tipo_documento] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE cliente(
	id INT IDENTITY(1,1) NOT NULL,
	no_documento VARCHAR(32) NOT NULL,
	nombres VARCHAR(128) NOT NULL,
	apellidos VARCHAR(128) NOT NULL,
	tipo_doc INT NOT NULL,
	activo BIT DEFAULT 1 NOT NULL,
	usuario INT NOT NULL,
	CONSTRAINT [PK_cliente] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE empresa(
	id INT IDENTITY(1,1) NOT NULL,
	nit VARCHAR(32) NOT NULL,
	dv_nit VARCHAR(4) NOT NULL,
	razon_social VARCHAR(64) NOT NULL,
	descripcion VARCHAR(512) NULL,
	activo BIT DEFAULT 1,
	usuario INT NULL,
	CONSTRAINT [PK_empresa] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE tipo_servicio(
	id INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(64) NOT NULL,
	CONSTRAINT [PK_tipo_servicio] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE servicio(
	id INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(64) NOT NULL,
	descripcion VARCHAR(512) NULL,
	precio DECIMAL(32) NOT NULL,
	requisito VARCHAR(128) NULL,
	empresa INT NOT NULL,
	tipo_servicio INT NOT NULL,
	CONSTRAINT [PK_servicio] PRIMARY KEY CLUSTERED(id)
)
GO

CREATE TABLE historial(
	id INT IDENTITY(1,1) NOT NULL,
	usuario INT NOT NULL,
	tipo_servicio INT NOT NULL,
	busqueda VARCHAR(128) NOT NULL,
	activo BIT DEFAULT 1,
	CONSTRAINT [PK_historial] PRIMARY KEY CLUSTERED(id)
)
GO

ALTER TABLE cliente ADD 
	FOREIGN KEY (tipo_doc) REFERENCES tipo_documento(id),
	FOREIGN KEY (usuario) REFERENCES usuario(id)
GO

ALTER TABLE historial ADD 
	FOREIGN KEY (usuario) REFERENCES usuario(id)
GO

ALTER TABLE empresa ADD 
	FOREIGN KEY (usuario) REFERENCES usuario(id)
GO

ALTER TABLE servicio ADD
	FOREIGN KEY (tipo_servicio) REFERENCES tipo_servicio(id),
	FOREIGN KEY (empresa) REFERENCES empresa(id)
GO


INSERT INTO usuario(email, password, nonce, oauth) VALUES(	'prueba@prueba.com', 'askldjasjkldhasjkldhjkld', 11111, 'o')

SELECT id, email, password, nonce FROM usuario WHERE email='prueba@prueba.com'


INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('1234567890', '01', 'Estilos Modernos S.A.', 'Peluquería especializada en cortes modernos y estilizados.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('2345678901', '02', 'MotoMasters Ltda.', 'Taller de motos con especialistas en diferentes marcas y modelos. Servicio rápido y garantizado.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('3456789012', '03', 'Reparación AutoPro S.A.', 'Taller de carros con un equipo de expertos en mecánica automotriz. Usamos tecnología de punta para garantizar la calidad de nuestros servicios.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('4567890123', '04', 'BikeFixers Cía.', 'Taller especializado en la reparación y mantenimiento de bicicletas. Desde montaña hasta carretera, damos soluciones rápidas y eficientes.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('5678901234', '05', 'Belleza Capilar Ltda.', 'Peluquería con tratamientos especializados para cada tipo de cabello. También ofrecemos servicios de coloración y estilismo.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('6789012345', '06', 'MotoRápido S.A.', 'Ofrecemos servicios de reparación de motos de manera rápida y confiable. Nuestros técnicos tienen años de experiencia.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('7890123456', '07', 'CarCare Ltda.', 'Taller de vehículos que se enfoca en la reparación y mantenimiento de carros. Nuestra prioridad es la satisfacción del cliente.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('8901234567', '08', 'CicloTech S.A.', 'Expertos en bicicletas de todo tipo. Desde reparaciones menores hasta reconstrucciones completas, somos tu mejor opción.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('9012345678', '09', 'Shear Elegance Ltda.', 'Peluquería dedicada a ofrecer los mejores estilos y tratamientos capilares. Estamos a la vanguardia de las tendencias.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('0123456789', '10', 'MotoZone S.A.', 'Especializados en reparación y mantenimiento de motocicletas deportivas. Equipo técnico altamente capacitado.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('0987654321', '11', 'AutoReparación Elite Ltda.', 'Somos expertos en vehículos de lujo. Trabajamos con las mejores marcas y ofrecemos un servicio premium.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('1098765432', '12', 'BiciCraft Cía.', 'Taller dedicado a la restauración y personalización de bicicletas antiguas y clásicas. Devuelve la vida a tu vieja bicicleta.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('2109876543', '13', 'Look & Shine Peluquería', 'Especializados en tratamientos de brillo y rejuvenecimiento capilar. Tu cabello lucirá más brillante que nunca.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('3210987654', '14', 'MotoRevive Ltda.', '¿Tienes una moto antigua? Nos especializamos en la restauración y puesta a punto de motocicletas clásicas.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('4321098765', '15', 'TurboCar Reparaciones S.A.', 'Taller especializado en vehículos turbo. Nuestro equipo técnico garantiza un servicio de calidad y rapidez.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('5432109876', '16', 'Wheel & Pedal Cía.', 'Ofrecemos soluciones integrales para ciclistas. Desde el mantenimiento básico hasta la instalación de accesorios de alta gama.');

INSERT INTO tipo_servicio (nombre)
VALUES
    ('Belleza'),
    ('Veterinaria'),
    ('Lavadero de Autos'),
    ('Taller de Bicicletas'),
    ('Taller de Motos'),
    ('Taller de Carros'),
    ('Servicio de Spa'),
    ('Gimnasio')
GO


INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Corte de Dama', 'Corte de cabello para mujeres según las últimas tendencias.', 50000, 'Reserva previa', 1, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Corte de Caballero', 'Estilo y corte masculino adaptado a la preferencia del cliente.', 40000, 'Reserva previa', 5, 1);

-- Talleres de Motos
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Mantenimiento General', 'Revisión y ajuste completo de tu moto.', 150000, 'Solicitar cita', 2, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de Aceite', 'Renovación de aceite y filtro de tu motocicleta.', 90000, 'Sin cita previa', 6, 5);

-- Talleres de Carros
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Alineación y Balaceo', 'Ajuste de la dirección y equilibrio de tus llantas.', 120000, 'Solicitar cita', 3, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Revisión General', 'Chequeo completo del vehículo para garantizar su buen funcionamiento.', 180000, 'Solicitar cita', 7, 6);

-- Talleres de Bicicletas
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Ajuste de Frenos', 'Revisión y ajuste de los frenos para garantizar tu seguridad.', 30000, 'Sin cita previa', 4, 4);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambiar Cámaras', 'Reemplazo de las cámaras de tus ruedas.', 24000, 'Traer la bicicleta', 8, 4);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Personalización', 'Añade detalles y accesorios únicos a tu bicicleta.', 150000, 'Consultar disponibilidad', 12, 4);

-- Insertando para las nuevas empresas y servicios
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Corte y Estilo', 'Transformación completa de tu look.', 56000, 'Reserva previa', 9, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Restauración de Moto', 'Dale una nueva vida a tu moto antigua.', 400000, 'Consultar detalles', 10, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Reparación de Turbo', 'Reparación y ajuste de sistemas turbo de vehículos.', 300000, 'Solicitar cita', 11, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Restauración Bici Clásica', 'Restauración completa de bicicletas clásicas.', 250000, 'Entregar bicicleta', 12, 4);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Tratamiento de Brillo', 'Tratamiento especializado para cabellos opacos.', 70000, 'Reserva previa', 13, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Revisión de Moto Clásica', 'Mantenimiento para motocicletas clásicas.', 165000, 'Traer moto', 14, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Diagnóstico Electrónico', 'Diagnóstico completo con tecnología avanzada.', 210000, 'Solicitar cita', 15, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Instalación de Accesorios', 'Añade accesorios a tu bicicleta.', 50000, 'Consultar modelos', 16, 4);

-- Sumando al total 20 servicios
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de Look Completo', 'Corte, color y tratamiento en un solo paquete.', 200000, 'Reserva previa', 1, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Revisión de Transmisión', 'Chequeo y reparación de la transmisión de tu vehículo.', 250000, 'Solicitar cita', 7, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Ajuste de Suspensión', 'Revisión y ajuste de la suspensión de tu bicicleta.', 36000, 'Sin cita previa', 4, 4);





-- Peluquerías
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Tinte Capilar', 'Cambio de color de cabello con productos de alta calidad.', 130000, 'Reserva previa', 1, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Manicure y Pedicure', 'Servicio de manicure y pedicure con esmaltes duraderos.', 50000, 'Reserva previa', 5, 1);

-- Talleres de Motos
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Reemplazo de llantas', 'Reemplazo de llantas desgastadas o dañadas.', 200000, 'Solicitar cita', 2, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Instalación de accesorios', 'Instalación de diversos accesorios para personalizar tu moto.', 80000, 'Traer la moto', 6, 5);

-- Talleres de Carros
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Lavado de motor', 'Lavado detallado del motor del vehículo.', 70000, 'Solicitar cita', 3, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de batería', 'Reemplazo de batería desgastada o dañada.', 280000, 'Solicitar cita', 7, 6);

-- Talleres de Bicicletas
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de cadena', 'Reemplazo de cadena desgastada o dañada.', 60000, 'Sin cita previa', 4, 4);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Ajuste de cambios', 'Ajuste de los cambios de tu bicicleta.', 45000, 'Traer la bicicleta', 8, 4);

-- Continuación para las empresas adicionales
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Peinados', 'Peinados para eventos y ocasiones especiales.', 80000, 'Reserva previa', 9, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Revisión eléctrica', 'Diagnóstico y reparación del sistema eléctrico de tu moto.', 150000, 'Consultar detalles', 10, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de luces', 'Reemplazo y mejora de las luces de tu vehículo.', 120000, 'Solicitar cita', 11, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Instalación de portaequipajes', 'Instalación de sistemas de portaequipajes y portabicicletas.', 85000, 'Entregar bicicleta', 12, 4);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Tratamiento capilar', 'Tratamientos para mejorar la salud de tu cabello.', 100000, 'Reserva previa', 13, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Afinación', 'Afinación completa para garantizar el buen funcionamiento de tu moto.', 175000, 'Traer moto', 14, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Pintura automotriz', 'Servicio de pintura y acabados para tu vehículo.', 500000, 'Solicitar cita', 15, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de sillín', 'Reemplazo y ajuste de sillines de bicicleta.', 70000, 'Consultar modelos', 16, 4);

-- Servicios adicionales
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Keratina', 'Tratamiento de keratina para alisar y fortalecer el cabello.', 250000, 'Reserva previa', 1, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Revisión de frenos', 'Chequeo y reparación del sistema de frenos de tu vehículo.', 200000, 'Solicitar cita', 7, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Instalación de luces LED', 'Instalación de luces LED para mejorar la visibilidad de tu bicicleta.', 50000, 'Sin cita previa', 4, 4);

-- Completando hasta 30 servicios
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Maquillaje profesional', 'Maquillaje para eventos y ocasiones especiales.', 90000, 'Reserva previa', 9, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de pastillas de freno', 'Reemplazo de pastillas de freno desgastadas o dañadas.', 140000, 'Consultar detalles', 10, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Afinación general', 'Afinación completa para garantizar el rendimiento óptimo de tu vehículo.', 350000, 'Solicitar cita', 11, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Instalación de timbres y campanas', 'Añade un timbre o campana a tu bicicleta.', 15000, 'Entregar bicicleta', 12, 4);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Hidratación capilar', 'Hidratación profunda para revitalizar el cabello seco.', 110000, 'Reserva previa', 13, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de bujías', 'Reemplazo de bujías para mejorar la combustión de tu moto.', 70000, 'Traer moto', 14, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Pulido y encerado', 'Servicio de pulido y encerado para proteger la pintura de tu vehículo.', 220000, 'Solicitar cita', 15, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de pedales', 'Reemplazo y ajuste de pedales de bicicleta.', 45000, 'Consultar modelos', 16, 4);


INSERT INTO tipo_documento (nombre)
VALUES
    ('Cedula de Ciudadania'),
    ('Cedula de Extranjeria'),
    ('Pasaporte')
GO
