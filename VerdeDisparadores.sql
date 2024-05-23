CREATE OR REPLACE TRIGGER before_insert_Sesion
BEFORE INSERT ON Sesion
FOR EACH ROW
BEGIN
    IF TRUNC(MONTHS_BETWEEN(SYSDATE, :NEW.FECHANACIMIENTO) / 12) < 16 THEN
        raise_application_error(-20002, 'La persona debe tener al menos 16 años para registrarse');
    END IF;
END;
/
create or replace trigger before_delete_Sesion
BEFORE DELETE ON Sesion
FOR EACH ROW
BEGIN
    raise_application_error(-20002,'Un usuario una vez registrado no puede ser eliminado');
END;
/
create or replace trigger before_update_Sesion
BEFORE UPDATE ON Sesion
FOR EACH ROW
BEGIN
-- Verificar que solo se esté intentando actualizar el nombre
    IF  :OLD.correo != :NEW.correo OR :OLD.FECHANACIMIENTO != :NEW.FECHANACIMIENTO THEN
        raise_application_error(-20003, 'Solo se puede cambiar el nombre');
    END IF;
END; 
/
-- Trigger para la tabla Gratis
create or replace trigger after_insert_Sesion
AFTER INSERT ON Sesion
FOR EACH ROW
BEGIN
    INSERT INTO Gratis(sesion) VALUES(:NEW.correo);
END;
/
-- Trigger para la tabla Publicidad

create or replace trigger before_update_Publicidad
BEFORE UPDATE ON Publicidad
FOR EACH ROW
BEGIN
    raise_application_error(-20003, 'No se puede actualizar la publicidad');
END;
/
-- Trigger para la tabla Ve
--No aplicable

-- Trigger para la tabla Pago
create or replace trigger before_insert_Pago
BEFORE INSERT ON Pago
FOR EACH ROW
BEGIN
    IF :NEW.FECHAINICIO >= :NEW.FECHAFIN THEN
        raise_application_error(-20003,  'La fecha de inicio debe ser anterior a la fecha de fin');
    END IF;
END;
/

create or replace trigger before_update_Pago
BEFORE UPDATE ON Pago
FOR EACH ROW
BEGIN
    IF :OlD.FECHAINICIO != :NEW.FECHAINICIO THEN
        raise_application_error(-20003, 'La fecha de inicio no se puede actualizar');
    END IF;

    IF :NEW.fechaInicio >= :NEW.fechaFin THEN
        raise_application_error(-20003, 'La fecha de inicio debe ser anterior a la fecha de fin');
    END IF;    
END;
/
-- Trigger para la tabla Tarjeta
create or replace trigger before_insert_Tarjeta
BEFORE INSERT ON Tarjeta
FOR EACH ROW
BEGIN

    IF :NEW.fechaVencimiento >= SYSDATE THEN
        raise_application_error(-20003,  'La tarjeta ya está vencida');
    END IF;

END;
/
CREATE  TRIGGER before_delete_Tarjeta
BEFORE DELETE ON Tarjeta
FOR EACH ROW
DECLARE
    num_tarjetas NUMBER;
BEGIN
    -- Contar el número de tarjetas del usuario asociado al pago
    SELECT COUNT(*)
    INTO num_tarjetas
    FROM Tarjeta
    WHERE pago = :OLD.pago; -- 'pago' se asume como el identificador del usuario

    -- Si el usuario asociado al pago tiene solo una tarjeta, lanzar un error y cancelar la eliminación
    IF num_tarjetas <= 1 THEN
        raise_application_error(-20006, 'El usuario asociado a esta tarjeta tiene solo esta tarjeta, no se puede eliminar');
    END IF;
END;
/



create or replace trigger before_update_Tarjeta
BEFORE UPDATE ON Tarjeta
FOR EACH ROW
BEGIN
    raise_application_error(-20006, 'No se puede actualizar tarjetas de pago');
END;
/
-- Trigger para la tabla Essujugadorfavorito
-- Trigger para la tabla Essuequipofavorito



-- Trigger para la tabla Jugador

-- Trigger para la tabla Pertenece
-- Trigger para la tabla Pertenece en Oracle que verifica si el jugador ya pertenece a otro equipo durante el período de tiempo especificado
create or replace trigger before_insert_Pertenece
BEFORE INSERT ON Pertenece
FOR EACH ROW
DECLARE
    num_pertenencias NUMBER;
