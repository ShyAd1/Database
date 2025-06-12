use biblioteca;

-- Inciso a)
-- Personas llamadas Eduardo
select * from usuarios where nombre = 'Eduardo';
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, id_rol, contrasena)
values
('Eduardo', 'Méndez', 'Vega', 'eduardo.mendez@example.com', '5512345678', '1995-09-15', 3, 'PassEduardo123');
select * from usuarios where nombre = 'Eduardo';

-- Personas que no se llamen Eduardo
select * from usuarios where nombre != 'Eduardo';

-- El email, contraseña, id de persona y nombre completo en una sola columna de los lectores.
select concat(email,' ', contrasena,' ', 
	id_usuario,' ', nombre,' ', 
	primer_apellido,' ', segundo_apellido) 
from usuarios where id_rol = 3;

-- El email, contraseña, id de persona y nombre completo en una sola columna de que no son bibliotecarios.
select concat(email,' ', contrasena,' ', 
	id_usuario,' ', nombre,' ', 
    primer_apellido,' ', segundo_apellido) 
from usuarios where id_rol != 2;

-- El nombre completo de las personas y y la fecha_nacimiento de los que su identificador sea par y sea administrador.
select concat(nombre,' ', primer_apellido,' ', 
	segundo_apellido, ' ', fecha_nacimiento) 
from usuarios where ((id_usuario % 2) = 0) and (id_rol = 1);

-- El nombre completo de las personas y y la fecha de registro de los que su identificador sea par y no sea bibliotecario.
select concat(nombre,' ', primer_apellido,' ', 
	segundo_apellido, ' ', fecha_registro) 
from usuarios where ((id_usuario % 2) = 0) and (id_rol != 2);

-- Regresa la leyenda siguiente para cada registro "La persona [Nombre_completo] se registro el dia [fecha_registro]
select concat("La persona ", nombre,' ', 
	primer_apellido,' ', segundo_apellido, 
    " se registro el dia ", fecha_registro) 
from usuarios;

-- Regresa la leyenda siguiente para cada registro "En la aplicación el [Nombre_completo] posee un rol de [rol].
select concat("En la aplicación el ", nombre,' ', 
	primer_apellido,' ', segundo_apellido, 
    " posee un rol de ", nombre_rol) 
from usuarios, roles where Usuarios.id_rol = Roles.id_rol;

-- Libros con el doble de ejemplares disponibles que la edición del libro.
select * from libros where (edicion * 2 = cantidad_disponible);

-- Prestamos con mas de 10 días de diferencia entre la fecha de devolución y la fecha del prestamos (sin usar función de fecha)
select * 
from prestamos where (dayofyear(fecha_devolucion_max)-dayofyear(fecha_prestamo)) > 10;

-- Libros donde la cantidad total es exactamente el triple de la cantidad disponible
select *
from libros where cantidad_disponible*3 = cantidad_total;
insert into Autores (nombre_autor, apellido_paterno, apellido_materno)
values
	('Neal', 'Stephenson', null); -- Criptonomicon
insert into Libros (isbn, titulo, anio_publicacion, editorial, edicion, cantidad_total, cantidad_disponible, clasificacion)
values
	('978-0-06-051280-4', 'Criptonomicón', 1999, 'Avon', 1, 9, 3, 4);
insert into LibroAutor (id_libro, id_autor)
values
	(48,47);
select *
from libros where cantidad_disponible*3 = cantidad_total;

-- Libros con un numero impar de ejemplares disponibles
select *
from libros where (cantidad_disponible%2) != 0;

-- Libros con al menos 5 mas ejemplares disponibles que el numero de edición.
select *
from libros where cantidad_disponible >= edicion + 5;

-- Usuarios cuyo numero de teléfono es divisible entre 3.
select *
from usuarios where telefono % 3 = 0;


-- Inciso b)
update usuarios set telefono = null where id_usuario = 1;
update usuarios set telefono = null where id_usuario = 6;
update usuarios set telefono = null where id_usuario = 3;
update usuarios set telefono = null where id_usuario = 7;
update usuarios set telefono = null where id_usuario = 5;

update usuarios set segundo_apellido = null where id_usuario = 8;
update usuarios set segundo_apellido = null where id_usuario = 2;
update usuarios set segundo_apellido = null where id_usuario = 9;
update usuarios set segundo_apellido = null where id_usuario = 4;
update usuarios set segundo_apellido = null where id_usuario = 10;

update usuarios set fecha_nacimiento = null where id_usuario = 11;
update usuarios set fecha_nacimiento = null where id_usuario = 21;
update usuarios set fecha_nacimiento = null where id_usuario = 13;
update usuarios set fecha_nacimiento = null where id_usuario = 41;
update usuarios set fecha_nacimiento = null where id_usuario = 15;

-- Muestre los usuarios que todavía no tienen un teléfono asignado.  
select * from usuarios where telefono is null;

-- Muestra los usuarios con un segundo apellido no asignado.
select * from usuarios where segundo_apellido is null;

