use biblioteca;

-- Inciso a)
-- ¿Qué fecha será dentro de una semana?
select current_date,date_add(current_date, interval 7 day) as fecha_dentro_de_una_semana;

-- Muestra " el día de hoy [11/03/2010] es [Saturday] ".
-- Donde lo que está en corchete se obtenga por comando SQL y no por texto.
select concat('El dia de hoy [', date_format(current_date, '%d/%m/%Y'), '] es [', dayname(current_date), ']');

-- Consultar todos los préstamos realizados en los últimos 7 días.
select * from prestamos where fecha_prestamo >= current_date - interval 7 day;
insert into prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
value 
(38, 5, '2025-06-15', '2025-06-30', 'devuelto');
select * from prestamos where fecha_prestamo >= current_date - interval 7 day;

-- Obtener todos los usuarios cuyo registro ocurrió en los últimos 6 meses.
select * from usuarios where fecha_registro >= current_date - interval 6 month;

-- Listar los libros cuyo año de publicación sea hace más de 10 años.
select * from libros where anio_publicacion <= current_date - interval 10 year;

-- Seleccionar todos los préstamos con retraso que debían devolverse hace más de 15 días.
select * from prestamos where estado_prestamo = 'con retraso'
and fecha_devolucion_max < current_date - interval 15 day;

-- Obtener los usuarios que cumplan años este mes.
select * from usuarios where monthname(fecha_nacimiento) = monthname(current_date);

-- Mostrar los préstamos realizados en el primer trimestre del año.
select * from prestamos where month(fecha_prestamo) between 1 and 4;

-- Listar los usuarios registrados en diciembre de cualquier año.
select * from usuarios where month(fecha_registro) = 12;
insert into usuarios (nombre, primer_apellido, segundo_apellido, email, telefono, fecha_nacimiento, fecha_registro, id_rol, contrasena)
values
('Eduardo', 'Zaragoza', null, 'eduardo.zaragoza@example.com', '5512345678', '1995-09-15', '2024-12-21', 3, 'PassEduardo123');
select * from usuarios where month(fecha_registro) = 12;

-- Mostrar los préstamos cuya fecha de préstamo fue en un fin de semana.
select * from prestamos where dayofweek(fecha_prestamo) in (1, 7);

-- Listar libros publicados en la primera mitad del año.
select * from libros where month(anio_publicacion) between 1 and 6;
alter table libros add column fecha_publicacion date;
update libros set fecha_publicacion = '1967-06-15' where id_libro = 1;
select * from libros where month(fecha_publicacion) between 1 and 6;

-- Seleccionar todos los usuarios que nacieron en los años bisiestos.
select * from usuarios where (year(fecha_nacimiento) % 4 = 0 and 
year(fecha_nacimiento) % 100 != 0) or (year(fecha_nacimiento) % 400 = 0);

-- Consultar préstamos realizados en el último trimestre del año pasado.
select * from prestamos where month(fecha_prestamo) between 9 and 
12 and year(fecha_prestamo) = year(current_date) - 1;
insert into prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo)
value 
(25, 7, '2024-11-28', '2024-12-13', 'pendiente');
select * from prestamos where month(fecha_prestamo) between 9 and 
12 and year(fecha_prestamo) = year(current_date) - 1;

-- Obtener libros publicados hace exactamente 15 años.
select * from libros where anio_publicacion = year(current_date) - 15;
insert into libros (ISBN, titulo, anio_publicacion, editorial, edicion, cantidad_total, cantidad_disponible, clasificacion) 
values ('978-1-60309-057-5', 'La Sombra del Viento: Edición Especial', 2010, 'Planeta', 1, 10, 10, 5);
select * from libros where anio_publicacion = year(current_date) - 15;

-- Listar los usuarios cuyo cumpleaños sea en los próximos 30 días.
select * from usuarios where fecha_nacimiento is not null and
date(CONCAT(year(current_date), '-', month(fecha_nacimiento), '-', day(fecha_nacimiento))) 
between current_date and date_add(current_date, interval 30 day);

-- Seleccionar los préstamos cuya fecha de préstamo fue hace más de 6 meses pero menos de 1 año.
select * from prestamos where fecha_prestamo between 
date_sub(current_date, interval 1 year) and date_sub(current_date, interval 6 month);