BEGIN
    -- Contar el número de pertenencias del jugador a otros equipos durante el período de tiempo especificado
    SELECT COUNT(*)
    INTO num_pertenencias
    FROM Pertenece
    WHERE jugadorNit = :NEW.jugadorNit
    AND jugadorTid = :NEW.jugadorTid
    AND ((fechaInicio BETWEEN :NEW.fechaInicio AND :NEW.fechaFin)
        OR (fechaFin BETWEEN :NEW.fechaInicio AND :NEW.fechaFin)
        OR (fechaInicio <= :NEW.fechaInicio AND fechaFin >= :NEW.fechaFin));

    -- Si el jugador pertenece a otro equipo durante el período de tiempo especificado, lanzar un error y cancelar la inserción
    IF num_pertenencias > 0 THEN
        raise_application_error(-20007, 'El jugador ya pertenece a otro equipo durante este período de tiempo');
    END IF;
END;
/


create or replace trigger before_delete_Pertenece
BEFORE DELETE ON Pertenece
FOR EACH ROW
BEGIN
    raise_application_error(-20007, 'No se puede eliminar una pertenencia de un jugador');
END;
/
create or replace trigger before_update_Pertenece
BEFORE UPDATE ON Pertenece
FOR EACH ROW
BEGIN
   raise_application_error(-20007, 'No se puede actualizar una pertenencia de un jugador');
END;
/
-- Trigger para la tabla Equipo

create or replace trigger before_delete_Equipo
BEFORE DELETE ON Equipo
FOR EACH ROW
BEGIN
    raise_application_error(-20007, 'No se puede eliminar un equipo');
END;
/
create or replace trigger before_update_Equipo
BEFORE UPDATE ON Equipo
FOR EACH ROW
BEGIN
    raise_application_error(-20007, 'No se puede actualizar un equipo');
END;
/
-- Trigger para la tabla CuerpoTecnico

-- Trigger para la tabla Partido

create or replace trigger before_delete_Partido
BEFORE DELETE ON Partido
FOR EACH ROW
BEGIN
   raise_application_error(-20007, 'No se puede');
END;
/

-- Trigger para la tabla Liga
CREATE OR REPLACE TRIGGER before_insert_Liga
BEFORE INSERT ON Liga
FOR EACH ROW
DECLARE
    liga_cruzada NUMBER;
BEGIN
    -- Verificar si existen otras ligas con fechas que se crucen con la nueva liga
    SELECT COUNT(*)
    INTO liga_cruzada
    FROM Liga
    WHERE (:NEW.fechaInicio BETWEEN fechaInicio AND NVL(fechaFin, SYSDATE)
        OR :NEW.fechaFin BETWEEN fechaInicio AND NVL(fechaFin, SYSDATE)
        OR (fechaInicio BETWEEN :NEW.fechaInicio AND :NEW.fechaFin)
        OR (NVL(fechaFin, SYSDATE) BETWEEN :NEW.fechaInicio AND :NEW.fechaFin));
    -- Si hay otras ligas con fechas que se crucen, lanzar un error y cancelar la inserción
    IF liga_cruzada > 0 THEN
        raise_application_error(-20008, 'Las fechas de inicio y fin de la liga se cruzan con otras ligas existentes');
    END IF;
END;
/


create or replace trigger before_delete_Liga
BEFORE DELETE ON Liga
FOR EACH ROW
BEGIN
   raise_application_error(-20008, 'No se puede eliminar una liga');
END;
/
-- Trigger para la tabla Liga en Oracle que permite actualizar solo la fecha fin y verifica que no se crucen con otras ligas
CREATE OR REPLACE TRIGGER before_update_Liga
BEFORE UPDATE OF fechaFin ON Liga
FOR EACH ROW
DECLARE
    liga_cruzada NUMBER;
BEGIN
    -- Verificar si la nueva fecha fin se cruza con otras ligas
    SELECT COUNT(*)
    INTO liga_cruzada
    FROM Liga
    WHERE fechaInicio <= :NEW.fechaFin
    AND (NVL(fechaFin, SYSDATE) >= :NEW.fechaFin OR :NEW.fechaFin IS NULL)
    AND (nombre != :OLD.nombre OR fechaInicio != :OLD.fechaInicio); -- Excluir la liga actualizada

    -- Si la nueva fecha fin se cruza con otras ligas, lanzar un error y cancelar la actualización
    IF liga_cruzada > 0 THEN
        raise_application_error(-20009, 'La nueva fecha fin de la liga se cruza con otras ligas existentes');
    END IF;
END;
/


-- Trigger para la tabla Clasificacion
CREATE OR REPLACE TRIGGER TR_after_insert_partido
AFTER INSERT ON Partido
FOR EACH ROW
DECLARE
    equipo_local VARCHAR2(30);
    equipo_visitante VARCHAR2(30);
    goles_local INT;
    goles_visitante INT;
    puntos_local INT;
    puntos_visitante INT;
    pos_local INT;
    pos_visitante INT;
