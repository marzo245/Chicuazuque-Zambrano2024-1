--Disparadores

--Definición de disparadores


-- Trigger para la tabla Sesion
CREATE TRIGGER before_insert_Sesion
BEFORE INSERT ON Sesion
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Sesion
    -- Por ejemplo, validar que el correo no esté duplicado
    IF EXISTS (SELECT 1 FROM Sesion WHERE correo = NEW.correo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo ya existe en la tabla Sesion';
    END IF;
END;

CREATE TRIGGER before_delete_Sesion
BEFORE DELETE ON Sesion
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Sesion
    -- Por ejemplo, verificar si el registro a eliminar está siendo referenciado por otras tablas
    -- Si hay restricciones de clave externa, la eliminación puede requerir consideraciones adicionales
END;

CREATE TRIGGER before_update_Sesion
BEFORE UPDATE ON Sesion
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Sesion
    -- Por ejemplo, asegurarse de que el correo no se esté cambiando a uno ya existente
    IF EXISTS (SELECT 1 FROM Sesion WHERE correo = NEW.correo AND correo != OLD.correo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede cambiar el correo a uno ya existente';
    END IF;
END;

-- Trigger para la tabla Gratis
CREATE TRIGGER before_insert_Gratis
BEFORE INSERT ON Gratis
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Gratis
    -- Por ejemplo, verificar si la sesión asociada existe en la tabla Sesion
    IF NOT EXISTS (SELECT 1 FROM Sesion WHERE correo = NEW.sesion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La sesión asociada no existe en la tabla Sesion';
    END IF;
END;

CREATE TRIGGER before_delete_Gratis
BEFORE DELETE ON Gratis
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Gratis
END;

CREATE TRIGGER before_update_Gratis
BEFORE UPDATE ON Gratis
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Gratis
END;

-- Trigger para la tabla Publicidad
CREATE TRIGGER before_insert_Publicidad
BEFORE INSERT ON Publicidad
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Publicidad
    -- Por ejemplo, validar que la URL tenga un formato adecuado
END;

CREATE TRIGGER before_delete_Publicidad
BEFORE DELETE ON Publicidad
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Publicidad
END;

CREATE TRIGGER before_update_Publicidad
BEFORE UPDATE ON Publicidad
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Publicidad
END;

-- Repetir los mismos patrones para las otras tablas (Ve, Pago, Tarjeta, Essujugadorfavorito, Essuequipofavorito, Jugador, Pertenece, Equipo, CuerpoTecnico, Partido, Liga, Clasificacion, Estadisticas)
-- Trigger para la tabla Ve
CREATE TRIGGER before_insert_Ve
BEFORE INSERT ON Ve
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Ve
    -- Por ejemplo, verificar si la publicidad y la sesión gratis asociadas existen en sus respectivas tablas
    IF NOT EXISTS (SELECT 1 FROM Publicidad WHERE nombre = NEW.publicidad) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La publicidad asociada no existe en la tabla Publicidad';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM Gratis WHERE sesion = NEW.gratis) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La sesión gratis asociada no existe en la tabla Gratis';
    END IF;
END;

CREATE TRIGGER before_delete_Ve
BEFORE DELETE ON Ve
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Ve
END;

CREATE TRIGGER before_update_Ve
BEFORE UPDATE ON Ve
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Ve
END;

-- Trigger para la tabla Pago
CREATE TRIGGER before_insert_Pago
BEFORE INSERT ON Pago
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Pago
    -- Por ejemplo, validar que la fecha de inicio sea anterior a la fecha de fin
    IF NEW.fechaInicio >= NEW.fechaFin THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de inicio debe ser anterior a la fecha de fin';
    END IF;
END;

CREATE TRIGGER before_delete_Pago
BEFORE DELETE ON Pago
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Pago
END;

CREATE TRIGGER before_update_Pago
BEFORE UPDATE ON Pago
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Pago
END;

-- Trigger para la tabla Tarjeta
CREATE TRIGGER before_insert_Tarjeta
BEFORE INSERT ON Tarjeta
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Tarjeta
    -- Por ejemplo, validar que el número de tarjeta tenga el formato adecuado
END;

CREATE TRIGGER before_delete_Tarjeta
BEFORE DELETE ON Tarjeta
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Tarjeta
END;

CREATE TRIGGER before_update_Tarjeta
BEFORE UPDATE ON Tarjeta
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Tarjeta
END;

-- Trigger para la tabla Essujugadorfavorito
CREATE TRIGGER before_insert_Essujugadorfavorito
BEFORE INSERT ON Essujugadorfavorito
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Essujugadorfavorito
    -- Por ejemplo, verificar si el pago y el jugador asociados existen en sus respectivas tablas
    IF NOT EXISTS (SELECT 1 FROM Pago WHERE sesion = NEW.pago) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El pago asociado no existe en la tabla Pago';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM Jugador WHERE nit = NEW.jugadornit AND tid = NEW.jugadortid) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El jugador asociado no existe en la tabla Jugador';
    END IF;
END;

CREATE TRIGGER before_delete_Essujugadorfavorito
BEFORE DELETE ON Essujugadorfavorito
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Essujugadorfavorito
END;

CREATE TRIGGER before_update_Essujugadorfavorito
BEFORE UPDATE ON Essujugadorfavorito
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Essujugadorfavorito
END;

-- Trigger para la tabla Essuequipofavorito
CREATE TRIGGER before_insert_Essuequipofavorito
BEFORE INSERT ON Essuequipofavorito
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Essuequipofavorito
    -- Por ejemplo, verificar si el pago asociado existe en la tabla Pago
    IF NOT EXISTS (SELECT 1 FROM Pago WHERE sesion = NEW.pago) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El pago asociado no existe en la tabla Pago';
    END IF;
END;

CREATE TRIGGER before_delete_Essuequipofavorito
BEFORE DELETE ON Essuequipofavorito
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Essuequipofavorito
END;

CREATE TRIGGER before_update_Essuequipofavorito
BEFORE UPDATE ON Essuequipofavorito
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Essuequipofavorito
END;

-- Trigger para la tabla Jugador
CREATE TRIGGER before_insert_Jugador
BEFORE INSERT ON Jugador
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Jugador
    -- Por ejemplo, validar que la edad sea un valor positivo
    IF NEW.edad < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La edad no puede ser negativa';
    END IF;
END;

CREATE TRIGGER before_delete_Jugador
BEFORE DELETE ON Jugador
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Jugador
END;

CREATE TRIGGER before_update_Jugador
BEFORE UPDATE ON Jugador
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Jugador
END;

-- Trigger para la tabla Pertenece
CREATE TRIGGER before_insert_Pertenece
BEFORE INSERT ON Pertenece
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Pertenece
    -- Por ejemplo, verificar si el jugador y el equipo asociados existen en sus respectivas tablas
    IF NOT EXISTS (SELECT 1 FROM Jugador WHERE nit = NEW.jugadorNit AND tid = NEW.jugadorTid) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El jugador asociado no existe en la tabla Jugador';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM Equipo WHERE nombre = NEW.equipo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El equipo asociado no existe en la tabla Equipo';
    END IF;
END;

CREATE TRIGGER before_delete_Pertenece
BEFORE DELETE ON Pertenece
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Pertenece
END;

CREATE TRIGGER before_update_Pertenece
BEFORE UPDATE ON Pertenece
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Pertenece
END;

-- Trigger para la tabla Equipo
CREATE TRIGGER before_insert_Equipo
BEFORE INSERT ON Equipo
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Equipo
    -- Por ejemplo, validar que el nombre del equipo sea único
    IF EXISTS (SELECT 1 FROM Equipo WHERE nombre = NEW.nombre) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre de equipo ya existe en la tabla Equipo';
    END IF;
END;

CREATE TRIGGER before_delete_Equipo
BEFORE DELETE ON Equipo
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Equipo
END;

CREATE TRIGGER before_update_Equipo
BEFORE UPDATE ON Equipo
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Equipo
END;

-- Trigger para la tabla CuerpoTecnico
CREATE TRIGGER before_insert_CuerpoTecnico
BEFORE INSERT ON CuerpoTecnico
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla CuerpoTecnico
    -- Por ejemplo, validar que el identificador (tid) sea único
    IF EXISTS (SELECT 1 FROM CuerpoTecnico WHERE tid = NEW.tid) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El identificador del cuerpo técnico ya existe';
    END IF;
END;

CREATE TRIGGER before_delete_CuerpoTecnico
BEFORE DELETE ON CuerpoTecnico
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de CuerpoTecnico
END;

CREATE TRIGGER before_update_CuerpoTecnico
BEFORE UPDATE ON CuerpoTecnico
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de CuerpoTecnico
END;

-- Trigger para la tabla Partido
CREATE TRIGGER before_insert_Partido
BEFORE INSERT ON Partido
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Partido
    -- Por ejemplo, validar que el código del partido sea único
    IF EXISTS (SELECT 1 FROM Partido WHERE codigo = NEW.codigo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El código del partido ya existe en la tabla Partido';
    END IF;
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
CREATE TRIGGER before_insert_Liga
BEFORE INSERT ON Liga
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Liga
    -- Por ejemplo, validar que la fecha de inicio sea anterior a la fecha de fin
    IF NEW.fechaInicio >= NEW.fechaFin THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de inicio de la liga debe ser anterior a la fecha de fin';
    END IF;
END;

CREATE TRIGGER before_delete_Liga
BEFORE DELETE ON Liga
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Liga
END;

CREATE TRIGGER before_update_Liga
BEFORE UPDATE ON Liga
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Liga
END;

-- Trigger para la tabla Clasificacion
CREATE TRIGGER before_insert_Clasificacion
BEFORE INSERT ON Clasificacion
FOR EACH ROW
BEGIN
    -- Acciones antes de insertar en la tabla Clasificacion
    -- Por ejemplo, validar que el equipo esté en la misma liga y fecha que se está clasificando
END;

CREATE TRIGGER before_delete_Clasificacion
BEFORE DELETE ON Clasificacion
FOR EACH ROW
BEGIN
    -- Acciones antes de eliminar un registro de Clasificacion
END;

CREATE TRIGGER before_update_Clasificacion
BEFORE UPDATE ON Clasificacion
FOR EACH ROW
BEGIN
    -- Acciones antes de actualizar un registro de Clasificacion
END;

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
