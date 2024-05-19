--USUARIO--

-- Crear el paquete para el registro de usuarios
CREATE OR REPLACE PACKAGE Usuario_Package AS
PROCEDURE RegistrarUsuario(
    p_correo VARCHAR(60),
    p_nombre VARCHAR(20),
    p_fecha_nacimiento DATE
);
END Usuario_Package;
/

CREATE OR REPLACE PACKAGE BODY Usuario_Package AS

PROCEDURE RegistrarUsuario(
    p_correo VARCHAR(60),
    p_nombre VARCHAR(20),
    p_fecha_nacimiento DATE
) IS
BEGIN
   
    IF p_correo !~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$' THEN
        RAISE EXCEPTION 'El correo electrónico proporcionado no es válido.';
    END IF;

    
    IF p_fecha_nacimiento >= CURRENT_DATE - INTERVAL '16 years' THEN
        RAISE EXCEPTION 'Debe ser mayor de 16 años para registrarse.';
    END IF;

    INSERT INTO Sesion (correo, nombre, fechaNacimineto)
    VALUES (p_correo, p_nombre, p_fecha_nacimiento);
END RegistrarUsuario;
END Usuario_Package;
/


-- Crear el paquete para generar registros de cuentas gratis
CREATE OR REPLACE PACKAGE CuentaGratis_Package AS
PROCEDURE GenerarCuentaGratis(
    p_correo VARCHAR(60)
);
END CuentaGratis_Package;
/

CREATE OR REPLACE PACKAGE BODY CuentaGratis_Package AS
PROCEDURE GenerarCuentaGratis(
    p_correo VARCHAR(60)
) IS
BEGIN
    INSERT INTO Gratis (sesion)
    VALUES (p_correo);
END GenerarCuentaGratis;
END CuentaGratis_Package;
/

-- Crear el paquete para el registro de usuarios premium(pagos)


CREATE OR REPLACE PACKAGE UsuarioPremium_Package AS
PROCEDURE RegistrarUsuarioPremium(
    p_correo VARCHAR(60),
    p_nombre VARCHAR(20),
    p_fecha_nacimiento DATE
);
END UsuarioPremium_Package;
/
CREATE OR REPLACE PACKAGE BODY UsuarioPremium_Package AS
PROCEDURE RegistrarUsuarioPremium(
    p_correo VARCHAR(60),
    p_nombre VARCHAR(20),
    p_fecha_nacimiento DATE
) IS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Sesion WHERE correo = p_correo) THEN
        RAISE EXCEPTION 'El correo proporcionado no cumple con los criterios de tipo correo o no existe en la base de datos.';
    END IF;

    IF p_fecha_nacimiento >= CURRENT_DATE - INTERVAL '16 years' THEN
        RAISE EXCEPTION 'Debe ser mayor de 16 años para registrarse como usuario premium.';
    END IF;

    IF EXISTS (SELECT 1 FROM Pago WHERE sesion = p_correo) THEN
        RAISE EXCEPTION 'El correo ya está registrado como usuario premium.';
    END IF;

    INSERT INTO Pago (sesion, fechaIncio, fechaFin)
    VALUES (p_correo, CURRENT_DATE, NULL);
END RegistrarUsuarioPremium;
END UsuarioPremium_Package;
/

--paquete para Saber el estado actual de su suscripcion y cuanto lleva suscrito--


CREATE OR REPLACE PACKAGE EstadoSuscripcion_Package AS
-- Declarar el procedimiento para obtener el estado actual de la suscripción de un usuario y el tiempo que lleva suscrito
PROCEDURE ObtenerEstadoSuscripcion(
    p_nombre_usuario VARCHAR2,
    p_correo_usuario VARCHAR2,
    o_estado_suscripcion VARCHAR2,
    o_tiempo_suscrito INTERVAL DAY(9) TO SECOND(2)
);
END EstadoSuscripcion_Package;
/

CREATE OR REPLACE PACKAGE BODY EstadoSuscripcion_Package AS
-- Implementar el procedimiento para obtener el estado actual de la suscripción de un usuario y el tiempo que lleva suscrito
PROCEDURE ObtenerEstadoSuscripcion(
    p_nombre_usuario VARCHAR2,
    p_correo_usuario VARCHAR2,
    o_estado_suscripcion VARCHAR2,
    o_tiempo_suscrito INTERVAL DAY(9) TO SECOND(2)
) IS
    v_fecha_inicio DATE;
    v_fecha_fin DATE;
