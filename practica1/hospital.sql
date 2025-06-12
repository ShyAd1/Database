-- Creacion de la base de datos

create database hospital;
use hospital;

-- Creacion de las entidades/tablas

create table Personas(
	idPersona int not null auto_increment,
    nombreP varchar(50) not null, 
    direccionP varchar(100) not null,
    ubicacionGeograficaP varchar(100) not null,
    fechaNacimientoP date,
    primary key (idPersona),
    unique (idPersona)
);

create table Departamentos(
	idDepartamento int not null auto_increment,
    nombreD varchar(50) not null,
    primary key (idDepartamento),
    unique (idDepartamento)
);

create table AreaMedica(
	idArea int not null auto_increment,
    nombreA varchar(50) not null,
    primary key (idArea),
    unique (idArea)
);

create table Salas(
	idSalas int not null auto_increment,
	idDptoPerteneciente int not null,
    nombreS varchar(50) not null,
    foreign key (idDptoPerteneciente) references Departamentos(idDepartamento),
    primary key (idSalas),
    unique (idSalas)
);

create table Empleados(
	idEmpleado int not null,
    fechaContratacion date not null,
    idDptoPerteneciente int not null,
    foreign key (idDptoPerteneciente) references Departamentos(idDepartamento),
    foreign key (idEmpleado) references Personas(idPersona),
    unique(idEmpleado)
);

create table Doctores(
	idDoctor int not null,
    especialidadD varchar(50) not null,
    foreign key (idDoctor) references Empleados(idEmpleado),
    unique (idDoctor)
);

create table Pacientes(
	idPaciente int not null,
    fechaIngreso date not null,
    historialClinico text not null,
    SeguroMedico varchar(50) not null,
    idDoctorP int not null,
    idAreaP int not null,
    foreign key (idPaciente) references Personas(idPersona),
    foreign key (idDoctorP) references Doctores(idDoctor),
    foreign key (idAreaP) references AreaMedica(idArea),
    unique(idPaciente)
);

create table Enfermeros(
	idEnfermero int not null,
    turnoAsignadoE varchar(50) not null,
    certificacionE varchar(100) not null,
    idSalaE int not null,
    foreign key (idEnfermero) references Empleados(idEmpleado),
    foreign key (idSalaE) references Salas(idSalas),
    unique (idEnfermero)
);

-- Poblacion de las entidades/tablas

insert into Personas (nombreP, direccionP, ubicacionGeograficaP, fechaNacimientoP) values
	("Sofia Lopez", "Av. Insurgentes 123", "Ciudad de México, México", "1985-03-12"),
	("Diego Ramirez", "Calle Sol 45", "Guadalajara, Jalisco", "1978-07-19"),
	("Valeria Torres", "Calle Luna 78", "Monterrey, Nuevo León", "1990-11-03"),
	("Javier Morales", "Av. Revolución 56", "Tijuana, Baja California", "1982-05-27"),
	("Camila Vega", "Calle Rosas 12", "Puebla, Puebla", "1995-09-14"),
	("Mateo Castro", "Av. Libertad 89", "Querétaro, Querétaro", "1988-02-08"),
	("Lucia Ortega", "Calle Olivo 34", "Mérida, Yucatán", "1992-12-25"),
	("Gabriel Rios", "Av. Independencia 67", "León, Guanajuato", "1980-04-30"),
	("Isabela Molina", "Calle Pino 23", "Cancún, Quintana Roo", "1993-06-17"),
	("Andres Gil", "Av. Juárez 101", "Chihuahua, Chihuahua", "1987-10-22");
    
insert into Departamentos (nombreD) values
	("Cardiología"),
	("Neurología"),
	("Pediatría"),
	("Oncología"),
	("Cirugía General"),
	("Urgencias"),
	("Ginecología"),
	("Ortopedia"),
	("Radiología"),
	("Medicina Interna");
    
insert into AreaMedica (nombreA) values
	("Unidad de Cuidados Intensivos"),
	("Quirófano"),
	("Consulta Externa"),
	("Hospitalización"),
	("Rehabilitación"),
	("Imagenología"),
	("Laboratorio Clínico"),
	("Endoscopía"),
	("Hemodiálisis"),
	("Maternidad");

