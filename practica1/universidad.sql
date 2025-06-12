-- Creacion de la base de datos

create database universidad;
use universidad;

-- Creacion de las entidades/tablas

create table Personas (
	idPersona int not null auto_increment,
    nombreP varchar(25) not null,
    apellidoPP varchar(50) not null,
    apellidoMP varchar(50) not null,
    direccion varchar(100) not null,
    primary key (idPersona),
    unique (idPersona)
);

create table Departamentos (
	idDepartamento int not null auto_increment,
    nombreD varchar(100) not null,
    actividadesD varchar(100) not null,
    primary key (idDepartamento),
    unique (idDepartamento)
);

create table Profesores (
	idPersonaP int not null,
    nEmpleadoP int not null,
    especialidadP varchar(50) not null,
    departamento varchar(50) not null,
    foreign key (idPersonaP) references Personas(idPersona),
    unique (idPersonaP),
    unique (nEmpleadoP)
);

create table Estudiantes (
	idPersonaE int not null,
    boletaE int not null,
    añoIngresoE year not null,
    carrera varchar(50) not null,
    tutor int not null,
    foreign key (idPersonaE) references Personas(idPersona),
    foreign key (tutor) references Profesores(idPersonaP),
    unique (idPersonaE),
    unique (boletaE)
);

create table Cursos (
	codigoC int not null auto_increment,
    nombreC varchar(50) not null,
    creditosC decimal(10,1) not null,
    impartido int not null,
    foreign key (impartido) references Profesores(idPersonaP),
    primary key (codigoC),
    unique (codigoC)
);

create table Inscripcion (
	idInscriopcion int not null auto_increment,
	incritoI int not null,
    cursoI int not null,
    foreign key (incritoI) references Estudiantes(idPersonaE),
    foreign key (cursoI) references Cursos(codigoC), 
    primary key (idInscriopcion),
    unique (idInscriopcion)
);

create table Actividades (
	idActividad int not null auto_increment,
	idDepartamentoA int not null,
    idPersonaA int not null,
    foreign key (idDepartamentoA) references Departamentos(idDepartamento),
    foreign key (idPersonaA) references Personas(idPersona),
    primary key (idActividad),
    unique (idActividad)
);
    

-- Poblacion de las entidades/tablas

insert into Personas (nombreP, apellidoPP, apellidoMP, direccion) values
	("Adair", "Hernandez", "Valdivia", "Av. Sapito Col. Del Rio"),
	("Sofia", "Lopez", "Martinez", "Calle Luna Col. Estrella"),
	("Diego", "Ramirez", "Gomez", "Av. Sol No. 123 Col. Centro"),
	("Valeria", "Torres", "Reyes", "Calle Pino Col. Bosques"),
	("Javier", "Morales", "Cruz", "Av. Independencia No. 45"),
	("Camila", "Vega", "Flores", "Calle Rosas Col. Jardines"),
	("Mateo", "Castro", "Mendoza", "Av. Libertad No. 789"),
	("Lucia", "Ortega", "Silva", "Calle Olivo Col. Pradera");
    
insert into Departamentos (nombreD, actividadesD) values
	("Dpto. Ciencias de la computacion", "Diseño, desarrollo y estudio de la tecnología informática"),
	("Dpto. Ingeniería Civil", "Planificación, diseño y construcción de infraestructuras"),
	("Dpto. Biología", "Investigación y estudio de organismos vivos"),
	("Dpto. Administración", "Gestión de recursos y procesos organizativos"),
	("Dpto. Artes Visuales", "Creación y análisis de expresiones artísticas");
    
insert into Profesores (idPersonaP, nEmpleadoP, especialidadP, departamento) select
	idPersona, rand()*(100000-50000)+50000, "Ing. Sistemas", nombreD 
    from Personas, Departamentos where idPersona = 1 and idDepartamento = 1 union select
	idPersona, rand()*(100000-50000)+50000, "Ing. Civil", nombreD 
    from Personas, Departamentos where idPersona = 2 and idDepartamento = 2 union select
	idPersona, rand()*(100000-50000)+50000, "Biólogo", nombreD 
    from Personas, Departamentos where idPersona = 3 and idDepartamento = 3 union select
	idPersona, rand()*(100000-50000)+50000, "Administrador", nombreD 
    from Personas, Departamentos where idPersona = 4 and idDepartamento = 4;
    