BEGIN
    -- Obtener información del partido recién insertado
    equipo_local := :NEW.equipoLocal;
    equipo_visitante := :NEW.equipoVisitante;
    goles_local := :NEW.golesLocal;
    goles_visitante := :NEW.golesVisitante;

    -- Determinar los puntos de cada equipo basado en el resultado del partido
    IF goles_local > goles_visitante THEN
        puntos_local := 3; -- Victoria del equipo local
        puntos_visitante := 0;
    ELSIF goles_local < goles_visitante THEN
        puntos_local := 0;
        puntos_visitante := 3; -- Victoria del equipo visitante
    ELSE
        puntos_local := 1; -- Empate
        puntos_visitante := 1;
    END IF;

    -- Verificar si la tabla de Clasificación está vacía para el equipo local
    SELECT COUNT(*) INTO pos_local
    FROM Clasificacion
    WHERE equipo = equipo_local AND ligaNombre = :NEW.ligaNombre AND ligaFecha = :NEW.ligaFecha;

    -- Insertar al equipo local si la tabla está vacía
    IF pos_local = 0 THEN
        INSERT INTO Clasificacion (ligaNombre, ligaFecha, equipo, puesto, partidosGanados, partidosEmpatados, partidosPerdidos, puntos)
        VALUES (:NEW.ligaNombre, :NEW.ligaFecha, equipo_local, 0, 0, 0, 0, 0);
    END IF;

    -- Verificar si la tabla de Clasificación está vacía para el equipo visitante
    SELECT COUNT(*) INTO pos_visitante
    FROM Clasificacion
    WHERE equipo = equipo_visitante AND ligaNombre = :NEW.ligaNombre AND ligaFecha = :NEW.ligaFecha;

    -- Insertar al equipo visitante si la tabla está vacía
    IF pos_visitante = 0 THEN
        INSERT INTO Clasificacion (ligaNombre, ligaFecha, equipo, puesto, partidosGanados, partidosEmpatados, partidosPerdidos, puntos)
        VALUES (:NEW.ligaNombre, :NEW.ligaFecha, equipo_visitante, 0, 0, 0, 0, 0);
    END IF;

    -- Actualizar la clasificación para el equipo local
    UPDATE Clasificacion
    SET
        puntos = puntos + puntos_local,
        partidosGanados = partidosGanados + CASE WHEN puntos_local = 3 THEN 1 ELSE 0 END,
        partidosEmpatados = partidosEmpatados + CASE WHEN puntos_local = 1 THEN 1 ELSE 0 END,
        partidosPerdidos = partidosPerdidos + CASE WHEN puntos_local = 0 AND puntos_visitante = 3 THEN 1 ELSE 0 END
    WHERE equipo = equipo_local AND ligaNombre = :NEW.ligaNombre AND ligaFecha = :NEW.ligaFecha;

    -- Actualizar la clasificación para el equipo visitante
    UPDATE Clasificacion
    SET
        puntos = puntos + puntos_visitante,
        partidosGanados = partidosGanados + CASE WHEN puntos_visitante = 3 THEN 1 ELSE 0 END,
        partidosEmpatados = partidosEmpatados + CASE WHEN puntos_visitante = 1 THEN 1 ELSE 0 END,
        partidosPerdidos = partidosPerdidos + CASE WHEN puntos_visitante = 0 AND puntos_local = 3 THEN 1 ELSE 0 END
    WHERE equipo = equipo_visitante AND ligaNombre = :NEW.ligaNombre AND ligaFecha = :NEW.ligaFecha;

    -- Actualizar la tabla de Clasificación para calcular los puestos
    FOR rec IN (
        SELECT equipo, ligaNombre, ligaFecha,
               ROW_NUMBER() OVER (ORDER BY puntos DESC, partidosGanados DESC, partidosEmpatados DESC, partidosPerdidos ASC) AS rnum
        FROM Clasificacion
        WHERE ligaNombre = :NEW.ligaNombre AND ligaFecha = :NEW.ligaFecha
    ) LOOP
        UPDATE Clasificacion
        SET
            puesto = rec.rnum
        WHERE equipo = rec.equipo AND ligaNombre = rec.ligaNombre AND ligaFecha = rec.ligaFecha;
    END LOOP;

END;
/

CREATE OR REPLACE TRIGGER TR_before_update_partido
BEFORE UPDATE ON Partido
FOR EACH ROW
DECLARE
    equipo_local VARCHAR2(30);
    equipo_visitante VARCHAR2(30);
    goles_local INT;
    goles_local_old INT;
    goles_visitante INT;
    goles_visitante_old INT;
    puntos_local INT;
    puntos_local_old INT;
    puntos_visitante INT;
    puntos_visitante_old INT;
