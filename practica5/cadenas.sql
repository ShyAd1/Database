use biblioteca;

-- Inciso a)
-- Muestra solo a las personas que su nombre tiene más de 5 letras.
select * from usuarios where char_length(nombre) > 5;

-- Muestra a las personas que su nombre tiene entre 5 y 7 caracteres.
select * from usuarios where char_length(nombre) between 5 and 7;

-- Muestra a las personas que su nombre tiene entre mas de 7 
-- caracteres y alguno de sus apellidos tenga entre 5 y 7 caracteres.
select * from usuarios where char_length(nombre) > 7 and (char_length(primer_apellido) 
between 5 and 7 or char_length(primer_apellido) between 5 and 7);

-- Muestra los primeros tres caracteres del nombre.
select left(nombre, 3) from usuarios;

-- Muestra los últimos 3 caracteres del nombre.
select right(nombre, 3) from usuarios;

-- Muestra del 2do al 5to carácter del nombre.
select substring(nombre, 2, 4) from usuarios;

-- Reemplaza las d por s en nombre.
select replace(nombre, 'd', 's') from usuarios;

-- Obtén la longitud del apellido paterno.
select primer_apellido, char_length(primer_apellido) from usuarios;

-- Muestra en mayúsculas el nombre.
select upper(nombre) from usuarios;

-- Muestra en minúsculas el apellido paterno.
select lower(primer_apellido) from usuarios;

-- Muestra el nombre completo empezando por el apellido paterno con 
-- mayúsculas en una sola columna.
select concat(upper(primer_apellido), ' ', segundo_apellido, ' ', nombre) from usuarios;

-- Muestra el nombre de las personas con las E reemplazadas con el número 3.
select replace(replace(nombre, 'E', 3), 'e', 3) from usuarios;

-- Muestra el nombre completo de las personas con las o reemplazados con el número 0 en una sola columna.
select replace(concat(nombre, ' ', primer_apellido, ' ', segundo_apellido),'o', 0) from usuarios;

-- Libros con edición entre 1 y 5 y cuyo título comience con letra mayúscula
select * from libros where edicion between 1 and 5 and titulo REGEXP '^[A-Z]';

-- Usuarios cuyo segundo apellido sea NULL y cuyo primer apellido tenga más de 6 caracteres
select * from usuarios where segundo_apellido is null and char_length(primer_apellido) > 6;
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, id_rol, contrasena)
values
('Eduardo', 'Zaragoza', null, 'eduardo.zaragoza@example.com', '5512345678', '1995-09-15', 3, 'PassEduardo123');
select * from usuarios where segundo_apellido is null and char_length(primer_apellido) > 6;

-- Muestra el nombre de las personas reemplazando los siguientes caracteres 
-- A-->@,E-->3,I-->!, O-->0 ( Murcielago--> Murc!3l@g0).
select replace(replace(replace(replace(replace(replace(replace(replace(nombre, 'A', '@'), 'a', '@'),
'E', '3'), 'e', '3'),'I', '!'), 'i', '!'),'O', '0'), 'o', '0') from usuarios;

-- Convierte los primeros tres caracteres del nombre en mayúscula (Edgar-->EDgar).
select concat(upper(left(nombre, 3)), lower(substring(nombre, 4))) from usuarios;

-- Convierte el ultimo carácter del nombre en mayúsculas (Edgar-->EdgaR).
select concat(substring(nombre, 1, char_length(nombre) - 1), 
upper(substring(nombre, -1))) from usuarios;

-- Convierte el 3er carácter del nombre en Mayúscula (Edgar--> EdGar).
select concat(substring(nombre, 1, 2), upper(substring(nombre, 3, 1)),
substring(nombre, 4)) from usuarios;

-- Convierte el 2do y 4to carácter del nombre a Mayúscula(Edgar-->EDgAr).
select concat(substring(nombre, 1, 1), upper(substring(nombre, 2, 1)), 
substring(nombre, 3, 1), upper(substring(nombre, 4, 1)), substring(nombre, 5)) from usuarios;

-- Convierte a mayúsculas el segundo y último carácter (Armando-->ARmandO)
select concat(substring(nombre, 1, 1), upper(substring(nombre, 2, 1)), 
substring(nombre, 3, char_length(nombre)-1), upper(substring(nombre, -1))) from usuarios;

-- Convierte a mayúscula el segundo, cuarto y penúltimo carácter del nombre (Armando--> ARmAnDo)
select concat(substring(nombre, 1, 1), upper(substring(nombre, 2, 1)), 
substring(nombre, 3, 1), upper(substring(nombre, 4, 1)), substring(nombre, 5, char_length(nombre)-3),
upper(substring(nombre, -2, 1)), substring(nombre, -1, 1)) from usuarios;

-- Selecciona los usuarios con correo electrónico registrado, pero 
-- cuya dirección de email no incluya más de 10 caracteres antes del símbolo @
select * from usuarios where char_length(substring(email, 1, position('@' in email)-1)) <= 10;

-- Usuarios cuyo nombre tenga exactamente dos palabras y cuyo rol esté entre 'administrador' y 'bibliotecario'
select * from usuarios where (LENGTH(TRIM(nombre)) - 
LENGTH(REPLACE(TRIM(nombre), ' ', ''))) = 1 and id_rol between 1 and 2;
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, id_rol, contrasena)
values
('Pedro Eduardo', 'Zaragoza', 'Mendez', 'pedro.zaragoza@example.com', '5523456789', '1994-01-15', 2, 'PassPedro123');
select * from usuarios where (LENGTH(TRIM(nombre)) - 
LENGTH(REPLACE(TRIM(nombre), ' ', ''))) = 1 and id_rol between 1 and 2;

