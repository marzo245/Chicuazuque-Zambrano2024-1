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


---------------------------------------------------------------------------------------------------------------------------------------------------
-- Crear el paquete para el registro de usuarios premium(pagos)


CREATE OR REPLACE PACKAGE UsuarioPremium_Package AS
    PROCEDURE RegistrarUsuarioPremium(
        p_correo VARCHAR2,
        p_fecha_fin DATE
    );
END UsuarioPremium_Package;
/


---------------------------------------------------------------------------------------------------------------------------------------------------

--paquete para Saber el estado actual de su suscripcion y cuanto lleva suscrito--

CREATE OR REPLACE PACKAGE EstadoSuscripcion_Package AS
    PROCEDURE ObtenerEstadoSuscripcion(
        p_nombre_usuario VARCHAR2,
        p_correo_usuario VARCHAR2,
        o_estado_suscripcion OUT VARCHAR2,
        o_tiempo_suscrito OUT NUMBER
    );
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


---------------------------------------------------------------------------------------------------------------------------------------------------

-- Crear el paquete para gestionar un partido




CREATE OR REPLACE PACKAGE GestionPartidos AS
    PROCEDURE agregarPartido(
        p_ligaNombre IN VARCHAR2,
        p_ligaFecha IN DATE,
        p_equipoLocal IN VARCHAR2,
        p_equipoVisitante IN VARCHAR2,
        p_golesLocal IN INT,
        p_golesVisitante IN INT
    );
    
    PROCEDURE modificarGoles(
        p_codigo IN INT,
        p_nuevosGolesLocal IN INT,
        p_nuevosGolesVisitante IN INT
    );
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


--------------------------------------------------------------------------------------------------------------------------------------------------------
--paquete para mantener el cuerpo tecnico de un equipo


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




----------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Crear el paquete para que un gerente de equipo pueda registrar sus jugadores

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



