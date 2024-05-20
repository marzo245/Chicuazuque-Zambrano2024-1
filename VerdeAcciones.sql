--definicion acciones--

--Al eliminar una sesion se eliminan en cascada los registros de esta en la tabla gratis--

ALTER TABLE Gratis
ADD CONSTRAINT FK_Gratis_Sesion
FOREIGN KEY (sesion)
REFERENCES Sesion(correo)
ON DELETE CASCADE;

--Al eliminar Gratis se eliminan en cascada los registros de esta en la tabla Ve--

ALTER TABLE Ve
ADD CONSTRAINT FK_Ve_Gratis
FOREIGN KEY (gratis)
REFERENCES Gratis(sesion)
ON DELETE CASCADE;

--Al eliminar publiicidades se eliminan en cascada los registros de esta en la tabla Ve--

ALTER TABLE Ve
ADD CONSTRAINT FK_Ve_Publicidad
FOREIGN KEY (publicidad)
REFERENCES Publicidad(nombre)
ON DELETE CASCADE;

--Al tratar de eliminar una sesion con pagos asociados se produce un error y la operacion se restringe--

ALTER TABLE Pago
ADD CONSTRAINT FK_Pago_Sesion
FOREIGN KEY (sesion)
REFERENCES Sesion(correo)
ON DELETE RESTRICT;

--Al tratar de eliminar pagos se eliminaran en cascada los registros de tarjeta--

ALTER TABLE Tarjeta
ADD CONSTRAINT FK_Tarjeta_Pago
FOREIGN KEY (pago)
REFERENCES Pago(sesion)
ON DELETE CASCADE;

--Al tratar de eliminar pagos con jugador y equipo asociados se elimina en cascada--

ALTER TABLE EsSuJugadorFavorito
ADD CONSTRAINT FK_EsSuJugadorFavorito_Pago
FOREIGN KEY (pago)
REFERENCES Pago(sesion)
ON DELETE CASCADE;

ALTER TABLE Essuequipofavorito
ADD CONSTRAINT FK_Essuequipofavorito_Pago
FOREIGN KEY (pago)
REFERENCES Pago(sesion)
ON DELETE CASCADE;

--Al tratar de eliminar una tarjeta asosiada a un pago se produce un error y la operacion se restringe--

ALTER TABLE Tarjeta
ADD CONSTRAINT FK_Tarjeta_Pago
FOREIGN KEY (pago)
REFERENCES Pago(sesion)
ON DELETE RESTRICT;

--Al tratar de eliminar un jugador asosiado a un (jugadorfav,pertenece,estadisticas) se elimina en cascada--


ALTER TABLE Essujugadorfavorito 
ADD CONSTRAINT FK_Essujugadorfavorito_JugadorT 
FOREIGN KEY (jugadornit) REFERENCES Jugador(nit)
ON DELETE CASCADE;

ALTER TABLE Essujugadorfavorito 
ADD CONSTRAINT FK_Essujugadorfavorito_JugadorN 
FOREIGN KEY (jugadortid) REFERENCES Jugador(tid)
ON DELETE CASCADE;


ALTER TABLE Pertenece 
ADD CONSTRAINT FK_Pertenece_JugadorN 
FOREIGN KEY (jugadorNit) 
REFERENCES Jugador(nit)
ON DELETE CASCADE;

ALTER TABLE Perteneces 
ADD CONSTRAINT FK_Pertenece_JugadorT 
FOREIGN KEY (jugadorTid) 
REFERENCES Jugador(tid)
ON DELETE CASCADE;

--Al tratar de eliminar un equipo y este tiene asociados (estadisticas,ligas,partidos,pertenece,cuerpo tecnico) sale error y se restringe la operacion--

ALTER TABLE Essuequipofavorito 
ADD CONSTRAINT FK_Essuequipofavorito_Equipo 
FOREIGN KEY (equipo) 
REFERENCES Equipo(nombre)
ON DELETE RESTRICT;

ALTER TABLE Pertenece 
ADD CONSTRAINT FK_Pertenece_Equipo 
FOREIGN KEY (equipo) 
REFERENCES Equipo(nombre)
ON DELETE RESTRICT;

ALTER TABLE CuerpoTecnico 
ADD CONSTRAINT FK_CuerpoTecnico_Equipo 
FOREIGN KEY (equipo) 
REFERENCES Equipo(nombre)
ON DELETE RESTRICT;

ALTER TABLE Partido 
ADD CONSTRAINT FK_Partido_EquipoL 
FOREIGN KEY (equipoLocal) 
REFERENCES Equipo(nombre)
ON DELETE RESTRICT;

ALTER TABLE Partido 
ADD CONSTRAINT FK_Partido_EquipoV 
FOREIGN KEY (equipoVisitante) 
REFERENCES Equipo(nombre)
ON DELETE RESTRICT;

ALTER TABLE Liga 
ADD CONSTRAINT FK_Liga_EquipoG 
FOREIGN KEY (ganador) 
REFERENCES Equipo(nombre)
ON DELETE RESTRICT;

ALTER TABLE Clasificacion 
ADD CONSTRAINT FK_Clasificacion_Equipo 
FOREIGN KEY (equipo) 
REFERENCES Equipo(nombre)
ON DELETE RESTRICT;

ALTER TABLE Estadisticas 
ADD CONSTRAINT FK_Estadisticas_Equipo 
FOREIGN KEY (equipo) 
REFERENCES Equipo(nombre)
ON DELETE RESTRICT;


--Al eliminar un partido se elimian sus estadisticas--

ALTER TABLE Estadisticas 
ADD CONSTRAINT FK_Estadisticas_Partido 
FOREIGN KEY (partido) 
REFERENCES Partido(id)
ON DELETE CASCADE;

--AL eliminar una liga se eliminan los registros asociodos a esta--

ALTER TABLE Partido 
ADD CONSTRAINT FK_Partido_LigaNombre 
FOREIGN KEY (ligaNombre) 
REFERENCES Liga(nombre)
ON DELETE CASCADE;

ALTER TABLE Partido 
ADD CONSTRAINT FK_Partido_ligaFecha 
FOREIGN KEY (ligaFecha) 
REFERENCES Liga(fechaIncial)
ON DELETE CASCADE;

ALTER TABLE Clasificacion 
ADD CONSTRAINT FK_Clasificacion_LigaNombre 
FOREIGN KEY (ligaNombre) 
REFERENCES Liga(nombre)
ON DELETE CASCADE;


ALTER TABLE Clasificacion 
ADD CONSTRAINT FK_Clasificacion_LigaFecha 
FOREIGN KEY (ligaFecha) 
REFERENCES Liga(fechaIncial)
ON DELETE CASCADE;



