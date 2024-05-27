--Disparadores noOk
--SesionTrigger
-- Inserción incorrecta de usuario menor de 16 años
INSERT INTO Sesion (correo, nombre, fechanacimiento) VALUES ('younguser@example.com', 'Carlos Gomez', TO_DATE('2010-01-01', 'YYYY-MM-DD'));

-- Intento de eliminación de usuario
DELETE FROM Sesion WHERE correo = 'user1@example.com';

-- Intento de cambio de correo
UPDATE Sesion SET correo = 'user2@example.com' WHERE correo = 'user1@example.com';

-- Intento de cambio de fecha de nacimiento
UPDATE Sesion SET fechanacimiento = TO_DATE('1999-01-01', 'YYYY-MM-DD') WHERE correo = 'user1@example.com';

--Pago
-- Inserción incorrecta con fecha de inicio posterior a la fecha de fin
INSERT INTO Pago (id, fechainicio, fechafin) VALUES (2, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'));

-- Actualización incorrecta de la fecha de inicio
UPDATE Pago SET fechainicio = TO_DATE('2023-06-01', 'YYYY-MM-DD') WHERE id = 1;

-- Actualización incorrecta con fecha de fin inválida
UPDATE Pago SET fechafin = TO_DATE('2022-01-01', 'YYYY-MM-DD') WHERE id = 1;

--tarjeta
-- Inserción incorrecta con tarjeta vencida
INSERT INTO Tarjeta (id, pago, fechaVencimiento) VALUES (3, 1, TO_DATE('2020-12-31', 'YYYY-MM-DD'));

-- Eliminación incorrecta si el usuario tiene solo una tarjeta
DELETE FROM Tarjeta WHERE id = 2;

-- Actualización incorrecta de una tarjeta
UPDATE Tarjeta SET fechaVencimiento = TO_DATE('2026-12-31', 'YYYY-MM-DD') WHERE id = 1;

--pertenece
-- Inserción incorrecta con conflicto de pertenencia
INSERT INTO Pertenece (jugadorNit, jugadorTid, fechaInicio, fechaFin, equipo) VALUES ('12345', 'TID1', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-01', 'YYYY-MM-DD'), 'Equipo B');

-- Eliminación incorrecta de pertenencia
DELETE FROM Pertenece WHERE jugadorNit = '12345' AND jugadorTid = 'TID1';

-- Actualización incorrecta de pertenencia
UPDATE Pertenece SET equipo = 'Equipo C' WHERE jugadorNit = '12345' AND jugadorTid = 'TID1';
--liga
-- Inserción incorrecta con fechas que se cruzan con otras ligas
INSERT INTO Liga (nombre, fechaInicio, fechaFin) VALUES ('Liga 2', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-01', 'YYYY-MM-DD'));

-- Eliminación incorrecta de una liga
DELETE FROM Liga WHERE nombre = 'Liga 1' AND fechaInicio = TO_DATE('2023-01-01', 'YYYY-MM-DD');

-- Actualización incorrecta de una liga
UPDATE Liga SET nombre = 'Liga 3' WHERE nombre = 'Liga 1' AND fechaInicio = TO_DATE('2023-01-01', 'YYYY-MM-DD');

--partido
-- Actualización incorrecta de un partido
UPDATE Partido SET golesLocal = 3 WHERE id = 1;



