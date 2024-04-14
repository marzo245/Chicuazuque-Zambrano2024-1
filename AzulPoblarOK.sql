-- Inserts para la tabla Sesion
INSERT INTO Sesion (correo, nombre, fechaNacimineto) VALUES ('correo1@example.com', 'Nombre1', '2000-01-01');
INSERT INTO Sesion (correo, nombre, fechaNacimineto) VALUES ('correo2@example.com', 'Nombre2', '1995-05-15');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Gratis
INSERT INTO Gratis (sesion) VALUES ('correo1@example.com');
INSERT INTO Gratis (sesion) VALUES ('correo2@example.com');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Publicidad
INSERT INTO Publicidad (nombre, URL) VALUES ('Publicidad1', 'http://www.publicidad1.com');
INSERT INTO Publicidad (nombre, URL) VALUES ('Publicidad2', 'http://www.publicidad2.com');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Ve
INSERT INTO Ve (publicidad, gratis) VALUES ('Publicidad1', 'correo1@example.com');
INSERT INTO Ve (publicidad, gratis) VALUES ('Publicidad2', 'correo2@example.com');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Pago
INSERT INTO Pago (sesion, fechaIncio, fechaFin) VALUES ('correo1@example.com', '2023-01-01', '2023-01-31');
INSERT INTO Pago (sesion, fechaIncio, fechaFin) VALUES ('correo2@example.com', '2023-02-01', '2023-02-28');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Tarjeta
INSERT INTO Tarjeta (pago, numero, fechaVencimiento, cvv) VALUES ('correo1@example.com', '1234567890123456', '2025-01-01', 123);
INSERT INTO Tarjeta (pago, numero, fechaVencimiento, cvv) VALUES ('correo2@example.com', '9876543210987654', '2025-02-01', 456);
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Essujugadorfavorito
INSERT INTO Essujugadorfavorito (pago, jugadornit, jugadortid) VALUES ('correo1@example.com', 'Nit1', 'Tid1');
INSERT INTO Essujugadorfavorito (pago, jugadornit, jugadortid) VALUES ('correo2@example.com', 'Nit2', 'Tid2');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Essuequipofavorito
INSERT INTO Essuequipofavorito (pago, equipo) VALUES ('correo1@example.com', 'Equipo1');
INSERT INTO Essuequipofavorito (pago, equipo) VALUES ('correo2@example.com', 'Equipo2');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Jugador
INSERT INTO Jugador (nombre, nit, tid, nacionalidad, edad, altura, posicion) VALUES ('Jugador1', 'Nit1', 'Tid1', 'Nacionalidad1', 25, 1.85, 'Delantero');
INSERT INTO Jugador (nombre, nit, tid, nacionalidad, edad, altura, posicion) VALUES ('Jugador2', 'Nit2', 'Tid2', 'Nacionalidad2', 28, 1.75, 'Defensa');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Pertenece
INSERT INTO Pertenece (jugadorNit, jugadorTit, equipo) VALUES ('Nit1', 'Tid1', 'Equipo1');
INSERT INTO Pertenece (jugadorNit, jugadorTit, equipo) VALUES ('Nit2', 'Tid2', 'Equipo2');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Equipo
INSERT INTO Equipo (nombre, ciudad, estadio, dueño) VALUES ('Equipo1', 'Ciudad1', 'Estadio1', 'Dueño1');
INSERT INTO Equipo (nombre, ciudad, estadio, dueño) VALUES ('Equipo2', 'Ciudad2', 'Estadio2', 'Dueño2');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla CuerpoTecnico
INSERT INTO CuerpoTecnico (nombre, tid, nid, nacionalidad, cargo, equipo) VALUES ('Entrenador1', 'Tid1', 'Nid1', 'Nacionalidad1', 'Entrenador', 'Equipo1');
INSERT INTO CuerpoTecnico (nombre, tid, nid, nacionalidad, cargo, equipo) VALUES ('Entrenador2', 'Tid2', 'Nid2', 'Nacionalidad2', 'Asistente', 'Equipo2');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Partido
INSERT INTO Partido (codigo, ligaNombre, ligaFecha, equipoLocal, equipoVisitante, golesLocal, golesVisitante) VALUES (1, 1, '2023-01-01', 'Equipo1', 'Equipo2', 2, 1);
INSERT INTO Partido (codigo, ligaNombre, ligaFecha, equipoLocal, equipoVisitante, golesLocal, golesVisitante) VALUES (2, 1, '2023-02-01', 'Equipo2', 'Equipo1', 1, 3);
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Liga
INSERT INTO Liga (nombre, fechaInicio, fechaFin, ganador) VALUES ('Liga1', '2023-01-01', '2023-12-31', 'Equipo1');
INSERT INTO Liga (nombre, fechaInicio, fechaFin, ganador) VALUES ('Liga2', '2023-01-01', '2023-12-31', 'Equipo2');
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Clasificacion
INSERT INTO Clasificacion (ligaNombre, ligaFecha, equipo, puesto, partidosGanados, partidosEmpatados, partidosPerdidos, puntos) VALUES ('Liga1', '2023-01-01', 'Equipo1', 1, 20, 5, 3, 65);
INSERT INTO Clasificacion (ligaNombre, ligaFecha, equipo, puesto, partidosGanados, partidosEmpatados, partidosPerdidos, puntos) VALUES ('Liga2', '2023-01-01', 'Equipo2', 1, 18, 7, 3, 61);
-- Agrega más inserciones según sea necesario

-- Inserts para la tabla Estadisticas
INSERT INTO Estadisticas (partidoCodigo, jugadorNit, jugadorTid, equipo, asistencias, tarjetasAmarillas, tarjetasRojas, posesionLocal, posesionVisitante) VALUES (1, 'Nit1', 'Tid1', 'Equipo1', 2, 1, 0, 60.5, 39.5);
INSERT INTO Estadisticas (partidoCodigo, jugadorNit, jugadorTid, equipo, asistencias, tarjetasAmarillas, tarjetasRojas, posesionLocal, posesionVisitante) VALUES (2, 'Nit2', 'Tid2', 'Equipo2', 1, 2, 0, 48.2, 51.8);
-- Agrega más inserciones según sea necesario
