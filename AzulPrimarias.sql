----Estructura y Restricciones Declarativas
--Primarias. Definición de claves primarias
--Aviso
ALTER TABLE Aviso ADD PRIMARY KEY(id);
--Sesion
ALTER TABLE Sesion ADD PRIMARY KEY (correo);

--Gratis
ALTER TABLE Gratis ADD PRIMARY KEY (sesion);

--Publicidad
ALTER TABLE Publicidad ADD PRIMARY KEY (nombre);

--Ve
ALTER TABLE Ve ADD PRIMARY KEY (publicidad,gratis);

--Pago
ALTER TABLE Pago ADD PRIMARY KEY (sesion);

--Tarjeta
ALTER TABLE Tarjeta ADD PRIMARY KEY (pago);

--Es su jugador favorito
ALTER TABLE Essujugadorfavorito ADD PRIMARY KEY (pago,jugadornit,jugadortid);

--Es su equipo favorito
ALTER TABLE Essuequipofavorito ADD PRIMARY KEY (pago,equipo);

--Jugador
ALTER TABLE Jugador ADD PRIMARY KEY (nit,tid);

--Pertenece
ALTER TABLE Pertenece ADD PRIMARY KEY (jugadorNit,jugadorTid,equipo,fechaInicio,fechaFin);

--Equipo
ALTER TABLE Equipo ADD PRIMARY KEY (nombre);

--Cuerpo tecnico
ALTER TABLE CuerpoTecnico ADD PRIMARY KEY (tid,nid);

--Partido
ALTER TABLE Partido ADD PRIMARY KEY (codigo);

--Liga
ALTER TABLE Liga ADD PRIMARY KEY (nombre,fechaInicio);

--Clasificacion
ALTER TABLE Clasificacion ADD PRIMARY KEY (equipo,Liganombre,ligafecha);

--Estadisticas
ALTER TABLE Estadisticas ADD PRIMARY KEY (partidocodigo);


