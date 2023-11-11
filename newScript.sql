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
VALUES ('1234567890', '01', 'Estilos Modernos S.A.', 'Peluquer�a especializada en cortes modernos y estilizados.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('2345678901', '02', 'MotoMasters Ltda.', 'Taller de motos con especialistas en diferentes marcas y modelos. Servicio r�pido y garantizado.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('3456789012', '03', 'Reparaci�n AutoPro S.A.', 'Taller de carros con un equipo de expertos en mec�nica automotriz. Usamos tecnolog�a de punta para garantizar la calidad de nuestros servicios.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('4567890123', '04', 'BikeFixers C�a.', 'Taller especializado en la reparaci�n y mantenimiento de bicicletas. Desde monta�a hasta carretera, damos soluciones r�pidas y eficientes.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('5678901234', '05', 'Belleza Capilar Ltda.', 'Peluquer�a con tratamientos especializados para cada tipo de cabello. Tambi�n ofrecemos servicios de coloraci�n y estilismo.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('6789012345', '06', 'MotoR�pido S.A.', 'Ofrecemos servicios de reparaci�n de motos de manera r�pida y confiable. Nuestros t�cnicos tienen a�os de experiencia.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('7890123456', '07', 'CarCare Ltda.', 'Taller de veh�culos que se enfoca en la reparaci�n y mantenimiento de carros. Nuestra prioridad es la satisfacci�n del cliente.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('8901234567', '08', 'CicloTech S.A.', 'Expertos en bicicletas de todo tipo. Desde reparaciones menores hasta reconstrucciones completas, somos tu mejor opci�n.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('9012345678', '09', 'Shear Elegance Ltda.', 'Peluquer�a dedicada a ofrecer los mejores estilos y tratamientos capilares. Estamos a la vanguardia de las tendencias.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('0123456789', '10', 'MotoZone S.A.', 'Especializados en reparaci�n y mantenimiento de motocicletas deportivas. Equipo t�cnico altamente capacitado.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('0987654321', '11', 'AutoReparaci�n Elite Ltda.', 'Somos expertos en veh�culos de lujo. Trabajamos con las mejores marcas y ofrecemos un servicio premium.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('1098765432', '12', 'BiciCraft C�a.', 'Taller dedicado a la restauraci�n y personalizaci�n de bicicletas antiguas y cl�sicas. Devuelve la vida a tu vieja bicicleta.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('2109876543', '13', 'Look & Shine Peluquer�a', 'Especializados en tratamientos de brillo y rejuvenecimiento capilar. Tu cabello lucir� m�s brillante que nunca.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('3210987654', '14', 'MotoRevive Ltda.', '�Tienes una moto antigua? Nos especializamos en la restauraci�n y puesta a punto de motocicletas cl�sicas.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('4321098765', '15', 'TurboCar Reparaciones S.A.', 'Taller especializado en veh�culos turbo. Nuestro equipo t�cnico garantiza un servicio de calidad y rapidez.');

INSERT INTO empresa (nit, dv_nit, razon_social, descripcion)
VALUES ('5432109876', '16', 'Wheel & Pedal C�a.', 'Ofrecemos soluciones integrales para ciclistas. Desde el mantenimiento b�sico hasta la instalaci�n de accesorios de alta gama.');

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
VALUES ('Corte de Dama', 'Corte de cabello para mujeres seg�n las �ltimas tendencias.', 50000, 'Reserva previa', 1, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Corte de Caballero', 'Estilo y corte masculino adaptado a la preferencia del cliente.', 40000, 'Reserva previa', 5, 1);

-- Talleres de Motos
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Mantenimiento General', 'Revisi�n y ajuste completo de tu moto.', 150000, 'Solicitar cita', 2, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de Aceite', 'Renovaci�n de aceite y filtro de tu motocicleta.', 90000, 'Sin cita previa', 6, 5);

-- Talleres de Carros
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Alineaci�n y Balaceo', 'Ajuste de la direcci�n y equilibrio de tus llantas.', 120000, 'Solicitar cita', 3, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Revisi�n General', 'Chequeo completo del veh�culo para garantizar su buen funcionamiento.', 180000, 'Solicitar cita', 7, 6);

-- Talleres de Bicicletas
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Ajuste de Frenos', 'Revisi�n y ajuste de los frenos para garantizar tu seguridad.', 30000, 'Sin cita previa', 4, 4);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambiar C�maras', 'Reemplazo de las c�maras de tus ruedas.', 24000, 'Traer la bicicleta', 8, 4);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Personalizaci�n', 'A�ade detalles y accesorios �nicos a tu bicicleta.', 150000, 'Consultar disponibilidad', 12, 4);

-- Insertando para las nuevas empresas y servicios
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Corte y Estilo', 'Transformaci�n completa de tu look.', 56000, 'Reserva previa', 9, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Restauraci�n de Moto', 'Dale una nueva vida a tu moto antigua.', 400000, 'Consultar detalles', 10, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Reparaci�n de Turbo', 'Reparaci�n y ajuste de sistemas turbo de veh�culos.', 300000, 'Solicitar cita', 11, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Restauraci�n Bici Cl�sica', 'Restauraci�n completa de bicicletas cl�sicas.', 250000, 'Entregar bicicleta', 12, 4);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Tratamiento de Brillo', 'Tratamiento especializado para cabellos opacos.', 70000, 'Reserva previa', 13, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Revisi�n de Moto Cl�sica', 'Mantenimiento para motocicletas cl�sicas.', 165000, 'Traer moto', 14, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Diagn�stico Electr�nico', 'Diagn�stico completo con tecnolog�a avanzada.', 210000, 'Solicitar cita', 15, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Instalaci�n de Accesorios', 'A�ade accesorios a tu bicicleta.', 50000, 'Consultar modelos', 16, 4);

-- Sumando al total 20 servicios
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de Look Completo', 'Corte, color y tratamiento en un solo paquete.', 200000, 'Reserva previa', 1, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Revisi�n de Transmisi�n', 'Chequeo y reparaci�n de la transmisi�n de tu veh�culo.', 250000, 'Solicitar cita', 7, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Ajuste de Suspensi�n', 'Revisi�n y ajuste de la suspensi�n de tu bicicleta.', 36000, 'Sin cita previa', 4, 4);





-- Peluquer�as
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Tinte Capilar', 'Cambio de color de cabello con productos de alta calidad.', 130000, 'Reserva previa', 1, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Manicure y Pedicure', 'Servicio de manicure y pedicure con esmaltes duraderos.', 50000, 'Reserva previa', 5, 1);

-- Talleres de Motos
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Reemplazo de llantas', 'Reemplazo de llantas desgastadas o da�adas.', 200000, 'Solicitar cita', 2, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Instalaci�n de accesorios', 'Instalaci�n de diversos accesorios para personalizar tu moto.', 80000, 'Traer la moto', 6, 5);

-- Talleres de Carros
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Lavado de motor', 'Lavado detallado del motor del veh�culo.', 70000, 'Solicitar cita', 3, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de bater�a', 'Reemplazo de bater�a desgastada o da�ada.', 280000, 'Solicitar cita', 7, 6);