BEGIN
    -- Obtener las fechas de inicio y fin de la suscripción del usuario
    SELECT fechaInicio, fechaFin INTO v_fecha_inicio, v_fecha_fin
    FROM Pago
    WHERE nombre = p_nombre_usuario;

    -- Calcular el estado de la suscripción
    IF SYSDATE BETWEEN v_fecha_inicio AND v_fecha_fin THEN
        o_estado_suscripcion := 'Activa';
    ELSE
        o_estado_suscripcion := 'Inactiva';
    END IF;

    -- Calcular el tiempo que lleva suscrito
    o_tiempo_suscrito := SYSDATE - v_fecha_inicio;
END ObtenerEstadoSuscripcion;
END EstadoSuscripcion_Package;
/




--ADMINISTRADOR--


-- Crear el paquete para agregar publicidad

CREATE OR REPLACE PACKAGE Publicidad_Package AS
PROCEDURE AgregarPublicidad(
    p_nombre VARCHAR(20),
    p_url VARCHAR(100),
    p_fecha DATE
);
END Publicidad_Package;
/

CREATE OR REPLACE PACKAGE BODY Publicidad_Package AS
PROCEDURE AgregarPublicidad(
    p_nombre VARCHAR(20),
    p_url VARCHAR(100),
    p_fecha DATE
) IS
BEGIN
    IF POSITION('http://' IN p_url) <> 1 THEN
        RAISE EXCEPTION 'La URL debe cumplir con el protocolo HTTP.';
    END IF;

    IF p_fecha <= CURRENT_DATE THEN
        RAISE EXCEPTION 'La fecha debe ser posterior a la fecha actual.';
    END IF;

    INSERT INTO Publicidad (nombre, URL)
    VALUES (p_nombre, p_url);
END AgregarPublicidad;
END Publicidad_Package;
/


-- Crear el paquete para mantener la liga

CREATE OR REPLACE PACKAGE Liga_Package AS
PROCEDURE MantenerLiga(
    p_nombre VARCHAR(30),
    p_fecha_inicio DATE,
    p_fecha_fin DATE
);
END Liga_Package;
/

CREATE OR REPLACE PACKAGE BODY Liga_Package AS
PROCEDURE MantenerLiga(
    p_nombre VARCHAR(30),
    p_fecha_inicio DATE,
    p_fecha_fin DATE
) IS
BEGIN
    IF p_fecha_fin < p_fecha_inicio THEN
        RAISE EXCEPTION 'La fecha de fin no puede ser anterior a la fecha de inicio.';
    END IF;

    UPDATE Liga
    SET fechaFin = p_fecha_fin
    WHERE nombre = p_nombre AND fechaInicio = p_fecha_inicio;
END MantenerLiga;
END Liga_Package;
/



-- Crear el paquete para gestionar un partido


CREATE OR REPLACE PACKAGE Partido_Package AS
PROCEDURE GestionarPartido(
    p_liga_nombre VARCHAR(30),
    p_liga_fecha DATE,
    p_equipo_local VARCHAR(30),
    p_equipo_visitante VARCHAR(30),
    p_goles_local INT,
    p_goles_visitante INT
);
END Partido_Package;
/

