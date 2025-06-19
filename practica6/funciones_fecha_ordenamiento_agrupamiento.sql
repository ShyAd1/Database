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


-- Inciso b)
-- Muestra a las personas ordenados alfabéticamente por nombre.
select * from usuarios order by nombre;

-- Muestra las primeras 3 personas que son lectores
select * from usuarios where id_rol = 3 order by nombre limit 3;

-- Obtener los 10 usuarios más recientes registrados en el sistema:
select * from usuarios order by fecha_registro desc limit 10;

-- Listar los 5 libros más prestados en el sistema
select libros.id_libro, libros.titulo, count(*) as veces_prestado from libros, prestamos
where libros.id_libro = prestamos.id_libro group by libros.id_libro, libros.titulo
order by veces_prestado desc limit 5;

-- Listar los 10 libros publicados más recientemente
select * from libros order by anio_publicacion desc limit 10;

-- Mostrar las primeras 15 multas generadas en el sistema, ordenadas por fecha
select * from multas order by fecha_multa asc limit 15;
insert into multas (id_prestamo, monto, pagado, fecha_multa) values
(1, 50.00, 0, '2024-12-01'),
(2, 25.50, 1, '2024-11-25'),
(3, 10.00, 1, '2024-11-30'),
(4, 15.75, 0, '2024-12-10'),
(5, 20.00, 1, '2024-11-20'),
(6, 5.00, 0, '2024-12-03'),
(7, 35.00, 1, '2024-12-04'),
(8, 60.00, 0, '2024-11-18'),
(9, 40.00, 1, '2024-12-08'),
(10, 18.00, 0, '2024-12-05'),
(11, 22.25, 0, '2024-11-28'),
(12, 12.00, 1, '2024-12-02'),
(13, 45.00, 0, '2024-11-30'),
(14, 27.50, 1, '2024-11-27'),
(15, 30.00, 0, '2024-12-06');
select * from multas order by fecha_multa asc limit 15;

-- Obtener los 5 autores con más libros registrados en el sistema
select autores.id_autor, autores.nombre_autor, count(*) as libros_registrados from autores, libroautor
where autores.id_autor = libroautor.id_autor group by autores.id_autor, autores.nombre_autor
order by libros_registrados desc limit 5;

-- Listar los 8 libros más antiguos disponibles en la biblioteca
select * from libros order by anio_publicacion asc limit 8;

-- Obtener los primeros 10 préstamos más recientes en el sistema
select * from prestamos order by fecha_prestamo desc limit 10;

-- Mostrar los 5 usuarios con las contraseñas más largas, ordenados de mayor a menor longitud
select *, char_length(contrasena) from usuarios order by char_length(contrasena) desc limit 5;

-- Obtener las primeras 10 editoriales con más libros publicados, ordenadas alfabéticamente
select * from(select editorial, count(*) as libros_publicados from libros group by editorial
order by libros_publicados desc limit 10) as top_editoriales order by editorial asc;

-- Listar los 12 primeros libros clasificados con la puntuación más alta
select * from libros order by clasificacion desc limit 12;

-- Mostrar las 15 primeras devoluciones que se hicieron más rápidamente después del préstamo
select d.id_devolucion, d.id_prestamo, p.id_usuario, p.id_libro, p.fecha_prestamo, 
d.fecha_devolucion, datediff(d.fecha_devolucion, p.fecha_prestamo) AS dias_para_devolver
from devoluciones d, prestamos p where d.id_prestamo = p.id_prestamo
order by dias_para_devolver asc limit 15;

-- Listar los 5 libros más prestados en los últimos 6 meses, ordenados por la cantidad de préstamos
select libros.id_libro, libros.titulo, count(*) as veces_prestado from libros, prestamos
where libros.id_libro = prestamos.id_libro and fecha_prestamo between date_sub(current_date, interval 6 month) 
and current_date group by libros.id_libro, libros.titulo order by veces_prestado desc limit 5;
insert into prestamos (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_max, estado_prestamo) values
(12, 1, '2025-05-15', '2025-05-29', 'devuelto'),
(37, 2, '2025-06-01', '2025-06-15', 'pendiente'),
(5, 4,  '2025-04-10', '2025-04-24', 'con retraso'),
(23, 3, '2025-03-22', '2025-04-05', 'devuelto'),
(58, 5, '2025-02-12', '2025-02-26', 'devuelto');
select libros.id_libro, libros.titulo, count(*) as veces_prestado from libros, prestamos
where libros.id_libro = prestamos.id_libro and fecha_prestamo between date_sub(current_date, interval 6 month) 
and current_date group by libros.id_libro, libros.titulo order by veces_prestado desc limit 5;

-- Inciso c)
-- ¿Cuántas personas estan registradas de cada rol tenemos?
-- Obtener la cantidad de préstamos por estado de préstamo (pendiente, retraso, devuelto)
-- Obtener el número total de libros prestados por editorial
-- Calcular la multa promedio por usuario para préstamos con estado retraso
-- Mostrar el total de libros disponibles y prestados, agrupados por año de publicación
-- Contar la cantidad de usuarios por rango de edad usando CASE y agrupar los resultados
-- Calcular el promedio de días de retraso en devoluciones agrupado por el estado del préstamo
-- Contar la cantidad de libros por clasificación (de 0 a 5 estrellas)
-- Calcular el número de devoluciones por mes en el último año
-- Mostrar el número de libros prestados en los últimos 6 meses, agrupados por editorial
-- Calcular el número promedio de días que tarda en devolver los libros cada usuario



