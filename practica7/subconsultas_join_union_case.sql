use biblioteca;

-- Inciso a)
-- Obtener los usuarios cuyo ID sea el mas alto.
select * from usuarios where id_usuario = (select max(id_usuario) from usuarios);

-- Libros con más ejemplares disponibles que el promedio
select * from libros where cantidad_disponible > (select avg(cantidad_disponible) from libros);

-- Usuarios sin préstamos asignados
select * from usuarios where id_usuario not in (select id_usuario from prestamos);

-- Libros con menos ejemplares disponibles que el mínimo entre todos
select * from libros where cantidad_disponible < (select min(cantidad_disponible) from libros);
insert into libros (ISBN, titulo, anio_publicacion, editorial, edicion, cantidad_total, cantidad_disponible, clasificacion)
values ('978-0-00-000000-0', 'Libro Mínimo', 2020, 'Editorial Prueba', 1, 5, 1, 3);
select * from libros where cantidad_disponible < (select min(cantidad_disponible) from libros);

-- Préstamos hechos el mismo día del registro del usuario
select * from prestamos where fecha_prestamo in (
select fecha_registro from usuarios where usuarios.id_usuario = prestamos.id_usuario);
insert into prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
values (3, 1, current_date, date_add(current_date, interval 15 day), 'devuelto');
select * from prestamos where fecha_prestamo in (
select fecha_registro from usuarios where usuarios.id_usuario = prestamos.id_usuario);

-- Libros cuyo título tiene más caracteres que el de menor longitud
select * from libros where char_length(titulo) > (select min(char_length(titulo)) from libros);

-- Libros con más disponibles que la cantidad total del libro ID 5
select * from libros where cantidad_disponible > (select cantidad_total from libros where id_libro = 5);

-- Libros publicados después que el más antiguo de una editorial ("Penguin")
select * from libros where anio_publicacion > (
select min(anio_publicacion) from libros where editorial = 'Penguin');
insert into libros (ISBN, titulo, anio_publicacion, editorial, edicion, cantidad_total, cantidad_disponible, clasificacion)
values ('978-0-00-000000-1', 'Antiguo Penguin', 1900, 'Penguin', 1, 5, 5, 3);
select * from libros where anio_publicacion > (
select min(anio_publicacion) from libros where editorial = 'Penguin');

-- Usuarios con email más largo que el promedio
select * from usuarios where char_length(email) > (select avg(char_length(email)) from usuarios);

-- Libros cuya edición es mayor que la edición promedio
select * from libros where edicion > (select avg(edicion) from libros);

-- Préstamos con duración mayor que el más corto
select * from prestamos where datediff(fecha_devolucion_max, fecha_prestamo) > (
select min(datediff(fecha_devolucion_max, fecha_prestamo)) from prestamos);

-- Usuarios con más de un préstamo en retraso
select * from usuarios where id_usuario in (
select id_usuario from prestamos where estado_prestamo = 'con retraso' group by id_usuario 
having count(*) > 1);
insert into prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
values 
(3, 1, '2025-01-01', '2025-01-15', 'con retraso'),
(3, 2, '2025-02-01', '2025-02-15', 'con retraso');
select * from usuarios where id_usuario in (
select id_usuario from prestamos where estado_prestamo = 'con retraso' group by id_usuario 
having count(*) > 1);

-- Préstamos cuya fecha de préstamo es anterior al registro del usuario
select * from prestamos where fecha_prestamo < (
select fecha_registro from usuarios where usuarios.id_usuario = prestamos.id_usuario);

-- Inciso b)
-- 1)
select titulo, editorial, edicion, anio_publicacion, 'No Recomendado' as Clasificacion
from libros where clasificacion = 0
union
select titulo, editorial, edicion, anio_publicacion, 'Pésimo'
from libros where clasificacion = 1
union
select titulo, editorial, edicion, anio_publicacion, 'Evitar'
from libros where clasificacion = 2
union
select titulo, editorial, edicion, anio_publicacion, 'Regular'
from libros where clasificacion = 3
union
select titulo, editorial, edicion, anio_publicacion, 'Lectura Entretenida'
from libros where clasificacion = 4
union
select titulo, editorial, edicion, anio_publicacion, 'Excelente'
from libros where clasificacion = 5
union
select titulo, editorial, edicion, anio_publicacion, 'Sin Calificación'
from libros where clasificacion not in (0,1,2,3,4,5);

-- 2)
select concat(nombre, ' ', primer_apellido, ' ', segundo_apellido) as nombre_completo,
floor(datediff(current_date, date(fecha_nacimiento))/365.25) as edad, fecha_registro,
concat('Recien ', id_rol) as informacion from usuarios 
where datediff(current_date, date(fecha_registro))/365.25 < 1
union
select concat(nombre, ' ', primer_apellido, ' ', segundo_apellido) as nombre_completo,
floor(datediff(current_date, date(fecha_nacimiento))/365.25) as edad, fecha_registro,
concat(id_rol, ' con conocimiento en el sistema') as informacion from usuarios
where datediff(current_date, date(fecha_registro))/365.25 >= 1 and
datediff(current_date, date(fecha_registro))/365.25 < 3
union
select concat(nombre, ' ', primer_apellido, ' ', segundo_apellido) as nombre_completo,
floor(datediff(current_date, date(fecha_nacimiento))/365.25) as edad, fecha_registro,
concat(id_rol, ' con experiencia') as informacion from usuarios
where datediff(current_date, date(fecha_registro))/365.25 >= 3 and
datediff(current_date, date(fecha_registro))/365.25 < 5
union
select concat(nombre, ' ', primer_apellido, ' ', segundo_apellido) as nombre_completo,
floor(datediff(current_date, date(fecha_nacimiento))/365.25) as edad, fecha_registro,
concat(id_rol, ' veterano') as informacion from usuarios
where floor(datediff(current_date, date(fecha_registro))/365.25) >= 5;
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, fecha_registro, contrasena, id_rol)
values ('Sofía', 'Ramírez', 'López', 'sofia.ramirez@example.com', '5551230001', '2000-06-15', '2025-01-12', 'Sofi1234', 2),
	('Carlos', 'Hernández', 'Ruiz', 'carlos.hernandez@example.com', '5551230002', '1995-11-03', '2023-04-25', 'CarloPwd9', 3),
    ('Ana', 'González', 'Santos', 'ana.gonzalez@example.com', '5551230003', '1990-08-20', '2021-09-30', 'AnaClave', 1),
    ('Luis', 'Torres', 'Martínez', 'luis.torres@example.com', '5551230004', '1980-03-05', '2018-03-14', 'LuisPass1', 2),
    ('María', 'Flores', 'Núñez', 'maria.flores@example.com', '5551230005', '1988-01-10', '2015-11-08', 'Mar123456', 3);

-- Inciso c)











