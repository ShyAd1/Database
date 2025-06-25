-- Vista donde se refleje cuales son los docentes asignados 
-- a que viajes y de donde son los docentes (en el origen)
create view Vista_Docentes_Viajes_Origen as
select d.nombre as nombre_docente, d.aPaterno as apellido_paterno, 
d.aMaterno as apellido_materno, v.nombreViaje as nombre_viaje, 
o.nombreEscuela as escuela_origen from docentes d left join docentesACargo dc on 
d.idDocente = dc.idDocente left join detallesViaje dv on
dc.idDetalle = dv.idDetalle left join viajes v on dv.idViaje = v.idViaje 
left join origenes o on v.idOrigen = o.idOrigen;
-- Probar la vista
select * from Vista_Docentes_Viajes_Origen;

-- Generar un trigger qué actualice si el viaje se realiza ese 
-- dia, y si aun no se ha realizado el pago cambiar el estado que tiene 
-- a rechazado siempre y cuando el estado ya esté autorizado
create or replace function unDia_cambiarEstado()
returns trigger as $$
begin
	if new.fechaInicio = current_date then
		update Autorizaciones
        set estado = 'Rechazado'
        where estado = 'Autorizado'
		and idAutorizacion in (
            select est.idAutorizacion
            from DetallesViaje dv
            join Estudiantes est on dv.idEstudiante = est.idEstudiante
            left join Pagos p on est.idEstudiante = p.idEstudiante
            where dv.idViaje = NEW.idViaje
            and p.idPago is null
        );
    end if;

    return null; 
end;
$$ language plpgsql;	

create trigger updateviaje
after insert or update on viajes
for each row
execute function unDia_cambiarEstado()
-- Checar cambios en la tabla autorizaciones
select * from Autorizaciones;


-- Realizar una función donde indique el monto total, destino y origen 
-- del viaje a partir del id
create or replace function info_viaje_completo(p_idViaje INTEGER)
returns table (
    monto_total BIGINT,
    destino VARCHAR,
    origen VARCHAR
) as $$
begin
    return query
    select 
        sum(dv.costoTotal) as monto_total,
        d.nombreEstablecimiento as destino,
        o.nombreEscuela as origen
    from DetallesViaje dv
    join Viajes v on dv.idViaje = v.idViaje
    join Destinos d on v.idDestino = d.idDestino
    join Origenes o on v.idOrigen = o.idOrigen
    where v.idViaje = p_idViaje
    group by d.nombreEstablecimiento, o.nombreEscuela;
end;
$$ language plpgsql;
-- Probar la funcion
select * from info_viaje_completo(2);


-- Generar una vista donde visualice la información de cada alumno 
-- y viaje donde fue autorizado 
create view Vista_Alumnos_Viajes_Autorizados as
select e.idEstudiante, e.nombre AS nombre_estudiante, e.aPaterno, 
e.aMaterno, v.idViaje, v.nombreViaje, v.descripcion, v.fechaInicio, 
v.fechaFin from estudiantes e join autorizaciones a on
e.idAutorizacion = a.idAutorizacion join detallesViaje dv on
e.idEstudiante = dv.idEstudiante join viajes v on
dv.idViaje = v.idViaje where a.estado = 'Autorizado';
-- Probar la vista
select * from Vista_Alumnos_Viajes_Autorizados;


-- Presentar a cuantos viajes ha sido asignado cada docente
select count(*) as cantidad_viajes, d.nombre, d.aPaterno from docentes d
join docentesACargo dc on d.idDocente = dc.idDocente join
detallesViaje dv on dc.idDetalle = dv.idDetalle join viajes v on
dv.idViaje = v.idViaje group by d.nombre, d.aPaterno;



