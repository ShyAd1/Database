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
select replace(nombre, 'E', 3) from usuarios;

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

-- Convierte a mayúsculas el segundo y último carácter (Armando-->ArmandO)
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
select * from usuarios where char_length(concat(nombre, ' ', primer_apellido, ' ', segundo_apellido)) = 30 and char_length(contrasena) >= 8;
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, contrasena, id_rol
)
values ('Jonathan', 'Fernández', 'Montenegros', 'jonathan.fernández@example.com', '5551234567', '1990-05-10', 'PassJonathan123', 3);
select * from usuarios where char_length(concat(nombre, ' ', primer_apellido, ' ', segundo_apellido)) = 30 and char_length(contrasena) >= 8;


-- Inciso b)
-- Las personas que se llamen Eduardo sin importar que tengan 2 nombres.
select * from usuarios where nombre like 'Eduardo%' or nombre like '% Eduardo%' or nombre = 'Eduardo';
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, contrasena, id_rol
)
values ('Luis Eduardo', 'Fernández', 'Montenegros', 'luis.fernández@example.com', '5551234567', '1990-05-10', 'PasLuis123', 3);
select * from usuarios where nombre like 'Eduardo%' or nombre like '% Eduardo%' or nombre = 'Eduardo';

-- Las personas que su segundo carácter sea una "d".
select * from usuarios where nombre like '_d%';

-- Los que no empiecen su nombre con una vocal.
select * from usuarios where nombre not regexp '^[AEIOUaeiou]';

-- Los que empiecen su nombre con una vocal y terminen con s.
select * from usuarios where nombre regexp '^[AEIOUaeiou].*s$';

select * from usuarios where nombre like '__G%';




