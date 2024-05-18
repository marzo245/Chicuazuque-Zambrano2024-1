-- Inserts para la tabla Sesion
INSERT INTO Sesion (correo, nombre, fechaNacimineto) VALUES ('correo1@example.com', 'Nombre1', TO_DATE('2000-01-01', 'YYYY-MM-DD'));
INSERT INTO Sesion (correo, nombre, fechaNacimineto) VALUES ('correo2@example.com', 'Nombre2', TO_DATE('1995-05-15','YYYY-MM-DD'));
-- Agrega más inserciones según sea necesario

--Inserts para la tabla Publicidad

INSERT INTO Publicidad (nombre, URL) 
VALUES ('Publicidad 1', XMLTYPE('<url>http://example.com</url>'));

INSERT INTO Publicidad (nombre, URL) 
VALUES ('Publicidad 2', XMLTYPE('<url>https://example.com</url>'));

INSERT INTO Publicidad (nombre, URL) 
VALUES ('Publicidad 3', XMLTYPE('<url>www.example.com</url>'));


-- Inserts para la tabla Gratis
INSERT INTO Gratis (sesion) VALUES ('correo1@example.com');
INSERT INTO Gratis (sesion) VALUES ('correo2@example.com');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Ve
INSERT INTO Ve (publicidad, gratis) VALUES ('Publicidad1', 'correo1@example.com');
INSERT INTO Ve (publicidad, gratis) VALUES ('Publicidad2', 'correo2@example.com');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Pago
INSERT INTO Pago (sesion, fechaIncio, fechaFin) VALUES ('correo1@example.com', TO_DATE('2023-01-01','YYYY-MM-DD'), TO_DATE('2023-01-31','YYYY-MM-DD'));
INSERT INTO Pago (sesion, fechaIncio, fechaFin) VALUES ('correo2@example.com', TO_DATE('2023-01-01','YYYY-MM-DD'), TO_DATE('2023-01-31','YYYY-MM-DD'));
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Tarjeta
INSERT INTO Tarjeta (pago, numero, fechaVencimiento, cvv) VALUES ('correo1@example.com', '1234567890123456', TO_DATE('2025-01-01','YYYY-MM-DD'), 123);
INSERT INTO Tarjeta (pago, numero, fechaVencimiento, cvv) VALUES ('correo2@example.com', '9876543210987654',TO_DATE('2025-01-01','YYYY-MM-DD'), 456);
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Jugador
INSERT INTO Jugador (nombre, nit, tid, nacionalidad, edad, altura, posicion) VALUES ('Jugador1', '123456','C.C', 'Nacionalidad1', 25, 1.85, 'Portero');
INSERT INTO Jugador (nombre, nit, tid, nacionalidad, edad, altura, posicion) VALUES ('Jugador2', '123457','C.C', 'Nacionalidad2', 28, 1.75, 'Defensa');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Equipo
INSERT INTO Equipo (nombre, ciudad, estadio, dueño) VALUES ('Equipo1', 'Ciudad1', 'Estadio1', 'Dueño1');
INSERT INTO Equipo (nombre, ciudad, estadio, dueño) VALUES ('Equipo2', 'Ciudad2', 'Estadio2', 'Dueño2');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Pertenece
INSERT INTO Pertenece (jugadorNit, jugadorTit, equipo) VALUES ('123456','C.C', 'Equipo1');
INSERT INTO Pertenece (jugadorNit, jugadorTit, equipo) VALUES ('123457','C.C', 'Equipo2');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla CuerpoTecnico
INSERT INTO CuerpoTecnico (nombre, tid, nid, nacionalidad, cargo, equipo) VALUES ('Entrenador1', 'C.C', '123457','Nacionalidad1', 'Entrenador', 'Equipo1');
INSERT INTO CuerpoTecnico (nombre, tid, nid, nacionalidad, cargo, equipo) VALUES ('Entrenador2', 'C.C', '123456','Nacionalidad2', 'Asistente', 'Equipo2');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Liga
INSERT INTO Liga (nombre, fechaInicio, fechaFin, ganador) VALUES ('Liga1', TO_DATE('2025-01-01','YYYY-MM-DD'), TO_DATE('2025-01-30','YYYY-MM-DD'), 'Equipo1');
INSERT INTO Liga (nombre, fechaInicio, fechaFin, ganador) VALUES ('Liga2', TO_DATE('2025-01-01','YYYY-MM-DD'), TO_DATE('2025-01-25','YYYY-MM-DD'), 'Equipo2');

-- Inserts para la tabla Partido
INSERT INTO Partido (codigo, ligaNombre, ligaFecha, equipoLocal, equipoVisitante, golesLocal, golesVisitante) 
VALUES (1, 'Liga1', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'Equipo1', 'Equipo2', 3, 0);

INSERT INTO Partido (codigo, ligaNombre, ligaFecha, equipoLocal, equipoVisitante, golesLocal, golesVisitante) 
VALUES (2, 'Liga1', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'Equipo2', 'Equipo1', 2, 2);
-- Agrega más inserciones según sea necesario


-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Clasificacion
INSERT INTO Clasificacion (ligaNombre, ligaFecha, equipo, puesto, partidosGanados, partidosEmpatados, partidosPerdidos, puntos) VALUES ('Liga1', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'Equipo1', 1, 20, 5, 3, 65);
INSERT INTO Clasificacion (ligaNombre, ligaFecha, equipo, puesto, partidosGanados, partidosEmpatados, partidosPerdidos, puntos) VALUES ('Liga1', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'Equipo2', 1, 18, 7, 3, 61);
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Estadisticas
--INSERT INTO Estadisticas (partidoCodigo, jugadorNit, jugadorTid, equipo, asistencias, tarjetasAmarillas, tarjetasRojas, posesionLocal, posesionVisitante) VALUES (1, '123456','C.C', 'Equipo1', 2, 1, 0, 60.5, 39.5);
--INSERT INTO Estadisticas (partidoCodigo, jugadorNit, jugadorTid, equipo, asistencias, tarjetasAmarillas, tarjetasRojas, posesionLocal, posesionVisitante) VALUES (2, '123457','C.C', 'Equipo2', 1, 2, 0, 48.2, 51.8);
-- Agrega más inserciones según sea necesario
-- Inserts para la tabla Essujugadorfavorito
INSERT INTO Essujugadorfavorito (pago, jugadornit, jugadortid) VALUES ('correo1@example.com', '123456','C.C');
INSERT INTO Essujugadorfavorito (pago, jugadornit, jugadortid) VALUES ('correo2@example.com', '123456','C.C');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Essuequipofavorito
INSERT INTO Essuequipofavorito (pago, equipo) VALUES ('correo1@example.com', 'Equipo1');
INSERT INTO Essuequipofavorito (pago, equipo) VALUES ('correo2@example.com', 'Equipo2');
-- Agrega más inserciones según sea necesario
