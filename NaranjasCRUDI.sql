---------------------------------------------------------------------------------------------------------------------------------------------------


--USUARIO


---------------------------------------------------------------------------------------------------------------------------------------------------
-- Crear el paquete para el registro de usuarios
CREATE OR REPLACE PACKAGE Usuario_Package AS
    PROCEDURE RegistrarUsuario(
        p_correo VARCHAR2,
        p_nombre VARCHAR2,
        p_fecha_nacimiento DATE
    );
END Usuario_Package;
/

-- Crear el cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY Usuario_Package AS

    -- Función para validar el formato del correo electrónico
    FUNCTION EsCorreoValido(p_correo VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        RETURN REGEXP_LIKE(p_correo, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
    END EsCorreoValido;

    PROCEDURE RegistrarUsuario(
        p_correo VARCHAR2,
        p_nombre VARCHAR2,
        p_fecha_nacimiento DATE
    ) IS
    BEGIN
        -- Validar el formato del correo electrónico
        IF NOT EsCorreoValido(p_correo) THEN
            RAISE_APPLICATION_ERROR(-20001, 'El correo electrónico proporcionado no es válido.');
        END IF;

        -- Validar la edad
        IF p_fecha_nacimiento >= ADD_MONTHS(SYSDATE, -16 * 12) THEN
            RAISE_APPLICATION_ERROR(-20002, 'Debe ser mayor de 16 años para registrarse.');
        END IF;

        -- Insertar el usuario en la tabla Sesion
        INSERT INTO Sesion (correo, nombre, fechaNacimiento)
        VALUES (p_correo, p_nombre, p_fecha_nacimiento);
    END RegistrarUsuario;

END Usuario_Package;
/




---------------------------------------------------------------------------------------------------------------------------------------------------
-- Crear el paquete para el registro de usuarios premium(pagos)


CREATE OR REPLACE PACKAGE UsuarioPremium_Package AS
    PROCEDURE RegistrarUsuarioPremium(
        p_correo VARCHAR2,
        p_nombre VARCHAR2,
        p_fecha_nacimiento DATE
    );
END UsuarioPremium_Package;
/

-- Crear el cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY UsuarioPremium_Package AS
    PROCEDURE RegistrarUsuarioPremium(
        p_correo VARCHAR2,
        p_nombre VARCHAR2,
        p_fecha_nacimiento DATE
    ) IS
    v_count INTEGER;
    BEGIN
        -- Verificar si el correo existe en la tabla Sesion
        SELECT COUNT(*)
        INTO v_count
        FROM Sesion
        WHERE correo = p_correo;

        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El correo proporcionado no cumple con los criterios de tipo correo o no existe en la base de datos.');
        END IF;

        -- Validar la edad
        IF p_fecha_nacimiento >= ADD_MONTHS(SYSDATE, -16 * 12) THEN
            RAISE_APPLICATION_ERROR(-20002, 'Debe ser mayor de 16 años para registrarse como usuario premium.');
        END IF;

        -- Verificar si el correo ya está registrado como usuario premium
        SELECT COUNT(*)
        INTO v_count
        FROM Pago
        WHERE sesion = p_correo;

        IF v_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'El correo ya está registrado como usuario premium.');
        END IF;

        -- Insertar el usuario en la tabla Pago
        INSERT INTO Pago (sesion, fechainicio, fechaFin)
        VALUES (p_correo, CURRENT_DATE, NULL);
    END RegistrarUsuarioPremium;
END UsuarioPremium_Package;
/



---------------------------------------------------------------------------------------------------------------------------------------------------

--paquete para Saber el estado actual de su suscripcion y cuanto lleva suscrito--

CREATE OR REPLACE PACKAGE EstadoSuscripcion_Package AS
    -- Declarar el procedimiento para obtener el estado actual de la suscripción de un usuario y el tiempo que lleva suscrito
    PROCEDURE ObtenerEstadoSuscripcion(
        p_nombre_usuario VARCHAR2,
        p_correo_usuario VARCHAR2,
        o_estado_suscripcion OUT VARCHAR2,
        o_tiempo_suscrito OUT NUMBER
    );
END EstadoSuscripcion_Package;
/

-- Crear el cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY EstadoSuscripcion_Package AS
    -- Implementar el procedimiento para obtener el estado actual de la suscripción de un usuario y el tiempo que lleva suscrito
    PROCEDURE ObtenerEstadoSuscripcion(
        p_nombre_usuario VARCHAR2,
        p_correo_usuario VARCHAR2,
        o_estado_suscripcion OUT VARCHAR2,
        o_tiempo_suscrito OUT NUMBER
    ) IS
        v_fecha_inicio DATE;
        v_fecha_fin DATE;
    BEGIN
        -- Obtener las fechas de inicio y fin de la suscripción del usuario
        SELECT fechainicio, fechaFin INTO v_fecha_inicio, v_fecha_fin
        FROM Pago
        WHERE sesion = p_nombre_usuario;

        -- Calcular el estado de la suscripción
        IF SYSDATE BETWEEN v_fecha_inicio AND v_fecha_fin THEN
            o_estado_suscripcion := 'Activa';
        ELSE
            o_estado_suscripcion := 'Inactiva';
        END IF;

        -- Calcular el tiempo que lleva suscrito
        o_tiempo_suscrito := TRUNC(SYSDATE) - TRUNC(v_fecha_inicio);
    END ObtenerEstadoSuscripcion;
END EstadoSuscripcion_Package;
/


---------------------------------------------------------------------------------------------------------------------------------------------------



--ADMINISTRADOR--


    
---------------------------------------------------------------------------------------------------------------------------------------------------
-- Crear el paquete para agregar publicidad

CREATE OR REPLACE PACKAGE Publicidad_Package AS
    PROCEDURE AgregarPublicidad(
        p_nombre VARCHAR2,
        p_url VARCHAR2
    );
END Publicidad_Package;
/

-- Crear el cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY Publicidad_Package AS
    PROCEDURE AgregarPublicidad(
        p_nombre VARCHAR2,
        p_url VARCHAR2
    ) IS
    BEGIN
        IF INSTR(p_url, 'http://') <> 1 THEN
            RAISE_APPLICATION_ERROR(-20001, 'La URL debe cumplir con el protocolo HTTP.');
        END IF;

        INSERT INTO Publicidad (nombre, URL)
        VALUES (p_nombre, p_url);
    END AgregarPublicidad;
END Publicidad_Package;
/




---------------------------------------------------------------------------------------------------------------------------------------------------

-- Crear el paquete para mantener la liga

CREATE OR REPLACE PACKAGE Liga_Package AS
    PROCEDURE MantenerLiga(
        p_nombre VARCHAR2,
        p_fecha_inicio DATE,
        p_fecha_fin DATE
    );
END Liga_Package;
/

-- Crear el cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY Liga_Package AS
    PROCEDURE MantenerLiga(
        p_nombre VARCHAR2,
        p_fecha_inicio DATE,
        p_fecha_fin DATE
    ) IS
    BEGIN
        IF p_fecha_fin < p_fecha_inicio THEN
            RAISE_APPLICATION_ERROR(-20001, 'La fecha de fin no puede ser anterior a la fecha de inicio.');
        END IF;

        UPDATE Liga
        SET fechaFin = p_fecha_fin
        WHERE nombre = p_nombre AND fechaInicio = p_fecha_inicio;
    END MantenerLiga;
END Liga_Package;
/
    




---------------------------------------------------------------------------------------------------------------------------------------------------

-- Crear el paquete para gestionar un partido




CREATE OR REPLACE PACKAGE GestionPartidos AS
    -- Procedimiento para agregar un nuevo partido
    PROCEDURE agregarPartido(
        p_ligaNombre IN VARCHAR2,
        p_ligaFecha IN DATE,
        p_equipoLocal IN VARCHAR2,
        p_equipoVisitante IN VARCHAR2,
        p_golesLocal IN INT,
        p_golesVisitante IN INT
    );
    
    -- Procedimiento para modificar los goles de un partido
    PROCEDURE modificarGoles(
        p_codigo IN INT,
        p_nuevosGolesLocal IN INT,
        p_nuevosGolesVisitante IN INT
    );
END GestionPartidos;
/

CREATE OR REPLACE PACKAGE BODY GestionPartidos AS
    -- Procedimiento para agregar un nuevo partido
    PROCEDURE agregarPartido(
        p_ligaNombre IN VARCHAR2,
        p_ligaFecha IN DATE,
        p_equipoLocal IN VARCHAR2,
        p_equipoVisitante IN VARCHAR2,
        p_golesLocal IN INT,
        p_golesVisitante IN INT
    ) AS
        v_codigoPartido INT;
        v_ligaExistente INT;
        v_equipoLocalExistente INT;
        v_equipoVisitanteExistente INT;
        v_equipoLocalJugadores INT;
        v_equipoVisitanteJugadores INT;
    BEGIN
        -- Generar código de partido automáticamente
        SELECT MAX(codigo) + 1 INTO v_codigoPartido FROM Partido;
        IF v_codigoPartido IS NULL THEN
            v_codigoPartido := 1;
        END IF;

        -- Verificar que la liga existe
        SELECT COUNT(*) INTO v_ligaExistente FROM Liga WHERE nombre = p_ligaNombre;
        IF v_ligaExistente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'La liga especificada no existe.');
        END IF;
        
        -- Verificar que los equipos existen
        SELECT COUNT(*) INTO v_equipoLocalExistente FROM Equipo WHERE nombre = p_equipoLocal;
        IF v_equipoLocalExistente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El equipo local especificado no existe.');
        END IF;
        
        SELECT COUNT(*) INTO v_equipoVisitanteExistente FROM Equipo WHERE nombre = p_equipoVisitante;
        IF v_equipoVisitanteExistente = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'El equipo visitante especificado no existe.');
        END IF;

        -- Verificar que los goles sean mayores o iguales a 0
        IF p_golesLocal < 0 OR p_golesVisitante < 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Los goles deben ser mayores o iguales a 0.');
        END IF;

        -- Verificar que los equipos tengan al menos 11 jugadores ni mayor a 20
        
        SELECT COUNT(*) INTO v_equipoLocalJugadores FROM equipo WHERE nombre = p_equipoLocal;
        IF v_equipoLocalJugadores < 11 OR v_equipoLocalJugadores > 20 THEN
            RAISE_APPLICATION_ERROR(-20005, 'El equipo local debe tener entre 11 y 20 jugadores.');
        END IF;

        SELECT COUNT(*) INTO v_equipoVisitanteJugadores FROM equipo WHERE nombre = p_equipoVisitante;
        IF v_equipoVisitanteJugadores < 11 OR v_equipoVisitanteJugadores > 20 THEN
            RAISE_APPLICATION_ERROR(-20006, 'El equipo visitante debe tener entre 11 y 20 jugadores.');
        END IF;

        -- Insertar el nuevo partido en la tabla
        INSERT INTO Partido (codigo, ligaNombre, ligaFecha, equipoLocal, equipoVisitante, golesLocal, golesVisitante)
        VALUES (v_codigoPartido, p_ligaNombre, p_ligaFecha, p_equipoLocal, p_equipoVisitante, p_golesLocal, p_golesVisitante);
    END agregarPartido;

    -- Procedimiento para modificar los goles de un partido
    PROCEDURE modificarGoles(
        p_codigo IN INT,
        p_nuevosGolesLocal IN INT,
        p_nuevosGolesVisitante IN INT
    ) AS
    BEGIN
        -- Verificar que los goles sean mayores o iguales a 0
        IF p_nuevosGolesLocal < 0 OR p_nuevosGolesVisitante < 0 THEN
            RAISE_APPLICATION_ERROR(-20007, 'Los goles deben ser mayores o iguales a 0.');
        END IF;

        -- Actualizar los goles del partido
        UPDATE Partido
        SET golesLocal = p_nuevosGolesLocal,
            golesVisitante = p_nuevosGolesVisitante
        WHERE codigo = p_codigo;
    END modificarGoles;
