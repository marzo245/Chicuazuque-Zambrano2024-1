--Disparadores

--Definición de disparadores


-- Trigger para la tabla Sesion
CREATE TRIGGER before_insert_Sesion
BEFORE INSERT ON Sesion
FOR EACH ROW
BEGIN
    IF ADD_MONTHS(:NEW.fechaNacimineto, 12 * 16) > SYSDATE THEN
        raise_application_error(-20002, 'La persona debe tener al menos 16 años para registrarse');
    END IF;
END;

CREATE TRIGGER before_delete_Sesion
BEFORE DELETE ON Sesion
FOR EACH ROW
BEGIN
    raise_application_error(-20002,'Un usuario una vez registrado no puede ser eliminado');
END;

CREATE TRIGGER before_update_Sesion
BEFORE UPDATE ON Sesion
FOR EACH ROW
BEGIN
-- Verificar que solo se esté intentando actualizar el nombre
    IF  :OLD.correo != :NEW.correo OR :OLD.fechaNacimineto != :NEW.fechaNacimineto THEN
        raise_application_error(-20003, 'Solo se puede cambiar el nombre');
    END IF;
END; 

-- Trigger para la tabla Gratis
CREATE TRIGGER after_insert_Sesion
AFTER INSERT ON Sesion
FOR EACH ROW
BEGIN
    INSERT INTO Gratis(sesion) VALUES(:NEW.correo);
END;

-- Trigger para la tabla Publicidad

CREATE TRIGGER before_update_Publicidad
BEFORE UPDATE ON Publicidad
FOR EACH ROW
BEGIN
    raise_application_error(-20003, 'No se puede actualizar la publicidad');
END;

-- Trigger para la tabla Ve
--No aplicable

-- Trigger para la tabla Pago
CREATE TRIGGER before_insert_Pago
BEFORE INSERT ON Pago
FOR EACH ROW
BEGIN
    IF :NEW.fechaInicio >= :NEW.fechaFin THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de inicio debe ser anterior a la fecha de fin';
    END IF;
END;


CREATE TRIGGER before_update_Pago
BEFORE UPDATE ON Pago
FOR EACH ROW
BEGIN
    IF OlD.fechaInicio != NEW.fechaInicio THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de inicio no se puede actualizar';
    END IF;

    IF NEW.fechaInicio >= NEW.fechaFin THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de inicio debe ser anterior a la fecha de fin';
    END IF;    
END;

-- Trigger para la tabla Tarjeta
CREATE TRIGGER before_insert_Tarjeta
BEFORE INSERT ON Tarjeta
FOR EACH ROW
BEGIN
    
    IF NEW.fechaVencimiento >= SYSDATE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La tarjeta ya está vencida';
    END IF;

END;

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




CREATE TRIGGER before_update_Tarjeta
BEFORE UPDATE ON Tarjeta
FOR EACH ROW
BEGIN
    raise_application_error(-20006, 'No se puede actualizar tarjetas de pago');
END;

-- Trigger para la tabla Essujugadorfavorito
-- Trigger para la tabla Essuequipofavorito



-- Trigger para la tabla Jugador

-- Trigger para la tabla Pertenece
-- Trigger para la tabla Pertenece en Oracle que verifica si el jugador ya pertenece a otro equipo durante el período de tiempo especificado
CREATE TRIGGER before_insert_Pertenece
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



CREATE TRIGGER before_delete_Pertenece
BEFORE DELETE ON Pertenece
FOR EACH ROW
BEGIN
    raise_application_error(-20007, 'No se puede eliminar una pertenencia de un jugador');
END;

CREATE TRIGGER before_update_Pertenece
BEFORE UPDATE ON Pertenece
FOR EACH ROW
BEGIN
   raise_application_error(-20007, 'No se puede actualizar una pertenencia de un jugador');
END;

-- Trigger para la tabla Equipo

CREATE TRIGGER before_delete_Equipo
BEFORE DELETE ON Equipo
FOR EACH ROW
BEGIN
    raise_application_error(-20007, 'No se puede eliminar un equipo');
END;

CREATE TRIGGER before_update_Equipo
BEFORE UPDATE ON Equipo
FOR EACH ROW
BEGIN
    raise_application_error(-20007, 'No se puede actualizar un equipo');
END;

-- Trigger para la tabla CuerpoTecnico

-- Trigger para la tabla Partido
CREATE TRIGGER before_insert_Partido
BEFORE INSERT ON Partido
FOR EACH ROW
BEGIN

END;

CREATE TRIGGER before_delete_Partido
BEFORE DELETE ON Partido
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Partido
END;

CREATE TRIGGER before_update_Partido
BEFORE UPDATE ON Partido
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Partido
END;

-- Trigger para la tabla Liga
-- Trigger para la tabla Liga en Oracle que verifica que las fechas de inicio y fin no se crucen con otras ligas
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



CREATE TRIGGER before_delete_Liga
BEFORE DELETE ON Liga
FOR EACH ROW
BEGIN
   raise_application_error(-20008, 'No se puede eliminar una liga');
END;

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



-- Trigger para la tabla Clasificacion


-- Trigger para la tabla Estadisticas
CREATE TRIGGER before_insert_Estadisticas
BEFORE INSERT ON Estadisticas
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Estadisticas
    -- Por ejemplo, validar que el partido asociado exista en la tabla Partido
    IF NOT EXISTS (SELECT 1 FROM Partido WHERE codigo = NEW.partidoCodigo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El partido asociado no existe en la tabla Partido';
    END IF;
END;

CREATE TRIGGER before_delete_Estadisticas
BEFORE DELETE ON Estadisticas
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Estadisticas
END;

CREATE TRIGGER before_update_Estadisticas
BEFORE UPDATE ON Estadisticas
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Estadisticas
END;
