drop database if exists biblioteca;
create database biblioteca;

use biblioteca;

create table Roles(
	id_rol int not null auto_increment,
    nombre_rol varchar(50) unique not null,
    primary key (id_rol),
    check (nombre_rol in ('administrador', 'bibliotecario', 'lector'))
);

create table Usuarios(
	id_usuario int not null auto_increment,
    nombre varchar(50) not null,
    primer_apellido varchar(50) not null,
    segundo_apellido varchar(50),
    email varchar(50) unique not null,
    telefono varchar(20),
    fecha_nacimiento date,
    fecha_registro date default (current_date()),
    contrasena varchar(255) not null,
    id_rol int,
    primary key (id_usuario),
    foreign key (id_rol) references Roles(id_rol) on delete cascade
);

create table Libros(
	id_libro int not null auto_increment,
    ISBN varchar(20) unique,
    titulo varchar(255) not null,
    anio_publicacion int,
    editorial varchar(100),
    edicion int,
    cantidad_total int not null,
    cantidad_disponible int not null,
    clasificacion int,
    primary key (id_libro),
    check (cantidad_total >= 0),
    check (cantidad_disponible >= 0 and cantidad_disponible <= cantidad_total),
    check (clasificacion >= 0 and clasificacion <= 5)
);

create table Autores(
	id_autor int not null auto_increment,
    nombre_autor varchar(50) not null,
    apellido_paterno varchar(50),
    apellido_materno varchar(50),
    primary key (id_autor)
);

create table LibroAutor(
	id_libro int not null,
    id_autor int not null,
    foreign key (id_libro) references Libros(id_libro) on delete cascade,
	foreign key (id_autor) references Autores(id_autor) on delete cascade
);

create table Prestamos(
	id_prestamo int not null auto_increment,
    id_usuario int,
    id_libro int,
    fecha_prestamo date not null,
    fecha_devolucion_max date,
    estado_prestamo enum('pendiente', 'devuelto', 'con retraso'),
    primary key (id_prestamo),
    foreign key (id_usuario) references Usuarios(id_usuario) on delete cascade,
    foreign key (id_libro) references Libros(id_libro) on delete cascade
);

create table Devoluciones(
	id_devolucion int not null auto_increment,
    id_prestamo int,
    fecha_devolucion date not null,
    primary key (id_devolucion),
    foreign key (id_prestamo) references Prestamos(id_prestamo) on delete cascade
);

create table Multas(
	id_multa int not null auto_increment,
    id_prestamo int,
    monto decimal(10,2),
    pagado boolean default ('False'),
    fecha_multa date default (current_date()),
    primary key (id_multa),
    foreign key (id_prestamo) references Prestamos(id_prestamo) on delete cascade
);

alter table Roles drop check roles_chk_1;

alter table Roles add constraint check (nombre_rol IN (('administradores'),('bibliotecarios'),('lectores')));

INSERT INTO ROLES(nombre_rol) VALUES('administradores'),('bibliotecarios'),('lectores');