BEGIN
    -- Obtener información del partido recién actualizado
    equipo_local := :NEW.equipoLocal;
    equipo_visitante := :NEW.equipoVisitante;
    goles_local := :NEW.golesLocal;
    goles_local_old := :OLD.golesLocal;
    goles_visitante := :NEW.golesVisitante;
    goles_visitante_old := :OLD.golesVisitante;

    -- Determinar los puntos de cada equipo basado en el resultado del partido nuevo y viejo
    IF goles_local > goles_visitante THEN
        puntos_local := 3; -- Victoria del equipo local
        puntos_visitante := 0;
    ELSIF goles_local < goles_visitante THEN
        puntos_local := 0;
        puntos_visitante := 3; -- Victoria del equipo visitante
    ELSE
        puntos_local := 1; -- Empate
        puntos_visitante := 1;
    END IF;

    IF goles_local_old > goles_visitante_old THEN
        puntos_local_old := 3; -- Victoria del equipo local
        puntos_visitante_old := 0;
    ELSIF goles_local_old < goles_visitante_old THEN
        puntos_local_old := 0;
        puntos_visitante_old := 3; -- Victoria del equipo visitante
    ELSE
        puntos_local_old := 1; -- Empate
        puntos_visitante_old := 1;
    END IF;

    -- Actualizar la clasificación para el equipo local
    UPDATE Clasificacion
    SET
        puntos = puntos - puntos_local_old + puntos_local,
        partidosGanados = partidosGanados + CASE WHEN puntos_local = 3 THEN 1 WHEN puntos_local_old = 3 THEN -1 ELSE 0 END,
        partidosEmpatados = partidosEmpatados + CASE WHEN puntos_local = 1 THEN 1 WHEN puntos_local_old = 1 THEN -1 ELSE 0 END,
        partidosPerdidos = partidosPerdidos + CASE WHEN puntos_local = 0 AND puntos_visitante = 3 THEN 1 WHEN puntos_local_old = 0 AND puntos_visitante_old = 3 THEN -1 ELSE 0 END
    WHERE equipo = equipo_local AND ligaNombre = :NEW.ligaNombre AND ligaFecha = :NEW.ligaFecha;

    -- Actualizar la clasificación para el equipo visitante
    UPDATE Clasificacion
    SET
        puntos = puntos - puntos_visitante_old + puntos_visitante,
        partidosGanados = partidosGanados + CASE WHEN puntos_visitante = 3 THEN 1 WHEN puntos_visitante_old = 3 THEN -1 ELSE 0 END,
        partidosEmpatados = partidosEmpatados + CASE WHEN puntos_visitante = 1 THEN 1 WHEN puntos_visitante_old = 1 THEN -1 ELSE 0 END,
        partidosPerdidos = partidosPerdidos + CASE WHEN puntos_visitante = 0 AND puntos_local = 3 THEN 1 WHEN puntos_visitante_old = 0 AND puntos_local_old = 3 THEN -1 ELSE 0 END
    WHERE equipo = equipo_visitante AND ligaNombre = :NEW.ligaNombre AND ligaFecha = :NEW.ligaFecha;

    -- Actualizar la tabla de Clasificación para calcular los puestos
    FOR rec IN (
        SELECT equipo, ligaNombre, ligaFecha,
               ROW_NUMBER() OVER (ORDER BY puntos DESC, partidosGanados DESC, partidosEmpatados DESC, partidosPerdidos ASC) AS rnum
        FROM Clasificacion
        WHERE ligaNombre = :NEW.ligaNombre AND ligaFecha = :NEW.ligaFecha
    ) LOOP
        UPDATE Clasificacion
        SET
            puesto = rec.rnum
        WHERE equipo = rec.equipo AND ligaNombre = rec.ligaNombre AND ligaFecha = rec.ligaFecha;
    END LOOP;

END;
/

-- Trigger para la tabla Estadisticas
--CREATE OR REPLACE TRIGGER TR_BEFORE_INSERT_Partido
--BEFORE INSERT ON Partido
--FOR EACH ROW
--DECLARE
    --v_max_id NUMBER;
--BEGIN
    -- Asignar un nuevo ID si el ID entrante no está especificado o ya existe
    --IF :NEW.id_pa IS NULL THEN
        -- Obtener el máximo ID actual y asignar el siguiente valor
      --  SELECT COALESCE(MAX(id_pa) + 1, 1) INTO :NEW.id_pa FROM Partido;
    --ELSE
     --   RAISE_APPLICATION_ERROR(-20001, 'Las IDs de partido se asignan automáticamente');
    --END IF;
--END;
--/
