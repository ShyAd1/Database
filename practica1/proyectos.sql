-- Creacion de la base de datos

create database proyectos;
use proyectos;

-- Creacion de entidades/tablas

create table Proyectos(
	idProyecto int not null auto_increment,
    nombreP varchar(100) not null,
    fechaInicio date not null,
    fechaFin date not null,
    primary key (idProyecto),
    unique (idProyecto)
);

create table Departamentos(
	idDepartamento int not null auto_increment,
    nombreD varchar(100) not null,
    primary key (idDepartamento),
    unique (idDepartamento)
);

create table Tareas(
	idTarea int not null auto_increment,
	idProyectoT int not null,
	nombreT varchar(200) not null,
    descripcionT text not null,
    fechaEntrega date not null,
    recursos text not null,
    foreign key (idProyectoT) references Proyectos(idProyecto),
    primary key (idTarea)
);

create table Empleados(
	nEmpleado int not null auto_increment,
    nombreE varchar(25) not null,
    apellidoPE varchar(50) not null,
    apellidoME varchar(50) not null,
    cargoE varchar(50) not null,
    fecha_registro date,
    idDepartamentoE int not null,
    foreign key (idDepartamentoE) references Departamentos(idDepartamento),
    primary key (nEmpleado),
    unique (nEmpleado)
);

create table Clientes(
	idCliente int not null  auto_increment,
	idProyectoC int not null,
    nombreC varchar(50) not null,
    numeroC bigint not null,
    foreign key (idProyectoC) references Proyectos(idProyecto),
    primary key (idCliente),
    unique (idCliente),
    unique (idProyectoC)
);

create table Asignacion(
	idAsignar int not null auto_increment,
    idEmpleadoA int not null,
    idTareaA int not null,
    fechaAsignacion date not null,
    foreign key (idEmpleadoA) references Empleados(nEmpleado),
    foreign key (idTareaA) references Tareas(idTarea),
    primary key (idAsignar),
    unique (idAsignar)
);

-- Poblacion de las entidades/tablas

insert into Proyectos (nombreP, fechaInicio, fechaFin) values
	("Pagina web", current_date(), date_add(current_date(), interval floor(rand()*(0-7)+7) day)),
    ("Aplicacion de escritorio", current_date(), date_add(current_date(), interval floor(rand()*(0-7)+7) day)),
    ("Aplicacion movil", current_date(), date_add(current_date(), interval floor(rand()*(0-7)+7) day)),
    ("Implementacion de seguridad de un banco", current_date(), date_add(current_date(), interval floor(rand()*(0-7)+7) day)),
    ("Mantenimiento a la base de datos", current_date(), date_add(current_date(), interval floor(rand()*(0-7)+7) day));
    
insert into Departamentos (nombreD) values
	("Desarrollo"),
    ("Pruebas"),
    ("Gestión de producto"),
    ("Soporte técnico"),
    ("Infraestructura ");

insert into Tareas (idProyectoT, nombreT, descripcionT, fechaEntrega, recursos) select 
	idProyecto, "Pagina principal",  "Se debe crear la pagina principal que se mostrara a los usuario", fechaFin, "Se utilizara spring boot para la interfaz"
    from Proyectos where idProyecto = 1 union select
    idProyecto, "Inicio de sesion", "Se debe crear el inicio de sesion para que los usuarios guarden informacion", fechaFin, "Se utilizara comprobacion de datos para seguridad"
    from Proyectos where idProyecto = 1 union select
    idProyecto, "Guardado de datos", "Se debe crear la forma de guardado de datos local para la aplicacion", fechaFin, "Se utilizara la creacion de archivos para guardar configuraciones locales"
    from Proyectos where idProyecto = 2 union select
    idProyecto, "Conexion a la nube", "Se debe crear la conexion a la nube para guardado de datos", fechaFin, "Se utilizara google cloud para  guardar datos de forma masiva"
    from Proyectos where idProyecto = 3 union select
    idProyecto, "Interfaz intuitiva", "Se debe crear una interfaz que no este tan cargada de objetos con tal de facilitar el uso", fechaFin, "Se utilizara mockups con tal de diseñar y modelar las interfaces"
    from Proyectos where idProyecto = 3 union select
    idProyecto, "Codificar la seguridad", "Se debe crear una ciber seguirdad extensa bastante ruda la cual sea casi imposible de vulnerar", fechaFin, "Se utilizara un lenguaje robusto"
    from Proyectos where idProyecto = 4 union select
    idProyecto, "Revision de modelos entidad relacion", "Se debe revisar los modelos entidad relacion para ver si se pueden modificar de manera que quede mas limpia", fechaFin, "Se utilizara las normalizaciones"
    from Proyectos where idProyecto = 5 union select
    idProyecto, "Codificacion de la base de datos", "Se debe modificar la base de datos para nuevas entidades", fechaFin, "Se utilizara x gestor de base de datos"
    from Proyectos where idProyecto = 5;
    