-- Insertar 50 Usuarios Lectores, algunos con dos nombres
INSERT INTO Usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, id_rol, contrasena)
VALUES
('Alejandro', 'Martínez', 'Vega', 'alejandro.martinez@example.com', '5551239876', '1991-08-13', 3, 'PassAlejandro123'),
('Valeria', 'Reyes', 'Soto', 'valeria.reyes@example.com', '5556782345', '1990-09-18', 3, 'PassValeria123'),
('Santiago', 'Ramos', 'Ortega', 'santiago.ramos@example.com', '5554567890', '1988-11-23', 3, 'PassSantiago123'),
('Lucía', 'Morales', 'Jiménez', 'lucia.morales@example.com', '5551234567', '1995-05-06', 3, 'PassLucia123'),
('Fernando', 'Vázquez', 'Pérez', 'fernando.vazquez@example.com', '5559871234', '1994-02-17', 3, 'PassFernando123'),
('Emilia', 'Castro', 'Rivera', 'emilia.castro@example.com', '5551122334', '1992-07-25', 3, 'PassEmilia123'),
('Jorge Luis', 'Méndez', 'Flores', 'jorge.mendez@example.com', '5552233445', '1989-03-12', 3, 'PassJorge123'),
('Camila', 'Gutiérrez', 'Sánchez', 'camila.gutierrez@example.com', '5555544332', '1993-09-21', 3, 'PassCamila123'),
('Daniel', 'Cruz', 'Martínez', 'daniel.cruz@example.com', '5556677889', '1997-10-28', 3, 'PassDaniel123'),
('Ana Sofía', 'Hernández', 'Gómez', 'ana.hernandez@example.com', '5558899000', '1985-12-15', 3, 'PassAnaSofia123'),
('Roberto', 'López', 'Romero', 'roberto.lopez@example.com', '5551122777', '1986-01-05', 3, 'PassRoberto123'),
('Elena', 'Díaz', 'Moreno', 'elena.diaz@example.com', '5553344556', '1996-06-07', 3, 'PassElena123'),
('Juan Manuel', 'García', 'Torres', 'juan.garcia@example.com', '5557788990', '1990-08-22', 3, 'PassJuanM123'),
('Marcela', 'Rojas', 'Pacheco', 'marcela.rojas@example.com', '5559988776', '1995-02-09', 3, 'PassMarcela123'),
('Sebastián', 'Ortiz', 'Martínez', 'sebastian.ortiz@example.com', '5554433221', '1993-11-01', 3, 'PassSebastian123'),
('Andrea', 'Mendoza', 'Aguirre', 'andrea.mendoza@example.com', '5556655447', '1998-05-30', 3, 'PassAndrea123'),
('José Luis', 'Ramírez', 'Morales', 'jose.ramirez@example.com', '5557766554', '1989-04-11', 3, 'PassJoseLuis123'),
('Paula', 'Fuentes', 'Guzmán', 'paula.fuentes@example.com', '5553344221', '1991-12-14', 3, 'PassPaula123'),
('Carlos', 'Martínez', 'Ríos', 'carlos.martinez@example.com', '5554455667', '1988-03-19', 3, 'PassCarlos123'),
('Mónica', 'Román', 'Pérez', 'monica.roman@example.com', '5556677889', '1994-07-23', 3, 'PassMonica123'),
('Francisco', 'Navarro', 'García', 'francisco.navarro@example.com', '5557766553', '1993-01-10', 3, 'PassFrancisco123'),
('Mariana', 'Luna', 'Muñoz', 'mariana.luna@example.com', '5556677888', '1992-11-18', 3, 'PassMariana123'),
('Raúl', 'Domínguez', 'Vargas', 'raul.dominguez@example.com', '5553344223', '1987-06-27', 3, 'PassRaul123'),
('Lorena', 'Rivas', 'Serrano', 'lorena.rivas@example.com', '5556677884', '1995-08-09', 3, 'PassLorena123'),
('David', 'Estrada', 'Mejía', 'david.estrada@example.com', '5554455669', '1990-02-26', 3, 'PassDavid123'),
('Adriana', 'Moreno', 'Castillo', 'adriana.moreno@example.com', '5551239876', '1991-09-13', 3, 'PassAdriana123'),
('Gustavo', 'Villanueva', 'Ruiz', 'gustavo.villanueva@example.com', '5559988771', '1985-07-18', 3, 'PassGustavo123'),
('Daniela', 'Palacios', 'Cabrera', 'daniela.palacios@example.com', '5556677887', '1994-03-04', 3, 'PassDaniela123'),
('José Carlos', 'Vega', 'Padilla', 'jose.vega@example.com', '5557788991', '1993-06-15', 3, 'PassJoseC123'),
('Margarita', 'Peña', 'Hernández', 'margarita.pena@example.com', '5551234432', '1990-09-28', 3, 'PassMargarita123'),
('Enrique', 'Robles', 'Ponce', 'enrique.robles@example.com', '5557766559', '1986-05-12', 3, 'PassEnrique123'),
('Cristina', 'Salazar', 'Méndez', 'cristina.salazar@example.com', '5554455664', '1992-12-07', 3, 'PassCristina123'),
('Javier', 'Gómez', 'Ortiz', 'javier.gomez@example.com', '5552233441', '1995-08-22', 3, 'PassJavier123'),
('Laura', 'Gutiérrez', 'Rodríguez', 'laura.gutierrez@example.com', '5556655443', '1993-04-08', 3, 'PassLaura123'),
('Oscar', 'Martínez', 'Santos', 'oscar.martinez@example.com', '5551122333', '1990-10-17', 3, 'PassOscar123'),
('Silvia', 'Delgado', 'Cordero', 'silvia.delgado@example.com', '5553344559', '1996-02-20', 3, 'PassSilvia123'),
('Ángel', 'Valencia', 'Campos', 'angel.valencia@example.com', '5554433228', '1994-09-05', 3, 'PassAngel123'),
('Natalia', 'Bravo', 'López', 'natalia.bravo@example.com', '5557788997', '1987-12-11', 3, 'PassNatalia123'),
('Iván', 'León', 'Serrano', 'ivan.leon@example.com', '5551122771', '1988-06-03', 3, 'PassIvan123'),
('Verónica', 'Cruz', 'Espinoza', 'veronica.cruz@example.com', '5559988778', '1991-03-24', 3, 'PassVeronica123'),
('Luis Felipe', 'Martínez', 'Coronado', 'luis.martinez@example.com', '5556677882', '1992-01-31', 3, 'PassLuisF123'),
('Esteban', 'Zamora', 'Reyes', 'esteban.zamora@example.com', '5551122332', '1997-08-16', 3, 'PassEsteban123'),
('Alejandra', 'Romero', 'Paredes', 'alejandra.romero@example.com', '5552233442', '1993-05-22', 3, 'PassAlejandra123'),
('Ramiro', 'Herrera', 'Alonso', 'ramiro.herrera@example.com', '5554433225', '1989-07-30', 3, 'PassRamiro123'),
('Lorena', 'Padilla', 'Soto', 'lorena.padilla@example.com', '5557788994', '1986-04-19', 3, 'PassLorena123'),
('Salvador', 'Benítez', 'Flores', 'salvador.benitez@example.com', '5559988779', '1985-11-13', 3, 'PassSalvador123'),
('Karla', 'Castillo', 'Arias', 'karla.castillo@example.com', '5551122773', '1995-02-07', 3, 'PassKarla123'),
('Fabián', 'Santos', 'Moreno', 'fabian.santos@example.com', '5556677886', '1991-06-19', 3, 'PassFabian123'),
('Rosario', 'Espinosa', 'Gómez', 'rosario.espinosa@example.com', '5554455665', '1994-09-02', 3, 'PassRosario123'),
('Diego', 'Pérez', 'López', 'diego.perez@example.com', '5557788992', '1990-03-18', 3, 'PassDiego123');


