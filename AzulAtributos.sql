----Estructura y Restricciones Declarativas
--Atributos. Definición de restricciones para un único atributos (TIpos)

--Sesion
ALTER TABLE Sesion ADD CONSTRAINT CK_Sesion_Tcorreo CHECK(Correo LIKE '%@%' AND Correo LIKE '%.%' AND Correo NOT LIKE '%@%.' AND Correo NOT LIKE '%.@%' AND Correo NOT LIKE '%..%');

--Gratis
--No hay restricciones

--Publicidad
ALTER TABLE Publicidad ADD CONSTRAINT CK_Publicidad_URL CHECK(URL LIKE 'http://%' OR URL LIKE 'https://%' OR URL LIKE 'www.%');

--Ve
--No hay restricciones

--Pago
--No hay restricciones

--Tarjeta
--No hay restricciones

--Es su jugador favorito
--No hay restricciones

--Es su equipo favorito
--No hay restricciones

--Jugador
ALTER TABLE Jugador ADD CONSTRAINT CK_Jugador_Tidentificacion CHECK(tid in ('C.C','C.E','T.I'));
ALTER TABLE Jugador ADD CONSTRAINT CK_Jugador_Posicion CHECK(Posicion in ('Portero','Defensa','MedioCampista','Delantero'));

--Pertenece
--No hay restricciones

--Equipo
--No hay restricciones

--Cuerpo tecnico
ALTER TABLE CuerpoTecnico ADD CONSTRAINT CK_CuerpoTecnico_Tidentificacion CHECK(tid in ('C.C','C.E','T.I'));
ALTER TABLE CuerpoTecnico ADD CONSTRAINT CK_CuerpoTecnico_Rol CHECK(cargo in ('Entrenador','Asistente','Preparador Fisico','Medico'));

--Partido
--No hay restricciones

--Liga
--No hay restricciones

--Clasificacion
--No hay restricciones

--Estadisticas
--No hay restricciones