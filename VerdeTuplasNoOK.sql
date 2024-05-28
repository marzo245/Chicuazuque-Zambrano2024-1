--intentar insertar un pago con un correo que no existe
INSERT INTO Pago (sesion, fechaIncio, fechaFin) VALUES ('correoInxistente@example.com', '2023-01-01', '2023-02-12');

--intentar insertar una liga con fecha de inicio mayor a la de fin
INSERT INTO Liga (nombre, fechaInicio, fechaFin, ganador) VALUES ('Liga3', '2023-01-01', '2022-12-31', 'Equipo11');
--intentar insertar un partido con goles negativos
INSERT INTO Partido (codigo, ligaNombre, ligaFecha, equipoLocal, equipoVisitante, golesLocal, golesVisitante) 
VALUES (1, 'Liga111', TO_DATE('2025-02-01', 'YYYY-MM-DD'), 'Equipo111', 'Equipo222', -3, 1);

-- Intento de insertar estadísticas con referencias a un jugador que no existe
INSERT INTO Estadisticas (partidoCodigo, jugadorNit, jugadorTid, equipo, asistencias, tarjetasAmarillas, tarjetasRojas, posesionLocal, posesionVisitante) 
VALUES (1, 'Nit_inexistente','C.C', 'Equipo11', 1, 1, 0,39.5,60.5);
