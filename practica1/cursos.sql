-- Creacion de la base de datos

create database cursos;
use cursos;

-- Creacion de entidades/tablas

create table Profesores(
	idProfesor int not null auto_increment,
	nombreP varchar(25) not null,
    apellidoPP varchar(50) not null,
    apellidoPM varchar(50) not null,
    nEmpleado int not null,
    primary key (idProfesor),
    unique (idProfesor)
);

create table Curso(
	idCurso int not null auto_increment,
    codigoC int not null,
    creditosC decimal(10,1) not null,
    nombreC varchar(50) not null,
    primary key (idCurso),
    unique (idCurso)
);

create table Estudiantes(
	idEstudiante int not null auto_increment,
	nombreE varchar(25) not null,
    apellidoEP varchar(50) not null,
    apellidoEM varchar(50) not null,
    boleta bigint not null,
    primary key (idEstudiante),
    unique (idEstudiante)
);

create table Imparte(
	idImparte int not null auto_increment,
    idProfesorI int not null,
    idCursoI int not null,
    fechaInscripcion date not null,
    foreign key (idProfesorI) references Profesores(idProfesor),
    foreign key (idCursoI) references Curso(idCurso),
    primary key (idImparte),
    unique (idImparte),
    unique (idCursoI)
); 

create table Cursa(
	idCursa int not null auto_increment,
    idEstudianteC int not null,
    idCursoC int not null,
    fechaInscripcion date not null,
    foreign key (idEstudianteC) references Estudiantes(idEstudiante),
    foreign key (idCursoC) references Curso(idCurso),
    primary key (idCursa),
    unique (idCursa)
); 

-- Poblacion de las entidades/tablas

insert into Profesores (nombreP, apellidoPP, apellidoPM, nEmpleado) values
	("Sofia", "Lopez", "Martinez", (round(rand()*(24-10)+10))*10000 + rand()*(9999)),
	("Diego", "Ramirez", "Gomez", (round(rand()*(24-10)+10))*10000 + rand()*(9999)),
    ("Valeria", "Torres", "Reyes", (round(rand()*(24-10)+10))*10000 + rand()*(9999)),
    ("Javier", "Morales", "Cruz", (round(rand()*(24-10)+10))*10000 + rand()*(9999)),
    ("Camila", "Vega", "Flores", (round(rand()*(24-10)+10))*10000 + rand()*(9999));
    
insert into Curso (codigoC, creditosC, nombreC) values
	(rand()*(99-1)+1, round(rand()*(8-3)+3, 1), "Calculo 1"),
    (rand()*(99-1)+1, round(rand()*(8-3)+3, 1), "Base de datos"),
    (rand()*(99-1)+1, round(rand()*(8-3)+3, 1), "Procesamiento Digital de Imagenes"),
    (rand()*(99-1)+1, round(rand()*(8-3)+3, 1), "Machine Learning"),
    (rand()*(99-1)+1, round(rand()*(8-3)+3, 1), "Diseño de Sistemas Digitales");
    
insert into Estudiantes (nombreE, apellidoEP, apellidoEM, boleta) values
	("Mateo", "Castro", "Mendoza", (year(current_date()))*1000000 + (round(rand()*(4-1)+1))*10000 + rand()*9999),
    ("Lucia", "Ortega", "Silva", (year(current_date()))*1000000 + (round(rand()*(4-1)+1))*10000 + rand()*9999),
    ("Gabriel", "Rios", "Luna", (year(current_date()))*1000000 + (round(rand()*(4-1)+1))*10000 + rand()*9999),
    ("Isabela", "Molina", "Soto", (year(current_date()))*1000000 + (round(rand()*(4-1)+1))*10000 + rand()*9999),
    ("Andres", "Gil", "Vargas", (year(current_date()))*1000000 + (round(rand()*(4-1)+1))*10000 + rand()*9999);
    
insert into Imparte (idProfesorI, idCursoI, fechaInscripcion) select
	idProfesor, idCurso, current_date()
    from Profesores, Curso where idProfesor = 1 and idCurso = 2 union select
    idProfesor, idCurso, current_date()
    from Profesores, Curso where idProfesor = 1 and idCurso = 4 union select
    idProfesor, idCurso, current_date()
    from Profesores, Curso where idProfesor = 2 and idCurso = 3 union select
    idProfesor, idCurso, current_date()
    from Profesores, Curso where idProfesor = 4 and idCurso = 1 union select
    idProfesor, idCurso, current_date()
    from Profesores, Curso where idProfesor = 5 and idCurso = 5;
    
insert into Cursa (idEstudianteC, idCursoC, fechaInscripcion) select
	idEstudiante, idCurso, current_date()
    from Estudiantes, Curso where idEstudiante = 1 and idCurso = 1 union select
    idEstudiante, idCurso, current_date()
    from Estudiantes, Curso where idEstudiante = 1 and idCurso = 4 union select
    idEstudiante, idCurso, current_date()
    from Estudiantes, Curso where idEstudiante = 1 and idCurso = 3 union select
    idEstudiante, idCurso, current_date()
    from Estudiantes, Curso where idEstudiante = 2 and idCurso = 1 union select
    idEstudiante, idCurso, current_date()
    from Estudiantes, Curso where idEstudiante = 2 and idCurso = 5 union select
    idEstudiante, idCurso, current_date()
    from Estudiantes, Curso where idEstudiante = 3 and idCurso = 2 union select
    idEstudiante, idCurso, current_date()
    from Estudiantes, Curso where idEstudiante = 3 and idCurso = 4 union select
    idEstudiante, idCurso, current_date()
    from Estudiantes, Curso where idEstudiante = 4 and idCurso = 3 union select
    idEstudiante, idCurso, current_date()
    from Estudiantes, Curso where idEstudiante = 5 and idCurso = 1 union select
    idEstudiante, idCurso, current_date()
    from Estudiantes, Curso where idEstudiante = 5 and idCurso = 5;

-- Solicitar informacion

select * from Profesores;
select * from Curso;
select * from Estudiantes;
select * from Imparte;
select * from Cursa;

-- Eliminar base de datos

drop database cursos

