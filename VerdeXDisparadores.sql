-- Triggers para la tabla Aviso
DROP TRIGGER after_insert_Sesion_Aviso;
DROP TRIGGER before_delete_Sesion_Aviso;
DROP TRIGGER prevent_delete_alerts;

-- Trigger para la tabla Sesion
DROP TRIGGER before_insert_Sesion;
DROP TRIGGER before_delete_Sesion;
DROP TRIGGER before_update_Sesion;

-- Trigger para la tabla Gratis
DROP TRIGGER after_insert_Sesion;

-- Trigger para la tabla Publicidad
DROP TRIGGER before_update_Publicidad;

-- Trigger para la tabla Pago
DROP TRIGGER before_insert_Pago;
DROP TRIGGER before_update_Pago;

-- Trigger para la tabla Tarjeta
DROP TRIGGER before_insert_Tarjeta;
DROP TRIGGER before_delete_Tarjeta;
DROP TRIGGER before_update_Tarjeta;

-- Trigger para la tabla Pertenece
DROP TRIGGER before_insert_Pertenece;
DROP TRIGGER before_delete_Pertenece;
DROP TRIGGER before_update_Pertenece;

-- Trigger para la tabla Equipo
DROP TRIGGER before_delete_Equipo;
DROP TRIGGER before_update_Equipo;

-- Trigger para la tabla Partido
DROP TRIGGER before_delete_Partido;

-- Trigger para la tabla Liga
DROP TRIGGER before_insert_Liga;
DROP TRIGGER before_delete_Liga;
DROP TRIGGER before_update_Liga;

-- Trigger para la tabla Clasificacion
DROP TRIGGER TR_after_insert_partido;
DROP TRIGGER TR_before_update_partido;