-- Muestra los libros sin clasificación
select * from libros where clasificacion is null;
update libros set clasificacion = null where id_libro = 1;
update libros set clasificacion = null where id_libro = 10;
update libros set clasificacion = null where id_libro = 26;
update libros set clasificacion = null where id_libro = 5;
update libros set clasificacion = null where id_libro = 8;
select * from libros where clasificacion is null;

-- Que libros no poseen una editorial asignada
select * from libros where editorial is null;
update libros set editorial = null where id_libro = 2;
update libros set editorial = null where id_libro = 24;
update libros set editorial = null where id_libro = 35;
update libros set editorial = null where id_libro = 11;
update libros set editorial = null where id_libro = 9;
select * from libros where editorial is null;

-- Cuales son los libros que no tienen un autor registrado en la tabla auxiliar
select * from LibroAutor where id_autor is null;
-- No se puede hacer insert que cumpla el select ya que en la creacion de la tabla auxiliar 
-- ambos campos deben de ser no nulos por lo que no deja hacer el insert


-- Inciso c)
-- Los que NO se llaman Pedro o Juan
select * from usuarios where nombre != 'Pedro' and nombre != 'Juan';

-- Los que se llamen Pedro y su apellido paterno es Ramírez
select * from usuarios where nombre = 'Pedro' and primer_apellido = 'Ramírez';
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, contrasena, id_rol)
values
	('Pedro', 'Ramírez', null, 'pedro.ramírez@example.com', '5523498761', '1996-10-12', 'PassPedro123', 3);
select * from usuarios where nombre = 'Pedro' and primer_apellido = 'Ramírez';

-- Los que su apellido paterno es López y NO se llaman Héctor
select * from usuarios where primer_apellido = 'López' and not nombre = 'Héctor';

-- Los que se llaman Claudia o su apellido paerno es López
select * from usuarios where primer_apellido = 'López' or nombre = 'Claudia';

-- Los que cualquiera de sus apellidos es Ruiz
select * from usuarios where primer_apellido = 'Ruiz' or segundo_apellido = 'Ruiz';

-- Los que su apellido paterno es Gómez, Romero o Flores. (Operadores especiales)
select * from usuarios where primer_apellido in ('Gómez','Romero','Flores');

-- Los que se llaman Daniel y su apellido paterno es Govea o Pérez
select * from usuarios where nombre = 'Daniel' and (primer_apellido = 'Govea' or primer_apellido = 'Pérez');
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, contrasena, id_rol)
values
	('Daniel', 'Govea', null, 'daniel.govea@example.com', '5534569871', '1996-5-29', 'PassDaniel123', 3),
	('Daniel', 'Pérez', null, 'daniel.pérez@example.com', '5545698741', '1985-7-15', 'PassDaniel123', 1);
select * from usuarios where nombre = 'Daniel' and (primer_apellido = 'Govea' or primer_apellido = 'Pérez');

-- Los usuarios con un rol de lector o bibliotecario que no tienen un segundo apellido asignado
select * from usuarios where (id_rol = 2 or id_rol = 3) and segundo_apellido is null;

-- Los prestamos realizados entre el 1 de enero de 2024 y el 1 de marzo de 2024 (Operadores especiales)
select * from prestamos where fecha_prestamo between '2024-01-01' and '2024-03-01';

-- Los clientes que cualquiera de sus apellidos sea Blanco, Pérez o García, 
-- pero su nombre no sea Fernanda, Claudia, Antonio o Luis (Operadores especiales)
select * from usuarios where 
(primer_apellido in ('Blanco', 'Pérez', 'García') or 
segundo_apellido in ('Blanco', 'Pérez', 'García')) and 
nombre not in ('Fernanda', 'Claudia', 'Antonio', 'Luis');

-- Los usuarios que posean un teléfono y alguno de los apellidos 
-- es (Martínez, García, Vázquez, Diaz, López, Hernández). (Operadores especiales)
select * from usuarios where telefono is not null and 
(primer_apellido in ('Martínez', 'García', 'Vázquez', 'Diaz', 'López', 'Hernández') or 
segundo_apellido in ('Martínez', 'García', 'Vázquez', 'Diaz', 'López', 'Hernández'));

-- Los clientes que no posean teléfono y tampoco se apelliden Flores, 
-- García o Ramírez en alguno de sus apellidos. (Operadores especiales)
select * from usuarios where telefono is null and 
(primer_apellido not in ('Flores', 'García', 'Ramírez') and 
segundo_apellido not in ('Flores', 'García', 'Ramírez'));

-- Libros con ediciones entre 2 y 5 que no tienen editorial asignada (Operadores especiales)
select * from libros where (edicion between 2 and 5) and editorial is null;

-- Libros con clasificacion entre 3 y 5 o sin clasificacion asignada (Operadores especiales)
select * from libros where (clasificacion between 3 and 5) or clasificacion is null;

-- Libros con cantidad total entre 10 y 50 y sin clasificacion (Operadores especiales)
select * from libros where (cantidad_total between 10 and 50) and clasificacion is null;

-- Usuarios con rol 'administrador' o 'lector' que tienen segundo apellido nulo
select * from usuarios where (id_rol = 1 or id_rol = 3) and segundo_apellido is null;