-- Usuarios cuyo nombre completo (nombre, primer apellido, segundo 
-- apellido) tenga exactamente 30 caracteres, y cuya contraseña tenga al menos 8 caracteres
select * from usuarios 
where char_length(concat(nombre, ' ', primer_apellido, ' ', segundo_apellido)) = 30 and char_length(contrasena) >= 8;
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, contrasena, id_rol
)
values ('Jonathan', 'Fernández', 'Montenegros', 'jonathan.fernández@example.com', '5551234567', '1990-05-10', 'PassJonathan123', 2);
select * from usuarios 
where char_length(concat(nombre, ' ', primer_apellido, ' ', segundo_apellido)) = 30 and char_length(contrasena) >= 8;


-- Inciso b)
-- Las personas que se llamen Eduardo sin importar que tengan 2 nombres.
select * from usuarios where nombre like 'Eduardo%' or nombre like '% Eduardo%' or nombre = 'Eduardo';
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, contrasena, id_rol
)
values ('Luis Eduardo', 'Fernández', 'Montenegros', 'luis.fernandez@example.com', '5551234567', '1990-05-10', 'PassLuis123', 3);
select * from usuarios where nombre like 'Eduardo%' or nombre like '% Eduardo%' or nombre = 'Eduardo';

-- Las personas que su segundo carácter sea una "d".
select * from usuarios where nombre like '_d%';

-- Los que no empiecen su nombre con una vocal.
select * from usuarios where nombre not regexp '^[AEIOUaeiou]';

-- Los que empiecen su nombre con una vocal y terminen con s.
select * from usuarios where nombre regexp '^[AEIOUaeiou].*s$';
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, contrasena, id_rol
)
values ('Alexis', 'Hernández', 'Mendéz', 'alexis.hernandez@example.com', '5534567891', '1991-02-10', 'PassAlexis123', 3);
select * from usuarios where nombre regexp '^[AEIOUaeiou].*s$';

-- Los que su tercer carácter del nombre sea una G.
select * from usuarios where nombre like '__G%';

-- Los que su primer carácter en el apellido paterno sea 'E' y el 4 sea 'A'
select * from usuarios where primer_apellido like 'E__A%';
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, contrasena, id_rol
)
values ('Luis', 'Edwards', null, 'luis.edwards@example.com', '5545678912', '1992-08-13', 'PassLuis123', 1);
select * from usuarios where primer_apellido like 'E__A%';

-- Los que tengan por lo menos una 'E' en su nombre.
select * from usuarios where nombre like '%E%';

-- Los que se llaman Eduardo y Cualquiera de sus apellidos empiece con 'C'
select * from usuarios where nombre like 'Eduardo%' 
and (primer_apellido like 'C%' or segundo_apellido like 'C%');
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, contrasena, id_rol
)
values ('Eduardo', 'Castro', null, 'eduardo.castro@example.com', '5556789123', '1995-10-24', 'PassEduardo123', 1);
select * from usuarios where nombre like 'Eduardo%' 
and (primer_apellido like 'C%' or segundo_apellido like 'C%');

-- Las personas que su apellido materno empiece con la primera 
-- mitad del alfabeto [A-M] pero que no empiecen ni con A ni con E
select * from usuarios where segundo_apellido regexp '^[B-DF-Mb-df-m]';

-- Las personas que su apellido paterno empiece con la segunda mitad del alfabeto [N-Z]
select * from usuarios where primer_apellido regexp '^[N-Zn-z]';

-- Obtener los libros cuyo título contenga la palabra "Historia".
select * from libros where titulo like '%Historia%';
insert into Libros (isbn, titulo, anio_publicacion, editorial, edicion, cantidad_total, cantidad_disponible, clasificacion)
values
('978-9-68-134266-1', 'La otra historia de México', 2006, 'Editorial Ariel', 1, 10, 7, 4);
select * from libros where titulo like '%Historia%';

-- Listar los usuarios cuyo apellido paterno termine con "ez".
select * from usuarios where primer_apellido like '%ez';

-- Seleccionar todos los usuarios cuyo correo electrónico sea de Gmail.
select * from usuarios where email like '%@gmail.com';
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, contrasena, id_rol
)
values ('Raul', 'Rodriguéz', null, 'raul.rodriguez@gmail.com', '5551234567', '1998-12-24', 'PassRaul123', 2);
select * from usuarios where email like '%@gmail.com';

-- Consultar los libros cuya editorial contenga la palabra "Editores".
select * from libros where editorial like '%Editores%';
insert into libros (ISBN, titulo, anio_publicacion, editorial, edicion, cantidad_total, cantidad_disponible, clasificacion) 
value ('978-607-00-1234-5', 'Introducción a la Programación', 2021, 'Alfa Editores Técnicos', '3', 10, 7, '005.13');
select * from libros where editorial like '%Editores%';

-- Listar los usuarios cuyos nombres contengan una vocal seguida de una "n".
select * from usuarios where nombre regexp '[AEIOUaeiou]n';

-- Obtener todos los usuarios cuyos números de teléfono terminen en "00".
select * from usuarios where telefono like '%00';

-- Consultar los autores cuyo nombre contenga la letra "J" en cualquier parte (ya sea minúscula o mayúsculas).
select * from autores where nombre_autor like '%J%' or nombre_autor like '%j%';

-- Obtener los usuarios cuyo nombre contenga exactamente cinco caracteres.
select * from usuarios where CHAR_LENGTH(nombre) = 5;

-- Obtener los títulos de libros que contengan números en cualquier parte.
select * from libros where titulo regexp '[0-9]';