-- Talleres de Bicicletas
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de cadena', 'Reemplazo de cadena desgastada o da�ada.', 60000, 'Sin cita previa', 4, 4);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Ajuste de cambios', 'Ajuste de los cambios de tu bicicleta.', 45000, 'Traer la bicicleta', 8, 4);

-- Continuaci�n para las empresas adicionales
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Peinados', 'Peinados para eventos y ocasiones especiales.', 80000, 'Reserva previa', 9, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Revisi�n el�ctrica', 'Diagn�stico y reparaci�n del sistema el�ctrico de tu moto.', 150000, 'Consultar detalles', 10, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de luces', 'Reemplazo y mejora de las luces de tu veh�culo.', 120000, 'Solicitar cita', 11, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Instalaci�n de portaequipajes', 'Instalaci�n de sistemas de portaequipajes y portabicicletas.', 85000, 'Entregar bicicleta', 12, 4);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Tratamiento capilar', 'Tratamientos para mejorar la salud de tu cabello.', 100000, 'Reserva previa', 13, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Afinaci�n', 'Afinaci�n completa para garantizar el buen funcionamiento de tu moto.', 175000, 'Traer moto', 14, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Pintura automotriz', 'Servicio de pintura y acabados para tu veh�culo.', 500000, 'Solicitar cita', 15, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de sill�n', 'Reemplazo y ajuste de sillines de bicicleta.', 70000, 'Consultar modelos', 16, 4);

-- Servicios adicionales
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Keratina', 'Tratamiento de keratina para alisar y fortalecer el cabello.', 250000, 'Reserva previa', 1, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Revisi�n de frenos', 'Chequeo y reparaci�n del sistema de frenos de tu veh�culo.', 200000, 'Solicitar cita', 7, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Instalaci�n de luces LED', 'Instalaci�n de luces LED para mejorar la visibilidad de tu bicicleta.', 50000, 'Sin cita previa', 4, 4);

-- Completando hasta 30 servicios
INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Maquillaje profesional', 'Maquillaje para eventos y ocasiones especiales.', 90000, 'Reserva previa', 9, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de pastillas de freno', 'Reemplazo de pastillas de freno desgastadas o da�adas.', 140000, 'Consultar detalles', 10, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Afinaci�n general', 'Afinaci�n completa para garantizar el rendimiento �ptimo de tu veh�culo.', 350000, 'Solicitar cita', 11, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Instalaci�n de timbres y campanas', 'A�ade un timbre o campana a tu bicicleta.', 15000, 'Entregar bicicleta', 12, 4);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Hidrataci�n capilar', 'Hidrataci�n profunda para revitalizar el cabello seco.', 110000, 'Reserva previa', 13, 1);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de buj�as', 'Reemplazo de buj�as para mejorar la combusti�n de tu moto.', 70000, 'Traer moto', 14, 5);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Pulido y encerado', 'Servicio de pulido y encerado para proteger la pintura de tu veh�culo.', 220000, 'Solicitar cita', 15, 6);

INSERT INTO servicio (nombre, descripcion, precio, requisito, empresa, tipo_servicio)
VALUES ('Cambio de pedales', 'Reemplazo y ajuste de pedales de bicicleta.', 45000, 'Consultar modelos', 16, 4);


INSERT INTO tipo_documento (nombre)
VALUES
    ('Cedula de Ciudadania'),
    ('Cedula de Extranjeria'),
    ('Pasaporte')
GO
