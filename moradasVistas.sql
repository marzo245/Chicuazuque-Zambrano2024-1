--Promedio de usuarios premium por mes:
CREATE OR REPLACE VIEW PromedioUsuariosPremium AS
SELECT EXTRACT(YEAR FROM fechaInicio) AS year,
       EXTRACT(MONTH FROM fechaInicio) AS month,
       COUNT(DISTINCT sesion) / EXTRACT(MONTH FROM fechaInicio) AS avg_premium_users
FROM Pago
GROUP BY EXTRACT(YEAR FROM fechaInicio), EXTRACT(MONTH FROM fechaInicio);

--Mayor número de registros por mes:
CREATE OR REPLACE VIEW MayorNumeroRegistros AS
SELECT year, month, num_records
FROM (
    SELECT EXTRACT(YEAR FROM fechaInicio) AS year,
           EXTRACT(MONTH FROM fechaInicio) AS month,
           COUNT(*) AS num_records
    FROM Pago
    GROUP BY EXTRACT(YEAR FROM fechaInicio), EXTRACT(MONTH FROM fechaInicio)
    ORDER BY COUNT(*) DESC
)
WHERE ROWNUM = 1;


--Promedio del equipo durante una temporada:
CREATE OR REPLACE VIEW PromedioEquipoTemporada AS
SELECT E.equipo,
       SUM(E.asistencias) AS total_asistencias,
       SUM(E.tarjetasAmarillas) AS total_tarjetas_amarillas,
       SUM(E.tarjetasRojas) AS total_tarjetas_rojas,
       AVG(E.posesionLocal) AS promedio_posesion_local,
       AVG(E.posesionVisitante) AS promedio_posesion_visitante
FROM Estadisticas E
INNER JOIN Partido P ON E.partidoCodigo = P.codigo
GROUP BY E.equipo;

--Vistas Operativas:
--Estado actual de la suscripción y tiempo de suscripción de un usuario específico:
CREATE OR REPLACE VIEW EstadoSuscripcionUsuario AS
SELECT 
    P.sesion,
    CASE
        WHEN P.fechaFin >= SYSDATE THEN 'Activa'
        ELSE 'Expirada'
    END AS estado_suscripcion,
    SYSDATE - P.fechaInicio AS dias_suscrito
FROM Pago P;


--Rendimiento de todos los equipos en una temporada:
CREATE OR REPLACE VIEW RendimientoEquipos AS
SELECT 
    C.equipo,
    SUM(C.puntos) AS puntos_totales,
    SUM(C.partidosGanados) AS partidos_ganados,
    SUM(C.partidosEmpatados) AS partidos_empatados,
    SUM(C.partidosPerdidos) AS partidos_perdidos
FROM Clasificacion C
GROUP BY C.equipo;

--Estadísticas de jugadores:
CREATE OR REPLACE VIEW EstadisticasJugadores AS
SELECT 
    J.nombre AS nombre_jugador,
    E.equipo,
    SUM(E.asistencias) AS total_asistencias,
    SUM(E.tarjetasAmarillas) AS total_tarjetas_amarillas,
    SUM(E.tarjetasRojas) AS total_tarjetas_rojas,
    AVG(E.posesionLocal) AS promedio_posesion_local,
    AVG(E.posesionVisitante) AS promedio_posesion_visitante
FROM Estadisticas E
JOIN Jugador J ON E.jugadorNit = J.nit AND E.jugadorTid = J.tid
GROUP BY J.nombre, E.equipo;

CREATE OR REPLACE VIEW ClasificacionEquipos AS
SELECT 
    C.equipo,
    C.puesto,
    C.puntos,
    C.partidosGanados,
    C.partidosEmpatados,
    C.partidosPerdidos,
    C.ligaNombre,
    C.ligaFecha  
FROM Clasificacion C
ORDER BY C.puesto;