CREATE OR REPLACE PACKAGE BODY Partido_Package AS
PROCEDURE GestionarPartido(
    p_liga_nombre VARCHAR(30),
    p_liga_fecha DATE,
    p_equipo_local VARCHAR(30),
    p_equipo_visitante VARCHAR(30),
    p_goles_local INT,
    p_goles_visitante INT
) IS
    v_codigo_partido INT;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Liga WHERE nombre = p_liga_nombre AND fechaInicio = p_liga_fecha) THEN
        RAISE EXCEPTION 'La liga especificada no existe.';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Equipo WHERE nombre = p_equipo_local) THEN
        RAISE EXCEPTION 'El equipo local especificado no existe.';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Equipo WHERE nombre = p_equipo_visitante) THEN
        RAISE EXCEPTION 'El equipo visitante especificado no existe.';
    END IF;

    IF p_goles_local < 0 OR p_goles_visitante < 0 THEN
        RAISE EXCEPTION 'Los goles no pueden ser menores a 0.';
    END IF;

    IF (SELECT COUNT(*) FROM Pertenece WHERE equipo = p_equipo_local AND fechaInicio <= p_liga_fecha AND fechaFin >= p_liga_fecha) < 11 THEN
        RAISE EXCEPTION 'El equipo local no tiene suficientes jugadores para jugar el partido.';
    END IF;

    IF (SELECT COUNT(*) FROM Pertenece WHERE equipo = p_equipo_visitante AND fechaInicio <= p_liga_fecha AND fechaFin >= p_liga_fecha) < 11 THEN
        RAISE EXCEPTION 'El equipo visitante no tiene suficientes jugadores para jugar el partido.';
    END IF;

    IF (SELECT COUNT(*) FROM Pertenece WHERE equipo = p_equipo_local AND fechaInicio <= p_liga_fecha AND fechaFin >= p_liga_fecha) > 20 THEN
        RAISE EXCEPTION 'El equipo local tiene demasiados jugadores para jugar el partido.';
    END IF;

    IF (SELECT COUNT(*) FROM Pertenece WHERE equipo = p_equipo_visitante AND fechaInicio <= p_liga_fecha AND fechaFin >= p_liga_fecha) > 20 THEN
        RAISE EXCEPTION 'El equipo visitante tiene demasiados jugadores para jugar el partido.';
    END IF;

    SELECT COALESCE(MAX(codigo), 0) + 1 INTO v_codigo_partido FROM Partido;

    INSERT INTO Partido (codigo, ligaNombre, ligaFecha, equipoLocal, equipoVisitante, golesLocal, golesVisitante)
    VALUES (v_codigo_partido, p_liga_nombre, p_liga_fecha, p_equipo_local, p_equipo_visitante, p_goles_local, p_goles_visitante);
END GestionarPartido;
END Partido_Package;
/


-- Crear el paquete para generar y mantener las estadísticas de un partido

CREATE OR REPLACE PACKAGE EstadisticasPartido_Package AS
PROCEDURE GenerarEstadisticasPartido(
    p_partido_codigo INT,
    p_jugador_nit VARCHAR(10),
    p_jugador_tid CHAR(3),
    p_equipo VARCHAR(30),
    p_asistencias INT,
    p_tarjetas_amarillas INT,
    p_tarjetas_rojas INT,
    p_posesion_local FLOAT,
    p_posesion_visitante FLOAT
);
END EstadisticasPartido_Package;
/

CREATE OR REPLACE PACKAGE BODY EstadisticasPartido_Package AS
PROCEDURE GenerarEstadisticasPartido(
    p_partido_codigo INT,
    p_jugador_nit VARCHAR(10),
    p_jugador_tid CHAR(3),
    p_equipo VARCHAR(30),
    p_asistencias INT,
    p_tarjetas_amarillas INT,
    p_tarjetas_rojas INT,
    p_posesion_local FLOAT,
    p_posesion_visitante FLOAT
) IS
    v_consecutivo INT;
BEGIN
    SELECT COALESCE(MAX(partidoCodigo), 0) + 1 INTO v_consecutivo FROM Estadisticas;

    INSERT INTO Estadisticas (partidoCodigo, jugadorNit, jugadorTid, equipo, asistencias, tarjetasAmarillas, tarjetasRojas, posesionLocal, posesionVisitante)
    VALUES (p_partido_codigo, p_jugador_nit, p_jugador_tid, p_equipo, p_asistencias, p_tarjetas_amarillas, p_tarjetas_rojas, p_posesion_local, p_posesion_visitante);
END GenerarEstadisticasPartido;
END EstadisticasPartido_Package;
/


-- Crear el paquete para gestionar la clasificación de los equipos después de un partido

CREATE OR REPLACE PACKAGE Clasificacion_Package AS
PROCEDURE GestionarClasificacion(
    p_liga_nombre VARCHAR(30),
    p_liga_fecha DATE,
    p_equipo VARCHAR(30),
    p_puesto INT,
    p_partidos_ganados INT,
    p_partidos_empatados INT,
    p_partidos_perdidos INT,
    p_puntos INT
);
END Clasificacion_Package;
/
CREATE OR REPLACE PACKAGE BODY Clasificacion_Package AS
PROCEDURE GestionarClasificacion(
    p_liga_nombre VARCHAR(30),
    p_liga_fecha DATE,
    p_equipo VARCHAR(30),
    p_puesto INT,
    p_partidos_ganados INT,
    p_partidos_empatados INT,
    p_partidos_perdidos INT,
    p_puntos INT
) IS
    v_consecutivo INT;