-- Insertar 3 Administradores
INSERT INTO Usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, id_rol, contrasena)
VALUES
('Juan', 'Pérez', 'López', 'juan.perez@biblioteca.com', '5551234567', '1980-03-15', 1, 'adminJuan123'),
('Ana', 'Ramírez', 'Gómez', 'ana.ramirez@biblioteca.com', '5552345678', '1978-09-25', 1, 'adminAna123'),
('Luis', 'Martínez', 'Jiménez', 'luis.martinez@biblioteca.com', '5553456789', '1985-01-10', 1, 'adminLuis123');

-- Insertar 6 Bibliotecarios
INSERT INTO Usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, id_rol, contrasena)
VALUES
('María', 'Sánchez', 'Rivas', 'maria.sanchez@biblioteca.com', '5551237890', '1990-07-20', 2, 'biblioMaria123'),
('Roberto', 'Fernández', 'Vargas', 'roberto.fernandez@biblioteca.com', '5559876543', '1983-05-30', 2, 'biblioRoberto123'),
('Carla', 'Gutiérrez', 'Hernández', 'carla.gutierrez@biblioteca.com', '5557654321', '1992-11-05', 2, 'biblioCarla123'),
('Sofía', 'Díaz', 'Moreno', 'sofia.diaz@biblioteca.com', '5556543210', '1988-02-28', 2, 'biblioSofia123'),
('Daniel', 'Mora', 'García', 'daniel.mora@biblioteca.com', '5555432109', '1975-08-14', 2, 'biblioDaniel123'),
('Patricia', 'Ruiz', 'Soto', 'patricia.ruiz@biblioteca.com', '5554321098', '1995-03-22', 2, 'biblioPatricia123');

