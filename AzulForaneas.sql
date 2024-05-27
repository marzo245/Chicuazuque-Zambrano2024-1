----Estructura y Restricciones Declarativas
-- Foraneas. Definición de claves foraneas
--Aviso
ALTER TABLE AVISO ADD CONSTRAINT FK_Aviso_Session FOREIGN KEY(sesion) REFERENCES SESION(correo);
--Sesion
--No hay claves foraneas

--Gratis
ALTER TABLE Gratis ADD CONSTRAINT FK_Gratis_Sesion FOREIGN KEY (sesion) REFERENCES Sesion(correo);

--Publicidad
--No hay claves foraneas

--Ve
ALTER TABLE Ve ADD CONSTRAINT FK_Ve_Publicidad FOREIGN KEY (publicidad) REFERENCES Publicidad(nombre);

ALTER TABLE Ve ADD CONSTRAINT FK_Ve_Gratis FOREIGN KEY (gratis) REFERENCES Gratis(sesion);

--Pago
ALTER TABLE Pago ADD CONSTRAINT FK_Pago_Sesion FOREIGN KEY (sesion) REFERENCES Sesion(correo);

--Tarjeta
ALTER TABLE Tarjeta ADD CONSTRAINT FK_Tarjeta_Pago FOREIGN KEY (pago) REFERENCES Pago(sesion);

--Es su jugador favorito
ALTER TABLE Essujugadorfavorito ADD CONSTRAINT FK_Essujugadorfavorito_Pago FOREIGN KEY (pago) REFERENCES Pago(sesion);
ALTER TABLE Essujugadorfavorito ADD CONSTRAINT FK_Essujugadorfavorito_JugadorT FOREIGN KEY (jugadornit,jugadortid) REFERENCES Jugador(nit,tid);

--Es su equipo favorito
ALTER TABLE Essuequipofavorito ADD CONSTRAINT FK_Essuequipofavorito_Pago FOREIGN KEY (pago) REFERENCES Pago(sesion);
ALTER TABLE Essuequipofavorito ADD CONSTRAINT FK_Essuequipofavorito_Equipo FOREIGN KEY (equipo) REFERENCES Equipo(nombre);

--Jugador
--No hay claves foraneas

--Pertenece
ALTER TABLE Pertenece ADD CONSTRAINT FK_Pertenece_Equipo FOREIGN KEY (equipo) REFERENCES Equipo(nombre);
ALTER TABLE Pertenece ADD CONSTRAINT FK_Pertenece_JugadorN FOREIGN KEY (jugadornit,jugadortid) REFERENCES Jugador(nit,tid);



--Equipo
--No hay claves foraneas

--Cuerpo tecnico
ALTER TABLE CuerpoTecnico ADD CONSTRAINT FK_CuerpoTecnico_Equipo FOREIGN KEY (equipo) REFERENCES Equipo(nombre);

--Partido
ALTER TABLE Partido ADD CONSTRAINT FK_Partido_EquipoL FOREIGN KEY (equipoLocal) REFERENCES Equipo(nombre);
ALTER TABLE Partido ADD CONSTRAINT FK_Partido_EquipoV FOREIGN KEY (equipoVisitante) REFERENCES Equipo(nombre);
ALTER TABLE Partido ADD CONSTRAINT FK_Partido_LigaNombre FOREIGN KEY (ligaNombre,ligaFecha) REFERENCES Liga(nombre,fechaInicio);

--Liga
ALTER TABLE Liga ADD CONSTRAINT FK_Liga_EquipoG FOREIGN KEY (ganador) REFERENCES Equipo(nombre);

--Clasificacion
ALTER TABLE Clasificacion ADD CONSTRAINT FK_Clasificacion_Equipo FOREIGN KEY (equipo) REFERENCES Equipo(nombre);
ALTER TABLE Clasificacion ADD CONSTRAINT FK_Clasificacion_LigaNombre FOREIGN KEY (ligaNombre,ligaFecha) REFERENCES Liga(nombre,fechaInicio);


--Estadisticas
ALTER TABLE Estadisticas ADD CONSTRAINT FK_Estadisticas_JugadorN FOREIGN KEY (jugadornit,jugadortid) REFERENCES Jugador(nit,tid);
ALTER TABLE Estadisticas ADD CONSTRAINT FK_Estadisticas_Partido FOREIGN KEY (partidocodigo) REFERENCES Partido(codigo);
ALTER TABLE Estadisticas ADD CONSTRAINT FK_Estadisticas_Equipo FOREIGN KEY (equipo) REFERENCES Equipo(nombre);