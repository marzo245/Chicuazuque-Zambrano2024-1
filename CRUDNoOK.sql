--el paquete para el registro de usuarios
BEGIN
    Usuario_Package.RegistrarUsuario('correoErroneo', 'Nombre Usuario', TO_DATE('2008-05-15', 'YYYY-MM-DD'));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


-- paquete para generar registros de cuentas gratis}


BEGIN
    CuentaGratis_Package.GenerarCuentaGratis('correoinvalido.com');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al generar la cuenta gratuita: ' || SQLERRM);
END;


--paquete para el registro de usuarios premium(pagos)

BEGIN
    UsuarioPremium_Package.RegistrarUsuarioPremium('correoinvalido.com', 'Nombre', TO_DATE('1990-05-15', 'YYYY-MM-DD'));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al registrar usuario premium: ' || SQLERRM);
END;



--Saber el estado actual de su suscripcion y cuanto lleva suscrito--

DECLARE
    v_estado_suscripcion VARCHAR2(20);
    v_tiempo_suscrito INTERVAL DAY(9) TO SECOND(2);
BEGIN

    EstadoSuscripcion_Package.ObtenerEstadoSuscripcion('Usuario3', 'correo3@example.com', v_estado_suscripcion, v_tiempo_suscrito);
    DBMS_OUTPUT.PUT_LINE('Estado de suscripción para Usuario3: ' || v_estado_suscripcion);
    DBMS_OUTPUT.PUT_LINE('Tiempo suscrito para Usuario3: ' || v_tiempo_suscrito);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


--paquete para agregar publicidad

BEGIN
   
    -- Prueba : Intentar insertar una publicidad con una URL inválida
    BEGIN
        Publicidad_Package.AgregarPublicidad('Publicidad2', 'example.com', SYSDATE + 1);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al agregar publicidad: ' || SQLERRM);
    END;

END;


-- paquete para mantener la liga

BEGIN
    -- Prueba 1: Intentar mantener una liga con una fecha de fin anterior a la fecha de inicio
    BEGIN
        Liga_Package.MantenerLiga('Liga1', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al mantener la liga: ' || SQLERRM);
    END;

END;

-- paquete para gestionar un partido


BEGIN
    -- Prueba 1: Intentar gestionar un partido con una liga que no existe
    BEGIN
        Partido_Package.GestionarPartido('LigaInexistente', TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'EquipoLocal', 'EquipoVisitante', 2, 1);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al gestionar el partido: ' || SQLERRM);
    END;

END;


--paquete para generar y mantener las estadísticas de un partido


BEGIN
    -- Prueba 1: Intentar generar estadísticas para un partido que no existe
    BEGIN
        EstadisticasPartido_Package.GenerarEstadisticasPartido(9999, 'JugadorNit', 'TID', 'Equipo', 3, 1, 0, 60.5, 39.5);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al generar estadísticas del partido: ' || SQLERRM);
    END;
END;


--paquete para gestionar la clasificación de los equipos después de un partido

BEGIN
    -- Prueba 1: Intentar gestionar la clasificación para una liga que no existe
    BEGIN
        Clasificacion_Package.GestionarClasificacion('LigaInexistente', SYSDATE, 'Equipo', 1, 10, 5, 3, 35);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al gestionar la clasificación: ' || SQLERRM);
    END;

END;


--paquete para que un gerente de equipo pueda registrar su equipo


BEGIN
    RegistroEquipo_Package.RegistrarEquipo('NombreEquipo', 'Ciudad', 'Estadio', 'Dueño');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;



--paquete para registrar a alguien en el cuerpo tecnico 


BEGIN
    CuerpoTecnico_Package.RegistrarCuerpoTecnico('Nombre', 'TID', 'NID', 'Nacionalidad', 'Cargo', 'EquipoInexistente');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;



-- paquete para que un gerente de equipo pueda registrar sus jugadores

BEGIN
    Jugador_Package.RegistrarJugador('Nombre', 'NIT', 'TID', 'Nacionalidad', 25, 180.5, 'Delantero', 'EquipoInexistente');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


--Consultar el promedio de usuarios premium por mes--


-- Insertar datos de suscripciones con fechas futuras
INSERT INTO Suscripciones (id, fecha) VALUES (1, SYSDATE + INTERVAL '1' MONTH);
INSERT INTO Suscripciones (id, fecha) VALUES (2, SYSDATE + INTERVAL '2' MONTH);

-- Insertar datos de suscripciones con formato de fecha incorrecto
INSERT INTO Suscripciones (id, fecha) VALUES (3, '2023-13-01'); -- Mes 13 no es válido



BEGIN
    PromedioSuscripciones_Package.CalcularPromedioSuscripciones;
END;


--Consultas el promedio de su equipo durante una temporada--

BEGIN
    DesempeñoEquipo_Package.ObtenerDesempeñoEquipo('EquipoNoExistente', DATE '2024-01-01', DATE '2024-12-31');
END;




