--paquete para el registro de usuarios

DECLARE
    v_correo VARCHAR2(60) := 'ejemplo@dominio.com';
    v_nombre VARCHAR2(20) := 'Usuario Ejemplo';
    v_fecha_nacimiento DATE := TO_DATE('1990-05-11', 'YYYY-MM-DD');
BEGIN
    -- Llamar al procedimiento RegistrarUsuario del paquete Usuario_Package
    Usuario_Package.RegistrarUsuario(v_correo, v_nombre, v_fecha_nacimiento);
    -- Si llega a este punto, el registro se ha realizado con éxito
    DBMS_OUTPUT.PUT_LINE('Usuario registrado correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        -- Si ocurre algún error, mostrar el mensaje de error
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



--paquete para generar registros de cuentas gratis
DECLARE
    v_correo VARCHAR2(60) := 'ejemplo@dominio.com';
BEGIN
    -- Llamar al procedimiento GenerarCuentaGratis del paquete CuentaGratis_Package
    CuentaGratis_Package.GenerarCuentaGratis(v_correo);
    -- Si llega a este punto, se ha generado la cuenta gratis con éxito
    DBMS_OUTPUT.PUT_LINE('Cuenta gratis generada correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        -- Si ocurre algún error, mostrar el mensaje de error
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



--paquete para el registro de usuarios premium(pagos)
DECLARE
    v_correo VARCHAR2(60) := 'ejemplo@dominio.com';
    v_nombre VARCHAR2(20) := 'Usuario Ejemplo';
    v_fecha_nacimiento DATE := TO_DATE('1990-05-11', 'YYYY-MM-DD');
BEGIN
    -- Llamar al procedimiento RegistrarUsuarioPremium del paquete UsuarioPremium_Package
    UsuarioPremium_Package.RegistrarUsuarioPremium(v_correo, v_nombre, v_fecha_nacimiento);
    -- Si llega a este punto, el usuario premium se ha registrado con éxito
    DBMS_OUTPUT.PUT_LINE('Usuario premium registrado correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        -- Si ocurre algún error, mostrar el mensaje de error
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



--Saber el estado actual de su suscripcion y cuanto lleva suscrito


DECLARE
    v_nombre_usuario VARCHAR2(20) := 'UsuarioEjemplo';
    v_correo_usuario VARCHAR2(60) := 'usuario@example.com';
    v_estado_suscripcion VARCHAR2(10);
    v_tiempo_suscrito INTERVAL DAY(9) TO SECOND(2);
BEGIN
    -- Llamar al procedimiento ObtenerEstadoSuscripcion del paquete EstadoSuscripcion_Package
    EstadoSuscripcion_Package.ObtenerEstadoSuscripcion(v_nombre_usuario, v_correo_usuario, v_estado_suscripcion, v_tiempo_suscrito);
    
    -- Mostrar el resultado
    DBMS_OUTPUT.PUT_LINE('Estado de suscripción: ' || v_estado_suscripcion);
    DBMS_OUTPUT.PUT_LINE('Tiempo suscrito: ' || v_tiempo_suscrito || ' días.');
EXCEPTION
    WHEN OTHERS THEN
        -- Si ocurre algún error, mostrar el mensaje de error
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


--paquete para agregar publicidad


DECLARE
    v_nombre_publicidad VARCHAR2(20) := 'PublicidadEjemplo';
    v_url_publicidad VARCHAR2(100) := 'http://ejemplo.com/publicidad';
    v_fecha_publicidad DATE := TO_DATE('2024-05-20', 'YYYY-MM-DD');
BEGIN
    -- Llamar al procedimiento AgregarPublicidad del paquete Publicidad_Package
    Publicidad_Package.AgregarPublicidad(v_nombre_publicidad, v_url_publicidad, v_fecha_publicidad);
    -- Si llega a este punto, la publicidad se ha agregado correctamente
    DBMS_OUTPUT.PUT_LINE('Publicidad agregada correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        -- Si ocurre algún error, mostrar el mensaje de error
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



--paquete para mantener la liga

DECLARE
    v_nombre_liga VARCHAR2(30) := 'LigaEjemplo';
    v_fecha_inicio DATE := TO_DATE('2024-01-01', 'YYYY-MM-DD');
    v_fecha_fin DATE := TO_DATE('2024-12-31', 'YYYY-MM-DD');
BEGIN
    -- Llamar al procedimiento MantenerLiga del paquete Liga_Package
    Liga_Package.MantenerLiga(v_nombre_liga, v_fecha_inicio, v_fecha_fin);
    -- Si llega a este punto, la información de la liga se ha actualizado correctamente
    DBMS_OUTPUT.PUT_LINE('Información de la liga actualizada correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        -- Si ocurre algún error, mostrar el mensaje de error
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



--paquete para gestionar un partido

DECLARE
    v_liga_nombre VARCHAR2(30) := 'LigaEjemplo';
    v_liga_fecha DATE := TO_DATE('2024-01-01', 'YYYY-MM-DD');
    v_equipo_local VARCHAR2(30) := 'EquipoLocal';
    v_equipo_visitante VARCHAR2(30) := 'EquipoVisitante';
    v_goles_local INT := 2;
    v_goles_visitante INT := 1;
BEGIN
    -- Llamar al procedimiento GestionarPartido del paquete Partido_Package
    Partido_Package.GestionarPartido(v_liga_nombre, v_liga_fecha, v_equipo_local, v_equipo_visitante, v_goles_local, v_goles_visitante);
    -- Si llega a este punto, el partido se ha gestionado correctamente
    DBMS_OUTPUT.PUT_LINE('Partido gestionado correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        -- Si ocurre algún error, mostrar el mensaje de error
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



--paquete para generar y mantener las estadísticas de un partido

DECLARE
    v_partido_codigo INT := 1;
    v_jugador_nit VARCHAR2(10) := '1234567890';
    v_jugador_tid CHAR(3) := 'ABC';
    v_equipo VARCHAR2(30) := 'EquipoEjemplo';
    v_asistencias INT := 2;
    v_tarjetas_amarillas INT := 1;
    v_tarjetas_rojas INT := 0;
    v_posesion_local FLOAT := 60.5;
    v_posesion_visitante FLOAT := 39.5;
BEGIN
    -- Llamar al procedimiento GenerarEstadisticasPartido del paquete EstadisticasPartido_Package
    EstadisticasPartido_Package.GenerarEstadisticasPartido(v_partido_codigo, v_jugador_nit, v_jugador_tid, v_equipo, v_asistencias, v_tarjetas_amarillas, v_tarjetas_rojas, v_posesion_local, v_posesion_visitante);
    -- Si llega a este punto, las estadísticas del partido se han generado correctamente
    DBMS_OUTPUT.PUT_LINE('Estadísticas del partido generadas correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        -- Si ocurre algún error, mostrar el mensaje de error
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



--paquete para gestionar la clasificación de los equipos después de un partido


DECLARE
    v_liga_nombre VARCHAR2(30) := 'LigaEjemplo';
    v_liga_fecha DATE := TO_DATE('2024-05-11', 'YYYY-MM-DD'); -- Fecha del partido
    v_equipo VARCHAR2(30) := 'EquipoEjemplo';
    v_puesto INT := 1; -- Puesto en la clasificación
    v_partidos_ganados INT := 2;
    v_partidos_empatados INT := 1;
    v_partidos_perdidos INT := 1;
    v_puntos INT := 7;
BEGIN
    -- Llamar al procedimiento GestionarClasificacion del paquete Clasificacion_Package
    Clasificacion_Package.GestionarClasificacion(v_liga_nombre, v_liga_fecha, v_equipo, v_puesto, v_partidos_ganados, v_partidos_empatados, v_partidos_perdidos, v_puntos);
    -- Si llega a este punto, la clasificación del equipo se ha gestionado correctamente
    DBMS_OUTPUT.PUT_LINE('Clasificación del equipo gestionada correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        -- Si ocurre algún error, mostrar el mensaje de error
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



--paquete para que un gerente de equipo pueda registrar su equipo


CREATE OR REPLACE PACKAGE RegistroEquipo_Package AS
PROCEDURE RegistrarEquipo(
    p_nombre VARCHAR(30),
    p_ciudad VARCHAR(20),
    p_estadio VARCHAR(30),
    p_dueno VARCHAR(20)
);
END RegistroEquipo_Package;
/

CREATE OR REPLACE PACKAGE BODY RegistroEquipo_Package AS
PROCEDURE RegistrarEquipo(
    p_nombre VARCHAR(30),
    p_ciudad VARCHAR(20),
    p_estadio VARCHAR(30),
    p_dueno VARCHAR(20)
) IS
BEGIN
    -- Verificar si el equipo ya existe
    IF EXISTS (SELECT 1 FROM Equipo WHERE nombre = p_nombre) THEN
        RAISE EXCEPTION 'El equipo ya está registrado en la base de datos.';
    END IF;

    -- Insertar el nuevo equipo
    INSERT INTO Equipo (nombre, ciudad, estadio, dueño)
    VALUES (p_nombre, p_ciudad, p_estadio, p_dueno);

    -- Si llega a este punto, el equipo se ha registrado correctamente
    DBMS_OUTPUT.PUT_LINE('Equipo registrado correctamente.');
END RegistrarEquipo;
END RegistroEquipo_Package;
/



--paquete para registrar a alguien en el cuerpo tecnico 


-- Registrar un nuevo miembro del cuerpo técnico
BEGIN
    CuerpoTecnico_Package.RegistrarCuerpoTecnico(
        p_nombre => 'Juan Pérez',
        p_tid => '001',
        p_nid => '123456789',
        p_nacionalidad => 'Español',
        p_cargo => 'Entrenador',
        p_equipo => 'Real Madrid'
    );
END;

-- Modificar el equipo asociado a un miembro del cuerpo técnico
BEGIN
    CuerpoTecnico_Package.ModificarEquipoCuerpoTecnico(
        p_tid => '001',
        p_equipo => 'Barcelona'
    );
END;

-- Eliminar un miembro del cuerpo técnico
BEGIN
    CuerpoTecnico_Package.EliminarCuerpoTecnico(
        p_tid => '001'
    );
END;





--paquete para que un gerente de equipo pueda registrar sus jugadores

-- Registrar un nuevo jugador
BEGIN
    Jugador_Package.RegistrarJugador(
        p_nombre => 'Lionel Messi',
        p_nit => '1234567890',
        p_tid => '001',
        p_nacionalidad => 'Argentino',
        p_edad => 34,
        p_altura => 1.70,
        p_posicion => 'Delantero',
        p_equipo => 'Paris Saint-Germain'
    );
END;

-- Modificar el equipo asociado a un jugador
BEGIN
    Jugador_Package.ModificarEquipoJugador(
        p_nit => '1234567890',
        p_tid => '001',
        p_equipo => 'Barcelona'
    );
END;







--Consultar el promedio de usuarios premium por mes--

-- Insertar algunos datos de suscripciones para probar el cálculo del promedio
INSERT INTO Suscripciones (fecha) VALUES (TO_DATE('2024-01-15', 'YYYY-MM-DD'));
INSERT INTO Suscripciones (fecha) VALUES (TO_DATE('2024-01-20', 'YYYY-MM-DD'));
INSERT INTO Suscripciones (fecha) VALUES (TO_DATE('2024-02-10', 'YYYY-MM-DD'));
INSERT INTO Suscripciones (fecha) VALUES (TO_DATE('2024-02-25', 'YYYY-MM-DD'));
INSERT INTO Suscripciones (fecha) VALUES (TO_DATE('2024-03-05', 'YYYY-MM-DD'));
INSERT INTO Suscripciones (fecha) VALUES (TO_DATE('2024-04-12', 'YYYY-MM-DD'));

-- Ejecutar el procedimiento para calcular el promedio de suscripciones por mes
BEGIN
    PromedioSuscripciones_Package.CalcularPromedioSuscripciones;
END;





--paquete para que un gerente de equipo pueda registrar sus jugadores

-- Insertar un nuevo jugador
BEGIN
    Jugador_Package.RegistrarJugador(
        p_nombre => 'Juan Perez',
        p_nit => '1234567890',
        p_tid => 'ABC',
        p_nacionalidad => 'Argentina',
        p_edad => 25,
        p_altura => 1.80,
        p_posicion => 'Delantero',
        p_equipo => 'Equipo A'
    );
END;
/

-- Modificar el equipo al que está ligado un jugador existente
BEGIN
    Jugador_Package.ModificarEquipoJugador(
        p_nit => '1234567890',
        p_tid => 'ABC',
        p_equipo => 'Equipo B'
    );
END;
/



--Consultar el promedio de usuarios premium por mes--



-- Insertar datos de suscripciones en la tabla Suscripciones
INSERT INTO Suscripciones (fecha, usuario_id) VALUES (TO_DATE('2024-05-01', 'YYYY-MM-DD'), 1);
INSERT INTO Suscripciones (fecha, usuario_id) VALUES (TO_DATE('2024-05-05', 'YYYY-MM-DD'), 2);
INSERT INTO Suscripciones (fecha, usuario_id) VALUES (TO_DATE('2024-06-02', 'YYYY-MM-DD'), 3);
INSERT INTO Suscripciones (fecha, usuario_id) VALUES (TO_DATE('2024-06-10', 'YYYY-MM-DD'), 4);
-- Puedes seguir insertando más datos según sea necesario

-- Llamar al procedimiento para calcular el promedio de suscripciones por mes
BEGIN
    PromedioSuscripciones_Package.CalcularPromedioSuscripciones;
END;
/




--Consultas el promedio de su equipo durante una temporada--


-- Insertar datos de equipos
INSERT INTO Equipo (nombre, ciudad, estadio, dueno) 
VALUES ('Equipo A', 'Ciudad A', 'Estadio A', 'Dueño A');

INSERT INTO Equipo (nombre, ciudad, estadio, dueno) 
VALUES ('Equipo B', 'Ciudad B', 'Estadio B', 'Dueño B');

-- Insertar datos de partidos
INSERT INTO Partido (ligaFecha, equipoLocal, equipoVisitante, golesLocal, golesVisitante)
VALUES (TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'Equipo A', 'Equipo B', 2, 1);

INSERT INTO Partido (ligaFecha, equipoLocal, equipoVisitante, golesLocal, golesVisitante)
VALUES (TO_DATE('2024-01-05', 'YYYY-MM-DD'), 'Equipo B', 'Equipo A', 0, 3);


DECLARE
    v_temporada_inicio DATE := TO_DATE('2024-01-01', 'YYYY-MM-DD');
    v_temporada_fin DATE := TO_DATE('2024-12-31', 'YYYY-MM-DD');
BEGIN
    DesempeñoEquipo_Package.ObtenerDesempeñoEquipo('Equipo A', v_temporada_inicio, v_temporada_fin);
END;
