drop database if exists biblioteca;
create database biblioteca;

use biblioteca;

create table Roles(
	id_rol int not null auto_increment,
    nombre_rol varchar(50) unique not null,
    primary key (id_rol)
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
    primary key (id_libro)
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

select * from Usuarios;
select * from Roles;
select * from Libros;
select * from Autores;
select * from LibroAutor;
select * from Prestamos;
select * from Devoluciones;
select * from Multas;