END GestionPartidos;
/





---------------------------------------------------------------------------------------------------------------------------------------------------

-- Crear el paquete para generar y mantener las estadísticas de un partido


CREATE OR REPLACE PACKAGE EstadisticasPartido_Package AS
    PROCEDURE GenerarEstadisticasPartido(
        p_partido_codigo INT,
        p_jugador_nit VARCHAR2,
        p_jugador_tid CHAR,
        p_equipo VARCHAR2,
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
        p_jugador_nit VARCHAR2,
        p_jugador_tid CHAR,
        p_equipo VARCHAR2,
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





---------------------------------------------------------------------------------------------------------------------------------------------------
-- Crear el paquete para gestionar la clasificación de los equipos después de un partido

CREATE OR REPLACE PACKAGE Clasificacion_Package AS
    PROCEDURE GestionarClasificacion(
        p_liga_nombre VARCHAR2,
        p_liga_fecha  DATE,
        p_equipo VARCHAR2,
        p_puesto  INT,
        p_partidos_ganados  INT,
        p_partidos_empatados  INT,
        p_partidos_perdidos  INT,
        p_puntos  INT
    );
END Clasificacion_Package;
/

CREATE OR REPLACE PACKAGE BODY Clasificacion_Package AS
    PROCEDURE GestionarClasificacion(
        p_liga_nombre VARCHAR2,
        p_liga_fecha  DATE,
        p_equipo  VARCHAR2,
        p_puesto  INT,
        p_partidos_ganados  INT,
        p_partidos_empatados  INT,
        p_partidos_perdidos  INT,
        p_puntos  INT
    ) IS
        v_consecutivo INT;
    BEGIN
        SELECT COALESCE(MAX(puesto), 0) + 1 INTO v_consecutivo FROM Clasificacion;

        INSERT INTO Clasificacion (ligaNombre, ligaFecha, equipo, puesto, partidosGanados, partidosEmpatados, partidosPerdidos, puntos)
        VALUES (p_liga_nombre, p_liga_fecha, p_equipo, p_puesto, p_partidos_ganados, p_partidos_empatados, p_partidos_perdidos, p_puntos);
    END GestionarClasificacion;
END Clasificacion_Package;
/


---------------------------------------------------------------------------------------------------------------------------------------------------


    
--GERENTE DE EQUIPO--



---------------------------------------------------------------------------------------------------------------------------------------------------
-- Crear el paquete para que un gerente de equipo pueda registrar su equipo


CREATE OR REPLACE PACKAGE RegistroEquipo_Package AS
    PROCEDURE RegistrarEquipo(
        p_nombre IN VARCHAR2,
        p_ciudad IN VARCHAR2,
        p_estadio IN VARCHAR2,
        p_dueno IN VARCHAR2
    );
END RegistroEquipo_Package;
/

CREATE OR REPLACE PACKAGE BODY RegistroEquipo_Package AS
    PROCEDURE RegistrarEquipo(
        p_nombre IN VARCHAR2,
        p_ciudad IN VARCHAR2,
        p_estadio IN VARCHAR2,
        p_dueno IN VARCHAR2
    ) IS
    BEGIN
        RAISE_APPLICATION_ERROR(-20001, 'No se puede registrar un equipo directamente a través de este paquete. Por favor, utiliza una sentencia INSERT INTO en SQL para agregar un nuevo equipo.');
    END RegistrarEquipo;
END RegistroEquipo_Package;
/



--------------------------------------------------------------------------------------------------------------------------------------------------------
--paquete para mantener el cuerpo tecnico de un equipo


-- Creación del paquete
CREATE OR REPLACE PACKAGE CuerpoTecnico_Package AS
    PROCEDURE RegistrarCuerpoTecnico(
        p_nombre IN VARCHAR2,
        p_tid IN CHAR,
        p_nid IN VARCHAR2,
        p_nacionalidad IN VARCHAR2,
        p_cargo IN VARCHAR2,
        p_equipo IN VARCHAR2
    );

    PROCEDURE ModificarEquipoCuerpoTecnico(
        p_tid IN CHAR,
        p_equipo IN VARCHAR2
    );

    PROCEDURE EliminarCuerpoTecnico(
        p_tid IN CHAR
    );
END CuerpoTecnico_Package;
/

-- Creación del cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY CuerpoTecnico_Package AS
    PROCEDURE RegistrarCuerpoTecnico(
        p_nombre IN VARCHAR2,
        p_tid IN CHAR,
        p_nid IN VARCHAR2,
        p_nacionalidad IN VARCHAR2,
        p_cargo IN VARCHAR2,
        p_equipo IN VARCHAR2
    ) IS
        v_count NUMBER;
    BEGIN
        -- Verificar que el equipo exista
        SELECT COUNT(*)
        INTO v_count
        FROM Equipo
        WHERE nombre = p_equipo;

        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El equipo especificado no existe.');
        END IF;

        -- Insertar el nuevo miembro del cuerpo técnico
        INSERT INTO CuerpoTecnico (nombre, tid, nid, nacionalidad, cargo, equipo)
        VALUES (p_nombre, p_tid, p_nid, p_nacionalidad, p_cargo, p_equipo);
    END RegistrarCuerpoTecnico;

    PROCEDURE ModificarEquipoCuerpoTecnico(
        p_tid IN CHAR,
        p_equipo IN VARCHAR2
    ) IS
        v_count NUMBER;
    BEGIN
        -- Verificar que el equipo nuevo exista
        SELECT COUNT(*)
        INTO v_count
        FROM Equipo
        WHERE nombre = p_equipo;

        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El equipo especificado no existe.');
        END IF;

        -- Actualizar el equipo del miembro del cuerpo técnico
        UPDATE CuerpoTecnico
        SET equipo = p_equipo
        WHERE tid = p_tid;
    END ModificarEquipoCuerpoTecnico;

    PROCEDURE EliminarCuerpoTecnico(
        p_tid IN CHAR
    ) IS
    BEGIN
        -- Eliminar el miembro del cuerpo técnico
        DELETE FROM CuerpoTecnico
        WHERE tid = p_tid;
    END EliminarCuerpoTecnico;
END CuerpoTecnico_Package;
/




----------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Crear el paquete para que un gerente de equipo pueda registrar sus jugadores

-- Creación del paquete
CREATE OR REPLACE PACKAGE Jugador_Package AS
    PROCEDURE RegistrarJugador(
        p_nombre IN VARCHAR2,
        p_nit IN VARCHAR2,
        p_tid IN CHAR,
        p_nacionalidad IN VARCHAR2,
        p_edad IN INT,
        p_altura IN FLOAT,
        p_posicion IN VARCHAR2,
        p_equipo IN VARCHAR2
    );

    PROCEDURE ModificarEquipoJugador(
        p_nit IN VARCHAR2,
        p_tid IN CHAR,
        p_equipo IN VARCHAR2
    );
END Jugador_Package;
/

CREATE OR REPLACE PACKAGE BODY Jugador_Package AS
    PROCEDURE RegistrarJugador(
        p_nombre IN VARCHAR2,
        p_nit IN VARCHAR2,
        p_tid IN CHAR,
        p_nacionalidad IN VARCHAR2,
        p_edad IN INT,
        p_altura IN FLOAT,
        p_posicion IN VARCHAR2,
        p_equipo IN VARCHAR2
    ) IS
        v_count NUMBER;
    BEGIN
        -- Verificar que el equipo exista
        SELECT COUNT(*)
        INTO v_count
        FROM Equipo
        WHERE nombre = p_equipo;

        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El equipo especificado no existe.');
        END IF;

        -- Insertar el nuevo jugador
        INSERT INTO Jugador (nombre, nit, tid, nacionalidad, edad, altura, posicion)
        VALUES (p_nombre, p_nit, p_tid, p_nacionalidad, p_edad, p_altura, p_posicion);

        -- Insertar en la tabla Pertenece
        INSERT INTO Pertenece (jugadorNit, jugadorTid, equipo)
        VALUES (p_nit, p_tid, p_equipo); 
    END RegistrarJugador;

    PROCEDURE ModificarEquipoJugador(
        p_nit IN VARCHAR2,
        p_tid IN CHAR,
        p_equipo IN VARCHAR2
    ) IS
        v_count NUMBER;
    BEGIN
        -- Verificar que el equipo exista
        SELECT COUNT(*)
        INTO v_count
        FROM Equipo
        WHERE nombre = p_equipo;

        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El equipo especificado no existe.');
        END IF;

        -- Actualizar el equipo del jugador en la tabla Pertenece
        UPDATE Pertenece
        SET equipo = p_equipo
        WHERE jugadorNit = p_nit AND jugadorTid = p_tid;
    END ModificarEquipoJugador;
END Jugador_Package;
/



---------------------------------------------------------------------------------------------------------------------------------------------------


    
--GERENTE APP(ORGANIZACION)--

    

---------------------------------------------------------------------------------------------------------------------------------------------------
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
    FOR mes_cursor IN (SELECT TO_CHAR(fechainicio, 'MM-YYYY') AS mes_anio,
                              COUNT(*) AS total_suscripciones
                       FROM Pago
                       GROUP BY TO_CHAR(fechainicio, 'MM-YYYY')
                       ORDER BY TO_DATE(TO_CHAR(fechainicio, 'MM-YYYY'), 'MM-YYYY')) LOOP
        -- Obtener los valores del cursor
        v_mes_anio := mes_cursor.mes_anio;
        v_total_suscripciones := mes_cursor.total_suscripciones;

        -- Calcular el promedio de suscripciones por mes
        SELECT AVG(total_suscripciones) INTO v_promedio_suscripciones
        FROM (SELECT COUNT(*) AS total_suscripciones
              FROM Pago
              GROUP BY TO_CHAR(fechainicio, 'MM-YYYY'));

        -- Imprimir el resultado
        DBMS_OUTPUT.PUT_LINE('Mes y año: ' || v_mes_anio || ', Total de suscripciones: ' || v_total_suscripciones);
    END LOOP;

    -- Imprimir el promedio de suscripciones por mes
    DBMS_OUTPUT.PUT_LINE('Promedio de suscripciones por mes: ' || v_promedio_suscripciones);
END CalcularPromedioSuscripciones;
END PromedioSuscripciones_Package;
/




---------------------------------------------------------------------------------------------------------------------------------------------------


    
--GERENTE DUEÑO DE UN EQUIPO--



---------------------------------------------------------------------------------------------------------------------------------------------------
--paquete para Consultas el promedio de su equipo durante una temporada--


-- Crear el paquete para obtener el desempeño del equipo en una temporada
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
        CURSOR c_partidos IS
            SELECT equipoLocal, equipoVisitante, ligaFecha
            FROM Partido
            WHERE (equipoLocal = p_nombre_equipo OR equipoVisitante = p_nombre_equipo)
              AND ligaFecha BETWEEN p_temporada_inicio AND p_temporada_fin;
    BEGIN
        FOR partido IN c_partidos LOOP
            -- Aquí puedes realizar las operaciones necesarias con cada partido
            -- Por ejemplo, puedes imprimir los datos de cada partido
            DBMS_OUTPUT.PUT_LINE('Equipo local: ' || partido.equipoLocal || ', Equipo visitante: ' || partido.equipoVisitante || ', Fecha del partido: ' || partido.ligaFecha);
        END LOOP;
    END ObtenerDesempeñoEquipo;
END DesempeñoEquipo_Package;
/


---------------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------------
