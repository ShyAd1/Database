-- Creacion de la base de datos

create database libreria;
use libreria;

-- Creacion de las entidades/tablas

create table Usuarios(
	idUsuario int not null auto_increment,
    nombre varchar(25) not null,
    apellidoP varchar(25) default "---",
    apellidoM varchar(25) default "---",
    calle varchar(50) not null,
    colonia varchar(50) not null,
    nInterior int not null,
    nExterior int not null,
    codigoPostal int not null,
    primary key (idUsuario),
    unique (idUsuario)
);

create table Libros(
	idLibro int not null auto_increment,
    ISBN bigint not null,
    Titulo varchar(25) not null,
    Autor_es varchar(25) not null,
    primary key (idLibro),
    unique (idLibro)
);

create table Reserva(
	idReserva int not null auto_increment,
    idUsuarioR int not null,
    idLibroR int not null,
    fechaReserva date not null,
    foreign key (idUsuarioR) references Usuarios(idUsuario),
    foreign key (idLibroR) references Libros(idLibro),
    primary key (idReserva),
    unique (idReserva),
    unique (idLibroR)
);

-- Poblacion de las entidades/tablas

insert into Usuarios (nombre, apellidoP, apellidoM, calle, colonia, nInterior, nExterior, codigoPostal) values
	("Sofia", "Lopez", "Martinez", "Sapo", "Del rio", rand()*100, rand()*100, rand()*(5000-1000)+1000),
	("Diego", "Ramirez", "Gomez", "Sapo", "Del rio", rand()*100, rand()*100, rand()*(5000-1000)+1000),
	("Valeria", "Torres", "Reyes", "Sapo", "Del rio", rand()*100, rand()*100, rand()*(5000-1000)+1000),
	("Javier", "Morales", "Cruz", "Sapo", "Del rio", rand()*100, rand()*100, rand()*(5000-1000)+1000),
	("Camila", "Vega", "Flores", "Sapo", "Del rio", rand()*100, rand()*100, rand()*(5000-1000)+1000);
    
insert into Libros (ISBN, Titulo, Autor_es) values
	(rand()*(9799999999999-9780000000000)+9780000000000, "Cien años de soledad", "Gabriel García Márquez"),
	(rand()*(9799999999999-9780000000000)+9780000000000, "La Odisea", "Homero"),
	(rand()*(9799999999999-9780000000000)+9780000000000, "Crimen y castigo", "Fiódor Dostoyevski"),
	(rand()*(9799999999999-9780000000000)+9780000000000, "1984", "George Orwell"),
	(rand()*(9799999999999-9780000000000)+9780000000000, "Orgullo y prejuicio", "Jane Austen");
    
insert into Reserva (idUsuarioR, idLibroR, fechaReserva) select
	idUsuario, idLibro, current_date()
    from Usuarios, Libros where idUsuario = 1 and idLibro = 1 union select
    idUsuario, idLibro, current_date()
    from Usuarios, Libros where idUsuario = 1 and idLibro = 2 union select
    idUsuario, idLibro, current_date()
    from Usuarios, Libros where idUsuario = 2 and idLibro = 4 union select
    idUsuario, idLibro, current_date()
    from Usuarios, Libros where idUsuario = 3 and idLibro = 3 union select
    idUsuario, idLibro, current_date()
    from Usuarios, Libros where idUsuario = 5 and idLibro = 5;

-- Solicitar informacion

select * from Usuarios;
select * from Libros;
select * from Reserva;

-- Eliminar base de datos

drop database libreria