-- Insertar 50 libros en la tabla Libros con datos realistas
INSERT INTO Libros (isbn, titulo, anio_publicacion, editorial, edicion, cantidad_total, cantidad_disponible, clasificacion)
VALUES
('978-3-16-148410-0', 'Cien Años de Soledad', 1967, 'Sudamericana', 1, 10, 7, 5),
('978-84-376-0494-7', 'Don Quijote de la Mancha', 1605, 'Francisco de Robles', 2, 8, 5, 5),
('978-0-452-28423-4', '1984', 1949, 'Secker & Warburg', 1, 12, 10, 5),
('978-0-7432-7356-5', 'Fahrenheit 451', 1953, 'Ballantine Books', 1, 6, 4, 4),
('978-0-19-953556-9', 'Orgullo y Prejuicio', 1813, 'T. Egerton', 3, 15, 12, 5),
('978-0-06-112008-4', 'Matar a un Ruiseñor', 1960, 'J.B. Lippincott & Co.', 1, 10, 9, 5),
('978-1-85715-091-6', 'Crimen y Castigo', 1866, 'The Russian Messenger', 2, 8, 6, 5),
('978-0-15-601219-5', 'El Principito', 1943, 'Reynal & Hitchcock', 1, 20, 16, 5),
('978-0-14-143955-6', 'Cumbres Borrascosas', 1847, 'Thomas Cautley Newby', 1, 5, 3, 4),
('978-0-375-72472-6', 'El Gran Gatsby', 1925, 'Charles Scribner''s Sons', 1, 7, 6, 5),
('978-0-679-72841-5', 'Rayuela', 1963, 'Sudamericana', 1, 10, 8, 5),
('978-0-7432-7358-9', 'El Guardián Entre el Centeno', 1951, 'Little, Brown and Company', 1, 9, 7, 5),
('978-0-618-00221-3', 'El Señor de los Anillos: La Comunidad del Anillo', 1954, 'George Allen & Unwin', 1, 12, 10, 5),
('978-0-00-715846-1', 'El Hobbit', 1937, 'George Allen & Unwin', 2, 14, 12, 5),
('978-0-439-02348-1', 'Harry Potter y la Piedra Filosofal', 1997, 'Bloomsbury', 1, 20, 15, 5),
('978-0-06-093546-7', 'El Alquimista', 1988, 'Rocco', 1, 18, 14, 4),
('978-1-5011-5217-2', 'Los Juegos del Hambre', 2008, 'Scholastic Press', 1, 15, 10, 5),
('978-0-7432-7357-2', 'Crónicas de Narnia', 1950, 'Geoffrey Bles', 1, 10, 8, 5),
('978-1-4516-7321-1', 'El Código Da Vinci', 2003, 'Doubleday', 1, 20, 18, 4),
('978-0-553-21311-7', 'El Padrino', 1969, 'G.P. Putnam''s Sons', 1, 15, 12, 5),
('978-0-19-926717-3', 'El Perfume', 1985, 'Taschen', 1, 10, 7, 4),
('978-0-525-47462-5', 'La Divina Comedia', 1320, 'Aldine Press', 1, 8, 6, 5),
('978-0-19-953569-0', 'Jane Eyre', 1847, 'Smith, Elder & Co.', 1, 5, 4, 4),
('978-0-19-953571-0', 'El Retrato de Dorian Gray', 1890, 'Lippincott''s Monthly Magazine', 1, 8, 5, 5),
('978-0-14-017739-8', 'Moby Dick', 1851, 'Harper & Brothers', 1, 6, 4, 4),
('978-0-19-953562-0', 'Hamlet', 1603, 'Nicholas Ling', 1, 12, 9, 5),
('978-0-679-64156-5', 'Macbeth', 1623, 'Thomas Walker', 1, 10, 8, 5),
('978-0-439-06487-7', 'El Cantar de los Nibelungos', 1200, 'Rocco', 1, 8, 5, 4),
('978-0-553-21311-8', 'Ulises', 1922, 'Shakespeare and Company', 1, 6, 4, 5),
('978-0-06-112241-5', 'Los Miserables', 1862, 'A. Lacroix, Verboeckhoven & Cie', 1, 10, 6, 5),
('978-0-06-112241-6', 'Los Viajes de Gulliver', 1726, 'Benjamin Motte', 2, 5, 4, 5),
('978-0-06-112241-7', 'Drácula', 1897, 'Archibald Constable and Company', 1, 10, 7, 4),
('978-0-06-112241-8', 'Frankenstein', 1818, 'Lackington, Hughes, Harding, Mavor & Jones', 1, 7, 5, 4),
('978-0-00-714134-7', 'Anna Karenina', 1877, 'The Russian Messenger', 2, 5, 3, 5),
('978-0-00-714134-8', 'Guerra y Paz', 1869, 'The Russian Messenger', 1, 6, 4, 5),
('978-0-7432-7354-5', 'La Isla del Tesoro', 1883, 'Cassell & Co.', 1, 5, 3, 4),
('978-0-7432-7354-6', 'Robinson Crusoe', 1719, 'William Taylor', 1, 7, 5, 5),
('978-0-7432-7354-7', 'Don Quijote de la Mancha', 1605, 'Francisco de Robles', 2, 8, 6, 5),
('978-0-7432-7354-8', 'La Odisea', -800, 'Homero', 1, 12, 10, 5),
('978-0-7432-7354-9', 'La Ilíada', -800, 'Homero', 1, 11, 9, 5),
('978-0-7432-7355-0', 'El Conde de Montecristo', 1844, 'Pierre-Jules Hetzel', 1, 9, 7, 5),
('978-0-7432-7355-1', 'El Paraíso Perdido', 1667, 'Samuel Simmons', 1, 7, 5, 5),
('978-0-7432-7355-2', 'El Hombre Invisible', 1897, 'C. Arthur Pearson', 1, 6, 4, 5),
('978-0-7432-7355-3', 'Los Tres Mosqueteros', 1844, 'Baudry''s European Library', 1, 7, 5, 5),
('978-0-7432-7355-4', 'La Máquina del Tiempo', 1895, 'Heinemann', 1, 5, 4, 4),
('978-0-7432-7355-5', 'Veinte Mil Leguas de Viaje Submarino', 1870, 'Pierre-Jules Hetzel', 1, 6, 4, 4),
('978-0-7432-7355-6', 'El extraño caso del Dr. Jekyll y Mr. Hyde', 1886, 'Longmans, Green & Co.', 1, 5, 4, 5);

