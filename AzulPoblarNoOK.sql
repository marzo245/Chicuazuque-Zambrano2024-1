-- Intento de insertar una sesión gratuita con un correo que no existe en la tabla Sesion
INSERT INTO Gratis (sesion) VALUES ('correo_no_existente@example.com');

-- Intento de insertar una publicidad con un nombre que ya existe en la tabla Publicidad (violación de la restricción UNIQUE)
INSERT INTO Publicidad (nombre, URL) VALUES ('Publicidad1', 'http://www.nueva-publicidad.com');

-- Intento de insertar una publicidad tal que: URL que no comienza con 'http://', 'https://', o 'www.'
INSERT INTO Publicidad (nombre, URL) 
VALUES ('Inserción Errónea', XMLTYPE('<url>ftp://example.com</url>'));

-- Intento de insertar una relación en la tabla Ve con una referencia a una publicidad que no existe en la tabla Publicidad
INSERT INTO Ve (publicidad, gratis) VALUES ('Publicidad_no_existente', 'correo1@example.com');

-- Intento de insertar un pago con una sesión que no existe en la tabla Sesion
INSERT INTO Pago (sesion, fechaIncio, fechaFin) VALUES ('correo_no_existente@example.com', '2023-01-01', '2023-01-31');

-- Intento de insertar una tarjeta de crédito con un número que ya existe en la tabla Tarjeta (violación de la restricción UNIQUE)
INSERT INTO Tarjeta (pago, numero, fechaVencimiento, cvv) VALUES ('correo1@example.com', '1234567890123456', '2025-01-01', 123);

-- Intento de insertar una relación en la tabla Es su jugador favorito con una referencia a un jugador que no existe en la tabla Jugador
INSERT INTO Essujugadorfavorito (pago, jugadornit, jugadortid) VALUES ('correo1@example.com', 'Nit_no_existente', 'Tid_no_existente');

-- Intento de insertar una relación en la tabla Es su equipo favorito con una referencia a un equipo que no existe en la tabla Equipo
INSERT INTO Essuequipofavorito (pago, equipo) VALUES ('correo1@example.com', 'Equipo_no_existente');

-- Intento de insertar una relación en la tabla Pertenece con una referencia a un jugador o equipo que no existen en las tablas Jugador o Equipo
INSERT INTO Pertenece (jugadorNit, jugadorTit, equipo) VALUES ('Nit_no_existente', 'Tid_no_existente', 'Equipo_no_existente');

-- Intento de insertar un cuerpo técnico con un ID de equipo que no existe en la tabla Equipo
INSERT INTO CuerpoTecnico (nombre, tid, nid, nacionalidad, cargo, equipo) VALUES ('Entrenador3', 'Tid3', 'Nid3', 'Nacionalidad3', 'Asistente', 'Equipo_no_existente');

-- Intento de insertar un partido con un nombre de equipo local o visitante que no existe en la tabla Equipo
INSERT INTO Partido (codigo, ligaNombre, ligaFecha, equipoLocal, equipoVisitante, golesLocal, golesVisitante) VALUES (3, 1, '2023-03-01', 'Equipo_no_existente', 'Equipo2', 1, 3);

-- Intento de insertar una liga con un equipo ganador que no existe en la tabla Equipo
INSERT INTO Liga (nombre, fechaInicio, fechaFin, ganador) VALUES ('Liga3', '2023-01-01', '2023-12-31', 'Equipo_no_existente');

-- Intento de insertar una clasificación con un equipo que no existe en la tabla Equipo
INSERT INTO Clasificacion (ligaNombre, ligaFecha, equipo, puesto, partidosGanados, partidosEmpatados, partidosPerdidos, puntos) VALUES ('Liga1', '2023-01-01', 'Equipo_no_existente', 2, 18, 6, 4, 60);

-- Intento de insertar estadísticas con referencias a un partido, jugador o equipo que no existen en las tablas Partido, Jugador o Equipo
INSERT INTO Estadisticas (partidoCodigo, jugadorNit, jugadorTid, equipo, asistencias, tarjetasAmarillas, tarjetasRojas, posesionLocal, posesionVisitante) VALUES (3, 'Nit_no_existente', 'Tid_no_existente', 'Equipo_no_existente', 0, 0, 0, 0, 0);
