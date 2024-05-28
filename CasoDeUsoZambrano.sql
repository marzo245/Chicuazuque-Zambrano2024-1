--Caso de uso--

--Para este caso de uso se consideraron las tablas equipo y jugador ya que son una parte importante en la base de datos y su uso es constante,
--ya que en los equipos hay una rotacion constante de jugadores entrando y saliendo, en este caso se abarcara el igreso de un nuevo jugador a un equipo existente.


--1. Otorgamos los permisos correspondientes al gerente de equipo a un usuario

GRANT GERENTE_EQUIPOS TO bd1000095494;


--para este caso el gerente del equipo quiere ingresar un nuevo fichaje al equipo por lo que hace la consulta de su equipo para saber los jugadores que tiene este
--esto gracias a los permisos del propio rol

--- Permisos sobre las tablas
--GRANT SELECT, INSERT ON CuerpoTecnico TO GERENTE_EQUIPOS;
--GRANT UPDATE ON CuerpoTecnico TO GERENTE_EQUIPOS;
--GRANT DELETE ON CuerpoTecnico TO GERENTE_EQUIPOS;
--GRANT SELECT, INSERT ON Jugador TO GERENTE_EQUIPOS;
--GRANT UPDATE ON Jugador TO GERENTE_EQUIPOS;


select * from equipo
where nombre="milan";

--ahora precede a hacer la insercion del nuevo fichaje

BEGIN
    Jugador_Package.RegistrarJugador(
        p_nombre => 'Andrea Pirlo',
        p_nit => '12346',
        p_tid => 'C.C',
        p_nacionalidad => 'Argentina',
        p_edad => 34,
        p_altura => 1.70,
        p_posicion => 'Delantero',
        p_equipo => 'milan'
    );
END;
/


--luego de ingresar al nuevo jugador realiza la siguiente consulta para verificar que el jugador esta en el equipo

SELECT * from pertenece 
where equipo='milan' AND jugadorNit='12346' AND jugadorTid='C.C'

