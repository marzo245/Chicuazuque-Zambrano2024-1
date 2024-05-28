INSERT INTO Pago (sesion, fechaIncio, fechaFin) VALUES ('correo11@example.com', TO_DATE('2023-01-01','YYYY-MM-DD'), TO_DATE('2023-02-31','YYYY-MM-DD'));

INSERT INTO Liga (nombre, fechaInicio, fechaFin, ganador) VALUES ('Liga11', TO_DATE('2025-01-01','YYYY-MM-DD'), TO_DATE('2025-02-20','YYYY-MM-DD'), 'Equipo11');

INSERT INTO Partido (codigo, ligaNombre, ligaFecha, equipoLocal, equipoVisitante, golesLocal, golesVisitante) 
VALUES (1, 'Liga111', TO_DATE('2025-02-01', 'YYYY-MM-DD'), 'Equipo111', 'Equipo222', 3, 1);

INSERT INTO Estadisticas (partidoCodigo, jugadorNit, jugadorTid, equipo, asistencias, tarjetasAmarillas, tarjetasRojas, posesionLocal, posesionVisitante) VALUES (1, '132456','C.C', 'Equipo11', 1, 1, 0,39.5,60.5);