BEGIN
    SELECT COALESCE(MAX(puesto), 0) + 1 INTO v_consecutivo FROM Clasificacion;

    INSERT INTO Clasificacion (ligaNombre, ligaFecha, equipo, puesto, partidosGanados, partidosEmpatados, partidosPerdidos, puntos)
    VALUES (p_liga_nombre, p_liga_fecha, p_equipo, p_puesto, p_partidos_ganados, p_partidos_empatados, p_partidos_perdidos, p_puntos);
END GestionarClasificacion;
END Clasificacion_Package;
/



--GERENTE DE EQUIPO--

-- Crear el paquete para que un gerente de equipo pueda registrar su equipo
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

    RAISE EXCEPTION 'No se puede registrar un equipo directamente a través de este paquete. Por favor, utiliza una sentencia INSERT INTO en SQL para agregar un nuevo equipo.';
END RegistrarEquipo;
END RegistroEquipo_Package;
/



CREATE OR REPLACE PACKAGE CuerpoTecnico_Package AS
PROCEDURE RegistrarCuerpoTecnico(
    p_nombre VARCHAR(50),
    p_tid CHAR(3),
    p_nid VARCHAR(20),
    p_nacionalidad VARCHAR(20),
    p_cargo VARCHAR(20),
    p_equipo VARCHAR(30)
);

PROCEDURE ModificarEquipoCuerpoTecnico(
    p_tid CHAR(3),
    p_equipo VARCHAR(30)
);



PROCEDURE EliminarCuerpoTecnico(
    p_tid CHAR(3)
);
END CuerpoTecnico_Package;
/

CREATE OR REPLACE PACKAGE BODY CuerpoTecnico_Package AS
PROCEDURE RegistrarCuerpoTecnico(
    p_nombre VARCHAR(50),
    p_tid CHAR(3),
    p_nid VARCHAR(20),
    p_nacionalidad VARCHAR(20),
    p_cargo VARCHAR(20),
    p_equipo VARCHAR(30)
) IS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Equipo WHERE nombre = p_equipo) THEN
        RAISE EXCEPTION 'El equipo especificado no existe.';
    END IF;

    INSERT INTO CuerpoTecnico (nombre, tid, nid, nacionalidad, cargo, equipo)
    VALUES (p_nombre, p_tid, p_nid, p_nacionalidad, p_cargo, p_equipo);
END RegistrarCuerpoTecnico;

PROCEDURE ModificarEquipoCuerpoTecnico(
    p_tid CHAR(3),
    p_equipo VARCHAR(30)
) IS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Equipo WHERE nombre = p_equipo) THEN
        RAISE EXCEPTION 'El equipo especificado no existe.';
    END IF;

    UPDATE CuerpoTecnico
    SET equipo = p_equipo
    WHERE tid = p_tid;
END ModificarEquipoCuerpoTecnico;


PROCEDURE EliminarCuerpoTecnico(
    p_tid CHAR(3)
) IS
BEGIN
    DELETE FROM CuerpoTecnico
    WHERE tid = p_tid;
END EliminarCuerpoTecnico;
END CuerpoTecnico_Package;
/



-- Crear el paquete para que un gerente de equipo pueda registrar sus jugadores
CREATE OR REPLACE PACKAGE Jugador_Package AS
-- Declarar el procedimiento para que un gerente de equipo pueda registrar sus jugadores
PROCEDURE RegistrarJugador(
    p_nombre VARCHAR(50),
    p_nit VARCHAR(10),
    p_tid CHAR(3),
    p_nacionalidad VARCHAR(20),
    p_edad INT,
    p_altura FLOAT,
    p_posicion VARCHAR(16),
    p_equipo VARCHAR(30)
);


-- Declarar el procedimiento para que un gerente de equipo pueda modificar el equipo al que está ligado un jugador

PROCEDURE ModificarEquipoJugador(
    p_nit VARCHAR(10),
    p_tid CHAR(3),
    p_equipo VARCHAR(30)
);
END Jugador_Package;
/

CREATE OR REPLACE PACKAGE BODY Jugador_Package AS
PROCEDURE RegistrarJugador(
    p_nombre VARCHAR(50),
    p_nit VARCHAR(10),
    p_tid CHAR(3),
    p_nacionalidad VARCHAR(20),
    p_edad INT,
    p_altura FLOAT,
    p_posicion VARCHAR(16),
    p_equipo VARCHAR(30)
) IS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Equipo WHERE nombre = p_equipo) THEN
        RAISE EXCEPTION 'El equipo especificado no existe.';
    END IF;

    INSERT INTO Jugador (nombre, nit, tid, nacionalidad, edad, altura, posicion)
    VALUES (p_nombre, p_nit, p_tid, p_nacionalidad, p_edad, p_altura, p_posicion);

    INSERT INTO Pertenece (jugadorNit, jugadorTid, equipo, fechaInicio, fechaFin)
    VALUES (p_nit, p_tid, p_equipo, SYSDATE, NULL);
