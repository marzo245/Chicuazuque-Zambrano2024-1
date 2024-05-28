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
COMMIT; -- confirmar la transacción después de ejecutar el procedimiento
--4. Una vez el administrador mete el partido, el quiere ver como quedo la clasificacion actualizada
select * from bd1000021973.clasificacionequipos where liganombre='liga 1' and TRUNC(ligafecha) = TO_DATE('2025-01-01', 'YYYY-MM-DD');

--una vez esto sucede, un usuario se registra en la aplicacion(hipoteticamente) y quiere ver como va su equipo en la liga en la que esta jugando
--5. El usuario quiere ver como va su equipo en la liga(Aqui se registra el primero y el back haria lo siguiente) GRANT USUARIOS TO bd1000095494;
--El back haria lo siguiente
BEGIN 
    bd1000021973.Usuario_Package.RegistrarUsuario(
        p_correo => 'juan.zambrano@mail.escuelaing.edu.co', 
        p_nombre => 'Diego Chicuazuque',
        p_fecha_nacimiento => TO_DATE('1999-01-01', 'YYYY-MM-DD')
    );
END;
/
COMMIT;-- confirmar la transacción después de ejecutar el procedimiento
-6. El usuiaro quiere ver como va su equipo en la liga
select * from bd1000021973.clasificacionequipos where liganombre='liga 1' and TRUNC(ligafecha) = TO_DATE('2025-01-01', 'YYYY-MM-DD');

select * from bd1000021973.sesion where correo = 'juan.zambrano@mail.escuelaing.edu.co';
--como el usuario solo se registro, no tiene las opcione de premium, por lo que  ve  publicidad ademas de que no puede agregar equipos o jugadores favoritos
select * from bd1000021973.gratis;

--7. el usuario se vuelve usuario premium para hacer uso de las obciones premium
--El back haria lo siguiente(aqui supuse pago una membresia por 1mes aprox por eso 2026)
BEGIN
    bd1000021973.UsuarioPremium_Package.RegistrarUsuarioPremium(
        p_correo => 'juan@mail.escuelaing.edu.co', 
        p_fecha_Fin => TO_DATE('2024-06-28', 'YYYY-MM-DD') 
    );
END;
/
COMMIT;
--8. El usuario quiere ver si ya es premium
select * from bd1000021973.pago where sesion = 'juan@mail.escuelaing.edu.co';

--9. El usuario quiere agregar un equipo favorito
--El back haria lo siguiente
