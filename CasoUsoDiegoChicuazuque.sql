--CASO DE USO DE Diego Hernando Chicuazuque Castiblanco
-- En mi caso considere que el mejor caso es en el que se involucra la tabla clasificacion y partido, que son el eje central de nuestra base de datos
-- pues para que halla un partido tiene que exister un equipo, jugdores y se genera una clasificacion


--1. Se da permisos de adminstrador al personal encargado de agregar los partidos(en mi caso agregue como administrador a el usuario de mi compañero)
GRANT ADMINSTRADOR TO bd1000095494;

--2. El administrador primero quiere ver el estado actual de la clasificacion para ver si los dos equipos existen
--(esto teniendo en cuenta que ya se han jugado partidos, y ya existen los equipos en la base) haciendo uso de la vista a la cual el tiene acceso
select * from bd1000021973.clasificacionequipos where liganombre='liga 1' and TRUNC(ligafecha) = TO_DATE('2025-01-01', 'YYYY-MM-DD');
--Esto lo puede lograr debido a que tiene este permiso GRANT SELECT ON ClasificacionEquipos to ADMINISTRADORES; que le da acceso a la vista de clasificacion

--3. El administrador una vez verificado que los dos equipos existen y estan jugando la clasificacion de la temporada que el va a meter el ultimo partido
BEGIN
    GestionPartidos.agregarPartido(
        p_ligaNombre => 'Liga 1',
        p_ligaFecha => TO_DATE('2024-05-27', 'YYYY-MM-DD'),
        p_equipoLocal => 'Equipo Local',
        p_equipoVisitante => 'Equipo Visitante',
        p_golesLocal => 3,
        p_golesVisitante => 2
    );
END;
/
--4. Una vez el administrador mete el partido, el quiere ver como quedo la clasificacion actualizada
select * from bd1000021973.clasificacionequipos where liganombre='liga 1' and TRUNC(ligafecha) = TO_DATE('2025-01-01', 'YYYY-MM-DD');

--una vez esto sucede, un usuario se registra en la aplicacion(hipoteticamente) y quiere ver como va su equipo en la liga en la que esta jugando
--5. El usuario quiere ver como va su equipo en la liga
GRANT USUARIOS TO bd1000095494;
