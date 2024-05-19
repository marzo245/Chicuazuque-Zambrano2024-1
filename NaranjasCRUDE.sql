
--CRUDE

--Creación de tablas

--Sesion
CREATE TABLE Sesion(
    correo varchar(60) not null,
    nombre VARCHAR(20) not null,
    fechaNacimineto date not NULL
);

--Gratis
CREATE TABLE Gratis(
    sesion varchar(60) not null
);

--Publicidad
CREATE TABLE Publicidad(
    nombre varchar(20) not null,
    URL varchar(100) not null
);

--ve
CREATE TABLE Ve(
    publicidad varchar(20) not null,
    gratis varchar(60) not null
);

--Pago
CREATE TABLE Pago(
    sesion varchar(60) not null,
    fechaIncio date not null,
    fechaFin date not null
);
--Tarjeta
CREATE TABLE Tarjeta(
    numero int not null,
    fechaVencimiento date not null,
    cvv int not null,
    pago VARCHAR(60) not null
);

--Es su jugador favorito
CREATE TABLE Essujugadorfavorito(
    pago varchar(60) not null,
    jugadornit varchar(10) not null,
    jugadortid char(3)not null
);

--Es su equipo favorito
CREATE TABLE Essuequipofavorito(
    pago varchar(60) not null,
    equipo varchar(30) not null
);

--Jugador
CREATE TABLE Jugador(
    nombre varchar(50) not null,
    nit varchar(10) not null,
    tid char(3)not null,
    nacionalidad varchar(20) not null,
    edad int not null,
    altura float not null,
    posicion varchar(16) not null
);
--Pertenece 
CREATE TABLE Pertenece(
    jugadorNit varchar(10) not null,
    jugadorTid char(3)not null,
    equipo varchar(30) not null,
    fechaInicio date not null,
    fechaFin date not null
);

--Equipo
CREATE TABLE Equipo(
    nombre varchar(30) not null,
    ciudad varchar(20) not null,
    estadio varchar(30),
    dueño varchar(20) not null
);

--Cuerpo Tecnico
CREATE TABLE CuerpoTecnico(
    nombre varchar(50) not null,
    tid char(3)not null,
    nid VARCHAR(20) not null,
    nacionalidad varchar(20) not null,
    cargo varchar(20) not null,
    equipo varchar(30) not null
);

--Partido
CREATE TABLE Partido(
    codigo int not null,
    ligaNombre varchar(30) not null,
    ligaFecha date not null,
    equipoLocal varchar(30)   not null,
    equipoVisitante varchar(30) not null,
    golesLocal int not null,
    golesVisitante int not null
);

--Liga
CREATE TABLE Liga(
    nombre varchar(30) not null,
    fechaInicio date not null,
    fechaFin date ,
    ganador varchar(30)
);

--Clasificación
CREATE TABLE Clasificacion(
    ligaNombre varchar(30) not null,
    ligaFecha date not null,
    equipo varchar(30) not null,
    puesto int NOT NULL,
    partidosGanados int not null,
    partidosEmpatados int not null,
    partidosPerdidos int not null,
    puntos int not null
);

--Estadisticas
CREATE TABLE Estadisticas(
    partidoCodigo int not null,
    jugadorNit varchar(10),
    jugadorTid char(3),
    equipo varchar(30) not null,
    asistencias int not null,
    tarjetasAmarillas int not null,
    tarjetasRojas int not null,
    posesionLocal float not null,
    posesionVisitante float not null
);


--PK

--Primarias. Definición de claves primarias

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



--FK

-- Foraneas. Definición de claves foraneas

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


--Pertenece
ALTER TABLE Pertenece ADD CONSTRAINT FK_Pertenece_Equipo FOREIGN KEY (equipo) REFERENCES Equipo(nombre);
ALTER TABLE Pertenece ADD CONSTRAINT FK_Pertenece_JugadorN FOREIGN KEY (jugadornit,jugadortid) REFERENCES Jugador(nit,tid);


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
ALTER TABLE Estadisticas ADD CONSTRAINT FK_Estadisticas_Partido FOREIGN KEY (partido) REFERENCES Partido(codigo);
ALTER TABLE Estadisticas ADD CONSTRAINT FK_Estadisticas_Equipo FOREIGN KEY (equipo) REFERENCES Equipo(nombre);



--UK


--Unicas. Definición de claves únicas


--Publicidad
ALTER TABLE Publicidad ADD UNIQUE (URL);

--Tarjeta
ALTER TABLE Tarjeta ADD UNIQUE (numero);

--Equipo
ALTER TABLE Equipo ADD UNIQUE (estadio);