-- Insertar autores en la tabla Autores
INSERT INTO Autores (nombre_autor, apellido_paterno, apellido_materno)
VALUES
('Gabriel', 'García', 'Márquez'), -- Cien Años de Soledad
('Miguel', 'de Cervantes', 'Saavedra'), -- Don Quijote de la Mancha
('George', 'Orwell', NULL), -- 1984
('Ray', 'Bradbury', NULL), -- Fahrenheit 451
('Jane', 'Austen', NULL), -- Orgullo y Prejuicio
('Harper', 'Lee', NULL), -- Matar a un Ruiseñor
('Fiódor', 'Dostoyevski', NULL), -- Crimen y Castigo
('Antoine', 'de Saint-Exupéry', NULL), -- El Principito
('Emily', 'Brontë', NULL), -- Cumbres Borrascosas
('F. Scott', 'Fitzgerald', NULL), -- El Gran Gatsby
('Julio', 'Cortázar', NULL), -- Rayuela
('J.D.', 'Salinger', NULL), -- El Guardián Entre el Centeno
('J.R.R.', 'Tolkien', NULL), -- El Señor de los Anillos: La Comunidad del Anillo
('J.R.R.', 'Tolkien', NULL), -- El Hobbit
('J.K.', 'Rowling', NULL), -- Harry Potter y la Piedra Filosofal
('Paulo', 'Coelho', NULL), -- El Alquimista
('Suzanne', 'Collins', NULL), -- Los Juegos del Hambre
('C.S.', 'Lewis', NULL), -- Crónicas de Narnia
('Dan', 'Brown', NULL), -- El Código Da Vinci
('Mario', 'Puzo', NULL), -- El Padrino
('Patrick', 'Süskind', NULL), -- El Perfume
('Dante', 'Alighieri', NULL), -- La Divina Comedia
('Charlotte', 'Brontë', NULL), -- Jane Eyre
('Oscar', 'Wilde', NULL), -- El Retrato de Dorian Gray
('Herman', 'Melville', NULL), -- Moby Dick
('William', 'Shakespeare', NULL), -- Hamlet
('William', 'Shakespeare', NULL), -- Macbeth
('Anónimo', NULL, NULL), -- El Cantar de los Nibelungos
('James', 'Joyce', NULL), -- Ulises
('Victor', 'Hugo', NULL), -- Los Miserables
('Jonathan', 'Swift', NULL), -- Los Viajes de Gulliver
('Bram', 'Stoker', NULL), -- Drácula
('Mary', 'Shelley', NULL), -- Frankenstein
('León', 'Tolstói', NULL), -- Anna Karenina
('León', 'Tolstói', NULL), -- Guerra y Paz
('Robert Louis', 'Stevenson', NULL), -- La Isla del Tesoro
('Daniel', 'Defoe', NULL), -- Robinson Crusoe
('Homero', NULL, NULL), -- La Odisea
('Homero', NULL, NULL), -- La Ilíada
('Alejandro', 'Dumas', NULL), -- El Conde de Montecristo
('John', 'Milton', NULL), -- El Paraíso Perdido
('H.G.', 'Wells', NULL), -- El Hombre Invisible
('Alejandro', 'Dumas', NULL), -- Los Tres Mosqueteros
('H.G.', 'Wells', NULL), -- La Máquina del Tiempo
('Julio', 'Verne', NULL), -- Veinte Mil Leguas de Viaje Submarino
('Robert Louis', 'Stevenson', NULL); -- El extraño caso del Dr. Jekyll y Mr. Hyde