insert into Estudiantes (idPersonaE, boletaE, añoIngresoE, carrera, tutor) select
	idPersona, year(current_date())*10000 + rand()*(9999), year(current_date()), "Ingenieria en Sistemas computacionales", idPersonaP
    from Personas, Profesores where idPersona = 5 and idPersonaP = 1 union select
	idPersona, year(current_date())*10000 + rand()*(9999), year(current_date()), "Ingenieria Civil", idPersonaP
    from Personas, Profesores where idPersona = 6 and idPersonaP = 1 union select
	idPersona, year(current_date())*10000 + rand()*(9999), year(current_date()), "Biologia", idPersonaP
    from Personas, Profesores where idPersona = 7 and idPersonaP = 2 union select
	idPersona, year(current_date())*10000 + rand()*(9999), year(current_date()), "Administracion", idPersonaP
    from Personas, Profesores where idPersona = 8 and idPersonaP = 4;
    
insert into Cursos (nombreC, creditosC, impartido) select
	"Desarrollo web", round(rand()*(8-3)+3, 1), idPersonaP
    from Profesores where idPersonaP = 1 union select
	"Algoritmos", round(rand()*(8-3)+3, 1), idPersonaP
    from Profesores where idPersonaP = 1 union select
	"Estructuras de datos", round(rand()*(8-3)+3, 1), idPersonaP
    from Profesores where idPersonaP = 2 union select
	"Ingeniería de software", round(rand()*(8-3)+3, 1), idPersonaP
    from Profesores where idPersonaP = 2 union select
	"Biología molecular", round(rand()*(8-3)+3, 1), idPersonaP
    from Profesores where idPersonaP = 3 union select
	"Ecología", round(rand()*(8-3)+3, 1), idPersonaP
    from Profesores where idPersonaP = 3 union select
	"Gestión empresarial", round(rand()*(8-3)+3, 1), idPersonaP
    from Profesores where idPersonaP = 4 union select
	"Finanzas corporativas", round(rand()*(8-3)+3, 1), idPersonaP
    from Profesores where idPersonaP = 4;
    
insert into Inscripcion (incritoI , cursoI) select
	idPersonaE, codigoC
    from Estudiantes, Cursos where idPersonaE = 5 and codigoC = 1 union select
	idPersonaE, codigoC
    from Estudiantes, Cursos where idPersonaE = 5 and codigoC = 2 union select
	idPersonaE, codigoC
    from Estudiantes, Cursos where idPersonaE = 6 and codigoC = 1 union select
	idPersonaE, codigoC
    from Estudiantes, Cursos where idPersonaE = 6 and codigoC = 3 union select
	idPersonaE, codigoC
    from Estudiantes, Cursos where idPersonaE = 7 and codigoC = 2 union select
	idPersonaE, codigoC
    from Estudiantes, Cursos where idPersonaE = 7 and codigoC = 4 union select
	idPersonaE, codigoC
    from Estudiantes, Cursos where idPersonaE = 8 and codigoC = 3 union select
	idPersonaE, codigoC
    from Estudiantes, Cursos where idPersonaE = 8 and codigoC = 4;

insert into Actividades (idDepartamentoA, idPersonaA) select
	idDepartamento, idPersona
    from Departamentos, Personas where idDepartamento = 1 and idPersona = 1 union select
	idDepartamento, idPersona
    from Departamentos, Personas where idDepartamento = 1 and idPersona = 2 union select
	idDepartamento, idPersona
    from Departamentos, Personas where idDepartamento = 2 and idPersona = 3 union select
	idDepartamento, idPersona
    from Departamentos, Personas where idDepartamento = 2 and idPersona = 4 union select
	idDepartamento, idPersona
    from Departamentos, Personas where idDepartamento = 3 and idPersona = 5 union select
	idDepartamento, idPersona
    from Departamentos, Personas where idDepartamento = 3 and idPersona = 6 union select
	idDepartamento, idPersona
    from Departamentos, Personas where idDepartamento = 4 and idPersona = 7 union select
	idDepartamento, idPersona
    from Departamentos, Personas where idDepartamento = 4 and idPersona = 8;

-- Solicitar informacion

select * from Personas;
select * from Departamentos;
select * from Profesores;
select * from Estudiantes;
select * from Cursos;
select * from Inscripcion;
select * from Actividades;

-- Eliminar base de datos

drop database universidad;

