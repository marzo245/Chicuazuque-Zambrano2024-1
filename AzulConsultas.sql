--Consultas gerenciales
--Consultar el promedio de usuarios premium por mes
SELECT EXTRACT(YEAR FROM fechaInicio) AS year,
       EXTRACT(MONTH FROM fechaInicio) AS month,
       COUNT(DISTINCT sesion) / EXTRACT(MONTH FROM fechaInicio) AS avg_premium_users
FROM Pago
GROUP BY EXTRACT(YEAR FROM fechaInicio), EXTRACT(MONTH FROM fechaInicio);

--Consultar el mayor numero de registros por mes
SELECT EXTRACT(YEAR FROM fechaInicio) AS year,
       EXTRACT(MONTH FROM fechaInicio) AS month,
       COUNT(*) AS num_records
FROM Pago
GROUP BY EXTRACT(YEAR FROM fechaInicio), EXTRACT(MONTH FROM fechaInicio)
ORDER BY num_records DESC
LIMIT 1;

--Consultas el promedio de su equipo durante una temporada
SELECT E.equipo,
       SUM(E.asistencias) AS total_asistencias,
       SUM(E.tarjetasAmarillas) AS total_tarjetas_amarillas,
       SUM(E.tarjetasRojas) AS total_tarjetas_rojas,
       AVG(E.posesionLocal) AS promedio_posesion_local,
       AVG(E.posesionVisitante) AS promedio_posesion_visitante
FROM Estadisticas E
INNER JOIN Partido P ON E.partidoCodigo = P.codigo
WHERE E.equipo = 'NombreDelEquipo'
   AND (P.equipoLocal = 'NombreDelEquipo' OR P.equipoVisitante = 'NombreDelEquipo')
GROUP BY E.equipo;