-- Asignar autores a libros en la tabla Libro_Autor
INSERT INTO LibroAutor (id_libro, id_autor)
VALUES
-- Cien Años de Soledad - Gabriel García Márquez
(1, 1),
-- Don Quijote de la Mancha - Miguel de Cervantes
(2, 2),
-- 1984 - George Orwell
(3, 3),
-- Fahrenheit 451 - Ray Bradbury
(4, 4),
-- Orgullo y Prejuicio - Jane Austen
(5, 5),
-- Matar a un Ruiseñor - Harper Lee
(6, 6),
-- Crimen y Castigo - Fiódor Dostoyevski
(7, 7),
-- El Principito - Antoine de Saint-Exupéry
(8, 8),
-- Cumbres Borrascosas - Emily Brontë
(9, 9),
-- El Gran Gatsby - F. Scott Fitzgerald
(10, 10),
-- Rayuela - Julio Cortázar
(11, 11),
-- El Guardián Entre el Centeno - J.D. Salinger
(12, 12),
-- El Señor de los Anillos: La Comunidad del Anillo - J.R.R. Tolkien
(13, 13),
-- El Hobbit - J.R.R. Tolkien
(14, 13),
-- Harry Potter y la Piedra Filosofal - J.K. Rowling
(15, 14),
-- El Alquimista - Paulo Coelho
(16, 15),
-- Los Juegos del Hambre - Suzanne Collins
(17, 16),
-- Crónicas de Narnia - C.S. Lewis
(18, 17),
-- El Código Da Vinci - Dan Brown
(19, 18),
-- El Padrino - Mario Puzo
(20, 19),
-- El Perfume - Patrick Süskind
(21, 20),
-- La Divina Comedia - Dante Alighieri
(22, 21),
-- Jane Eyre - Charlotte Brontë
(23, 22),
-- El Retrato de Dorian Gray - Oscar Wilde
(24, 23),
-- Moby Dick - Herman Melville
(25, 24),
-- Hamlet - William Shakespeare
(26, 25),
-- Macbeth - William Shakespeare
(27, 25),
-- El Cantar de los Nibelungos - Anónimo
(28, 26),
-- Ulises - James Joyce
(29, 27),
-- Los Miserables - Victor Hugo
(30, 28),
-- Los Viajes de Gulliver - Jonathan Swift
(31, 29),
-- Drácula - Bram Stoker
(32, 30),
-- Frankenstein - Mary Shelley
(33, 31),
-- Anna Karenina - León Tolstói
(34, 32),
-- Guerra y Paz - León Tolstói
(35, 32),
-- La Isla del Tesoro - Robert Louis Stevenson
(36, 33),
-- Robinson Crusoe - Daniel Defoe
(37, 34),
-- La Odisea - Homero
(38, 35),
-- La Ilíada - Homero
(39, 35),
-- El Conde de Montecristo - Alejandro Dumas
(40, 36),
-- El Paraíso Perdido - John Milton
(41, 37),
-- El Hombre Invisible - H.G. Wells
(42, 38),
-- Los Tres Mosqueteros - Alejandro Dumas
(43, 36),
-- La Máquina del Tiempo - H.G. Wells
(44, 38),
-- Veinte Mil Leguas de Viaje Submarino - Julio Verne
(45, 39),
-- El extraño caso del Dr. Jekyll y Mr. Hyde - Robert Louis Stevenson
(46, 33);

