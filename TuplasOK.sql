INSERT INTO Pago (sesion, fechaIncio, fechaFin)
VALUES (2, TO_DATE('2024-04-25', 'YYYY-MM-DD'), TO_DATE('2026-04-20', 'YYYY-MM-DD'));

INSERT INTO Liga (nombre, fechaIncio, fechaFin,ganador)
VALUES (aaaa, TO_DATE('2024-04-25', 'YYYY-MM-DD'), TO_DATE('2026-04-20', 'YYYY-MM-DD'),bbbb);

INSERT INTO Partido (codigo, ligaNombre, ligaFecha, equipoLocal, equipoVisitante, golesLocal, golesVisitante)
VALUES (2, 1, TO_DATE('2024-04-16', 'YYYY-MM-DD'), 'Equipo A', 'Equipo B', 2, 0);

INSERT INTO Estadisticas (partidoCodigo, jugadorNit, jugadorTid, equipo, asistencias, tarjetasAmarillas, tarjetasRojas, posesionLocal, posesionVisitante)
VALUES (1, '1234567890', 'ABC123', 'Equipo A', 2, 1, 0, 60.5, 39.5);
