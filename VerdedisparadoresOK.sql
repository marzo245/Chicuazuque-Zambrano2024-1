--disparadoresOK
--Sesion
-- Inserción correcta de usuario mayor de 16 años
INSERT INTO Sesion (correo, nombre, fechanacimiento) VALUES ('user2@example.com', 'Juan Perez', TO_DATE('2000-01-01', 'YYYY-MM-DD'));

-- Actualización correcta del nombre
UPDATE Sesion SET nombre = 'Juan P. Garcia' WHERE correo = 'user1@example.com';

--Pago
-- Inserción correcta con fecha de inicio anterior a la fecha de fin
INSERT INTO Pago (sesion, fechainicio, fechafin) VALUES ('user1@example.com', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO Pago (sesion, fechainicio, fechafin) VALUES ('user2@example.com', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Actualización correcta de la fecha de fin
UPDATE Pago SET fechafin = TO_DATE('2024-12-31', 'YYYY-MM-DD') WHERE sesion = 'user1@example.com';

--tarjeta
-- Inserción correcta con fecha de vencimiento no pasada
INSERT INTO Tarjeta (numero, pago, fechaVencimiento,cvv) VALUES (123456789, 'user1@example.com', TO_DATE('2025-12-31', 'YYYY-MM-DD'),999);
INSERT INTO Tarjeta (numero, pago, fechaVencimiento,cvv) VALUES (123456698, 'user1@example.com', TO_DATE('2025-12-31', 'YYYY-MM-DD'),999);

-- Eliminación correcta si el usuario tiene más de una tarjeta
--DELETE FROM Tarjeta WHERE numero = 123456789;

--pertenece
-- Inserción correcta sin conflicto de pertenencia en el mismo período
INSERT INTO Jugador (nombre, nit, tid, nacionalidad, edad, altura, posicion) VALUES ('Jugador100', '123456789','C.C', 'Nacionalidad1', 25, 1.85, 'Portero');
INSERT INTO Equipo (nombre, ciudad, estadio, dueño) VALUES ('EquipoTemporal', 'Ciudad1', 'Estadio1', 'Dueño1');
INSERT INTO Pertenece (jugadorNit, jugadorTid, fechaInicio, fechaFin, equipo) VALUES ('123456789','C.C', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'EquipoTemporal');

--liga
-- Inserción correcta sin fechas que se crucen con otras ligas
INSERT INTO Liga (nombre, fechaInicio, fechaFin) VALUES ('Liga 1', TO_DATE('2026-01-01', 'YYYY-MM-DD'), TO_DATE('2027-12-31', 'YYYY-MM-DD'));

-- Actualización correcta solo de la fecha de fin
--UPDATE Liga SET fechaFin = TO_DATE('2026-12-31', 'YYYY-MM-DD') WHERE nombre = 'Liga 1' AND fechaInicio = TO_DATE('2026-01-01', 'YYYY-MM-DD');

--partido
-- Inserción correcta en Partido con actualización en Clasificación

INSERT INTO Equipo (nombre, ciudad, estadio, dueño) VALUES ('EquipoTemporal2', 'Ciudad12', 'Estadio1a', 'Dueño1a');
INSERT INTO Partido ( equipoLocal, equipoVisitante, golesLocal, golesVisitante, ligaNombre, ligaFecha) VALUES ( 'EquipoTemporal2', 'EquipoTemporal', 2, 1, 'Liga 1', TO_DATE('2026-01-01', 'YYYY-MM-DD'));
select * from partido;