-- Asignar préstamos a los usuarios con id_rol = 3 (lectores)
-- Usuarios con estado de préstamo devuelto, asignarles nuevos préstamos.
-- Usuario 1 (Ejemplo con estado devuelto en un préstamo anterior)
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(1, 1, '2024-01-10', '2024-01-25', 'devuelto'), -- Primer préstamo devuelto
(1, 2, '2024-02-01', '2024-02-16', 'pendiente'); -- Segundo préstamo pendiente

-- Usuario 2 (Ejemplo con un préstamo activo o en retraso)
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(2, 3, '2024-03-01', '2024-03-16', 'con retraso'); -- Primer préstamo con retraso

-- Usuario 3 (Múltiples préstamos con estado devuelto y último en pendiente)
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(3, 4, '2024-01-05', '2024-01-20', 'devuelto'), -- Primer préstamo devuelto
(3, 5, '2024-03-10', '2024-03-25', 'devuelto'), -- Segundo préstamo devuelto
(3, 6, '2024-04-01', '2024-04-15', 'pendiente'); -- Tercer préstamo pendiente

-- Usuarios con un préstamo en estado devuelto pueden recibir nuevos préstamos
-- Usuario 4
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(4, 7, '2024-02-15', '2024-03-01', 'devuelto'), -- Primer préstamo devuelto
(4, 8, '2024-04-05', '2024-04-20', 'pendiente'); -- Segundo préstamo pendiente

-- Usuario 5 con un préstamo devuelto
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(5, 9, '2024-02-25', '2024-03-10', 'devuelto');

-- Usuario 6, sin retrasos, su último préstamo puede estar pendiente
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(6, 10, '2024-03-01', '2024-03-16', 'devuelto'),
(6, 11, '2024-04-01', '2024-04-15', 'pendiente'); 

-- Usuario 7 tiene un préstamo devuelto y recibe otro
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(7, 12, '2024-01-10', '2024-01-25', 'devuelto'),
(7, 13, '2024-02-20', '2024-03-05', 'devuelto'),
(7, 14, '2024-04-10', '2024-04-25', 'pendiente'); -- Pendiente último préstamo

-- Usuario 8 tiene retraso, por lo que no puede recibir más préstamos.
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(8, 15, '2024-02-01', '2024-02-16', 'con retraso'); -- Retraso, no puede recibir nuevos préstamos

-- Usuario 9 sin ningún préstamo previo, asignamos uno
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(9, 16, '2024-03-15', '2024-03-30', 'pendiente'); 

-- Usuario 10, sin préstamos, se le asigna un primer préstamo
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(10, 17, '2024-04-01', '2024-04-15', 'pendiente');

-- Usuario 11
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(11, 18, '2024-01-05', '2024-01-20', 'devuelto'),
(11, 19, '2024-03-01', '2024-03-16', 'pendiente');

-- Usuario 12
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(12, 20, '2024-02-10', '2024-02-25', 'devuelto'),
(12, 21, '2024-04-01', '2024-04-16', 'pendiente');

-- Usuario 13
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(13, 22, '2024-02-15', '2024-03-02', 'con retraso');

-- Usuario 14
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(14, 23, '2024-01-12', '2024-01-27', 'devuelto');

-- Usuario 15
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(15, 24, '2024-03-05', '2024-03-20', 'pendiente');
-- Usuario 16
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(16, 25, '2024-02-20', '2024-03-07', 'con retraso');

-- Usuario 17
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(17, 26, '2024-01-25', '2024-02-10', 'devuelto'),
(17, 27, '2024-03-10', '2024-03-25', 'pendiente');

-- Usuario 18
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(18, 28, '2024-02-14', '2024-02-29', 'devuelto'),
(18, 29, '2024-04-05', '2024-04-20', 'pendiente');

-- Usuario 19
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(19, 30, '2024-02-25', '2024-03-12', 'devuelto'),
(19, 31, '2024-03-15', '2024-03-30', 'pendiente');