insert into Empleados (nombreE, apellidoPE, apellidoME, cargoE, fecha_registro, idDepartamentoE) select
	"Sofia", "Lopez", "Martinez", "Programador", current_date(), idDepartamento
    from Departamentos where idDepartamento = 1 union select
	"Diego", "Ramirez", "Gomez", "Programador", current_date(), idDepartamento
    from Departamentos where idDepartamento = 1 union select
	"Valeria", "Torres", "Reyes", "Diseño grafico", current_date(), idDepartamento
    from Departamentos where idDepartamento = 3 union select
	"Javier", "Morales", "Cruz", "Tester UI", current_date(), idDepartamento
    from Departamentos where idDepartamento = 2 union select
	"Camila", "Vega", "Flores", "Tester ciber seguiridad", current_date(), idDepartamento
    from Departamentos where idDepartamento = 2 union select
	"Mateo", "Castro", "Mendoza", "Jefe de soporte técnico", current_date(), idDepartamento
    from Departamentos where idDepartamento = 4 union select
	"Lucia", "Ortega", "Silva", "Ingeniero en infraestructura", current_date(), idDepartamento
    from Departamentos where idDepartamento = 5;
    
insert into Clientes (idProyectoC, nombreC, numeroC) select 
	idProyecto, "E-commerce", rand()*(5599999999-5500000000)+5500000000
    from Proyectos where idProyecto = 1 union select
    
    idProyecto, "Aplicacion generica", rand()*(5599999999-5500000000)+5500000000
    from Proyectos where idProyecto = 2 union select
    
    idProyecto, "Juego generico", rand()*(5599999999-5500000000)+5500000000
    from Proyectos where idProyecto = 3 union select
    
    idProyecto, "Banco generico", rand()*(5599999999-5500000000)+5500000000
    from Proyectos where idProyecto = 4 union select
    
    idProyecto, "Tienda generica", rand()*(5599999999-5500000000)+5500000000
    from Proyectos where idProyecto = 5;
    
insert into Asignacion (idEmpleadoA, idTareaA, fechaAsignacion) select
	nEmpleado, idTarea, current_date()
    from Empleados, Tareas where nEmpleado = 1 and idTarea = 1 union select
    nEmpleado, idTarea, current_date()
    from Empleados, Tareas where nEmpleado = 1 and idTarea = 2 union select
    nEmpleado, idTarea, current_date()
    from Empleados, Tareas where nEmpleado = 1 and idTarea = 3 union select
    nEmpleado, idTarea, current_date()
    from Empleados, Tareas where nEmpleado = 1 and idTarea = 4 union select
    nEmpleado, idTarea, current_date()
    from Empleados, Tareas where nEmpleado = 2 and idTarea = 1 union select
    nEmpleado, idTarea, current_date()
    from Empleados, Tareas where nEmpleado = 2 and idTarea = 2 union select
    nEmpleado, idTarea, current_date()
    from Empleados, Tareas where nEmpleado = 2 and idTarea = 3 union select
    nEmpleado, idTarea, current_date()
    from Empleados, Tareas where nEmpleado = 2 and idTarea = 4 union select
    nEmpleado, idTarea, current_date()
    from Empleados, Tareas where nEmpleado = 3 and idTarea = 5 union select
    nEmpleado, idTarea, current_date()
    from Empleados, Tareas where nEmpleado = 3 and idTarea = 7;
    
-- Solicitar informacion

select * from Proyectos;
select * from Departamentos;
select * from Tareas;
select * from Empleados;
select * from Clientes;
select * from Asignacion;

-- Eliminar base de datos

drop database proyectos;