insert into Salas (idDptoPerteneciente, nombreS) select
	idDepartamento, "Sala Cardiología A"
    from Departamentos where idDepartamento = 1 union select
	idDepartamento, "Sala Cardiología B"
    from Departamentos where idDepartamento = 1 union select
	idDepartamento, "Sala Neurología"
    from Departamentos where idDepartamento = 2 union select
	idDepartamento, "Sala Pediatría A"
    from Departamentos where idDepartamento = 3 union select
	idDepartamento, "Sala Oncología"
    from Departamentos where idDepartamento = 4 union select
	idDepartamento, "Quirófano 1"
    from Departamentos where idDepartamento = 5 union select
	idDepartamento, "Sala Urgencias A"
    from Departamentos where idDepartamento = 6 union select
	idDepartamento, "Sala Maternidad"
    from Departamentos where idDepartamento = 7 union select
	idDepartamento, "Sala Ortopedia"
    from Departamentos where idDepartamento = 8 union select
	idDepartamento, "Sala Radiología"
    from Departamentos where idDepartamento = 9;
    
insert into Empleados (idEmpleado, fechaContratacion, idDptoPerteneciente) select
	idPersona, "2020-01-15", idDepartamento
    from Personas, Departamentos where idPersona = 6 and idDepartamento = 1 union select
	idPersona, "2019-06-22", idDepartamento
    from Personas, Departamentos where idPersona = 7 and idDepartamento = 2 union select
	idPersona, "2021-03-10", idDepartamento
    from Personas, Departamentos where idPersona = 8 and idDepartamento = 3 union select
	idPersona, "2018-11-05", idDepartamento
    from Personas, Departamentos where idPersona = 9 and idDepartamento = 4 union select
	idPersona, "2022-02-18", idDepartamento
    from Personas, Departamentos where idPersona = 10 and idDepartamento = 5;
    
insert into Doctores (idDoctor, especialidadD) select
	idEmpleado, "Cardiólogo"
    from Empleados where idEmpleado = 6 union select
	idEmpleado, "Neurólogo"
    from Empleados where idEmpleado = 7;
    
insert into Pacientes (idPaciente, fechaIngreso, historialClinico, SeguroMedico, idDoctorP, idAreaP) select
	idPersona, "2025-01-10", "Hipertensión arterial, control regular", "IMSS", idDoctor, idArea
    from Personas, Doctores, AreaMedica where idPersona = 1 and idDoctor = 6 and idArea = 1 union select
	idPersona, "2025-02-15", "Fractura de fémur", "Seguro Popular", idDoctor, idArea
    from Personas, Doctores, AreaMedica where idPersona = 2 and idDoctor = 6 and idArea = 4 union select
	idPersona, "2025-03-20", "Diabetes tipo 2", "ISSSTE", idDoctor, idArea
    from Personas, Doctores, AreaMedica where idPersona = 3 and idDoctor = 7 and idArea = 3 union select
	idPersona, "2025-04-05", "Cáncer de mama en tratamiento", "Privado", idDoctor, idArea
    from Personas, Doctores, AreaMedica where idPersona = 4 and idDoctor = 7 and idArea = 4 union select
	idPersona, "2025-05-01", "Embarazo de alto riesgo", "IMSS", idDoctor, idArea
    from Personas, Doctores, AreaMedica where idPersona = 5 and idDoctor = 6 and idArea = 10;
    
insert into Enfermeros (idEnfermero, turnoAsignadoE, certificacionE, idSalaE) select
	idEmpleado, "Matutino", "Certificación en Cuidados Intensivos", idSalas from Empleados, Salas where idEmpleado = 8 and idSalas = 1 union select
	idEmpleado, "Vespertino", "Certificación en Oncología", idSalas from Empleados, Salas where idEmpleado = 9 and idSalas = 5 union select
	idEmpleado, "Nocturno", "Certificación en Quirófano", idSalas from Empleados, Salas where idEmpleado = 10 and idSalas = 6;

-- Solicitar informacion

select * from Personas;
select * from Departamentos;
select * from AreaMedica;
select * from Salas;
select * from Empleados;
select * from Doctores;
select * from Pacientes;
select * from Enfermeros;

-- Eliminar base de datos

drop database hospital;