-- Usuario 20
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(20, 32, '2024-01-20', '2024-02-04', 'devuelto');

-- Usuario 21
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(21, 33, '2024-03-01', '2024-03-16', 'pendiente');

-- Usuario 22
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(22, 34, '2024-02-10', '2024-02-25', 'devuelto'),
(22, 35, '2024-04-01', '2024-04-15', 'pendiente');

-- Usuario 23
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(23, 36, '2024-02-05', '2024-02-20', 'devuelto'),
(23, 37, '2024-03-25', '2024-04-10', 'pendiente');

-- Usuario 24
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(24, 38, '2024-03-01', '2024-03-16', 'pendiente');

-- Usuario 25
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(25, 39, '2024-02-10', '2024-02-25', 'con retraso');

-- Usuario 26
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(26, 40, '2024-01-15', '2024-02-01', 'devuelto'),
(26, 41, '2024-03-05', '2024-03-20', 'pendiente');

-- Usuario 27
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(27, 42, '2024-02-10', '2024-02-25', 'devuelto');

-- Usuario 28
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(28, 43, '2024-02-25', '2024-03-12', 'con retraso');

-- Usuario 29
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(29, 44, '2024-01-25', '2024-02-10', 'devuelto'),
(29, 45, '2024-03-15', '2024-03-30', 'pendiente');

-- Usuario 30
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(30, 46, '2024-03-01', '2024-03-16', 'pendiente');

-- Usuario 31
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(31, 47, '2024-01-05', '2024-01-20', 'devuelto');

-- Usuario 33
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(33, 1, '2024-01-20', '2024-02-04', 'devuelto'),
(33, 2, '2024-03-10', '2024-03-25', 'pendiente');

-- Usuario 34
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(34, 3, '2024-01-15', '2024-02-01', 'devuelto');

-- Usuario 35
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(35, 4, '2024-02-10', '2024-02-25', 'pendiente');

-- Usuario 36
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(36, 5, '2024-03-15', '2024-03-30', 'con retraso');

-- Usuario 37
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(37, 6, '2024-01-12', '2024-01-27', 'devuelto');

-- Usuario 38
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(38, 7, '2024-02-25', '2024-03-12', 'pendiente');

-- Usuario 39
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(39, 8, '2024-03-01', '2024-03-16', 'pendiente');

-- Usuario 40
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(40, 9, '2024-02-15', '2024-03-02', 'devuelto');

-- Usuario 41
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(41, 10, '2024-01-05', '2024-01-20', 'devuelto');

-- Usuario 42
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(42, 11, '2024-02-20', '2024-03-07', 'con retraso');

-- Usuario 43
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(43, 12, '2024-03-01', '2024-03-16', 'devuelto');

-- Usuario 44
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(44, 13, '2024-04-01', '2024-04-15', 'pendiente');

-- Usuario 45
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(45, 14, '2024-02-10', '2024-02-25', 'devuelto');

-- Usuario 46
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(46, 15, '2024-01-20', '2024-02-04', 'con retraso');

-- Usuario 47
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(47, 16, '2024-03-15', '2024-03-30', 'pendiente');

-- Usuario 48
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(48, 17, '2024-02-01', '2024-02-16', 'devuelto');

-- Usuario 49
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(49, 18, '2024-04-05', '2024-04-20', 'pendiente');

-- Usuario 50
INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
VALUES 
(50, 19, '2024-01-10', '2024-01-25', 'con retraso');
-- Insertar en la tabla Devoluciones, para préstamos con estado 'devuelto' 
-- La fecha de devolución es entre 5 días después de la fecha del préstamo y la fecha actual

INSERT INTO Devoluciones (id_prestamo, fecha_devolucion)
SELECT 
    P.id_prestamo,
    DATE_ADD(
        P.fecha_prestamo,
        INTERVAL (5 + FLOOR(RAND() * GREATEST(DATEDIFF(CURRENT_DATE, P.fecha_prestamo) - 5, 1))) DAY
    )
FROM Prestamos P
WHERE P.estado_prestamo = 'devuelto'
  AND P.fecha_prestamo <= DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY);

select * from Usuarios;
select * from Roles;
select * from Libros;
select * from Autores;
select * from LibroAutor;
select * from Prestamos;
select * from Devoluciones;
select * from Multas;