END RegistrarJugador;

PROCEDURE ModificarEquipoJugador(
    p_nit VARCHAR(10),
    p_tid CHAR(3),
    p_equipo VARCHAR(30)
) IS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Equipo WHERE nombre = p_equipo) THEN
        RAISE EXCEPTION 'El equipo especificado no existe.';
    END IF;

    UPDATE Pertenece
    SET equipo = p_equipo
    WHERE jugadorNit = p_nit AND jugadorTid = p_tid;
END ModificarEquipoJugador;
END Jugador_Package;
/


--GERENTE APP(ORGANIZACION)--


--paquete para Consultar el promedio de usuarios premium por mes--

CREATE OR REPLACE PACKAGE PromedioSuscripciones_Package AS
-- Declarar el procedimiento para calcular el promedio de suscripciones por mes
PROCEDURE CalcularPromedioSuscripciones;
END PromedioSuscripciones_Package;
/

CREATE OR REPLACE PACKAGE BODY PromedioSuscripciones_Package AS
-- Implementar el procedimiento para calcular el promedio de suscripciones por mes
PROCEDURE CalcularPromedioSuscripciones IS
    TYPE SuscripcionesCursor IS REF CURSOR;
    v_mes_anio VARCHAR(7);
    v_total_suscripciones NUMBER;
    v_promedio_suscripciones NUMBER;
BEGIN
    -- Abrir un cursor para obtener el total de suscripciones por mes
    FOR mes_cursor IN (SELECT TO_CHAR(fecha, 'MM-YYYY') AS mes_anio,
                              COUNT(*) AS total_suscripciones
                       FROM Suscripciones
                       GROUP BY TO_CHAR(fecha, 'MM-YYYY')
                       ORDER BY TO_DATE(TO_CHAR(fecha, 'MM-YYYY'), 'MM-YYYY')) LOOP
        -- Obtener los valores del cursor
        v_mes_anio := mes_cursor.mes_anio;
        v_total_suscripciones := mes_cursor.total_suscripciones;

        -- Calcular el promedio de suscripciones por mes
        SELECT AVG(total_suscripciones) INTO v_promedio_suscripciones
        FROM (SELECT COUNT(*) AS total_suscripciones
              FROM Suscripciones
              GROUP BY TO_CHAR(fecha, 'MM-YYYY'));

        -- Imprimir el resultado
        DBMS_OUTPUT.PUT_LINE('Mes y año: ' || v_mes_anio || ', Total de suscripciones: ' || v_total_suscripciones);
    END LOOP;

    -- Imprimir el promedio de suscripciones por mes
    DBMS_OUTPUT.PUT_LINE('Promedio de suscripciones por mes: ' || v_promedio_suscripciones);
END CalcularPromedioSuscripciones;
END PromedioSuscripciones_Package;
/



--GERENTE DUEÑO DE UN EQUIPO--
--paquete para Consultas el promedio de su equipo durante una temporada--

CREATE OR REPLACE PACKAGE DesempeñoEquipo_Package AS
-- Declarar el procedimiento para obtener el desempeño del equipo en una temporada
PROCEDURE ObtenerDesempeñoEquipo(
    p_nombre_equipo VARCHAR2,
    p_temporada_inicio DATE,
    p_temporada_fin DATE
);
END DesempeñoEquipo_Package;
/

CREATE OR REPLACE PACKAGE BODY DesempeñoEquipo_Package AS
-- Implementar el procedimiento para obtener el desempeño del equipo en una temporada
PROCEDURE ObtenerDesempeñoEquipo(
    p_nombre_equipo VARCHAR2,
    p_temporada_inicio DATE,
    p_temporada_fin DATE
) IS
BEGIN
    -- Consultar el desempeño del equipo en la temporada especificada
    SELECT *
    FROM Partido
    WHERE (equipoLocal = p_nombre_equipo OR equipoVisitante = p_nombre_equipo)
      AND ligaFecha BETWEEN p_temporada_inicio AND p_temporada_fin;
END ObtenerDesempeñoEquipo;
END DesempeñoEquipo_Package;
/









