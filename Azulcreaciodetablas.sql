----Estructura y Restricciones Declarativas

--Tablas
--Creación de tablas
--Aviso
CREATE TABLE Aviso(
    id char(9) not null,
    tipoDeAviso varchar(13) not null,
    fechaCreacion date not null,
    mensajeEstado varchar(9) not null,
    usuarioDestinatario varchar(30) not null,
    datosMasImportantes XMLTYPE,
    estadoAlerta varchar(9),
    horaEjecuto date,
    sesion varchar(60) not null
);

--Sesion
CREATE TABLE Sesion(
    correo varchar(60) not null,
    nombre VARCHAR(20) not null,
    fechaNacimiento date not NULL
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
    fechaInicio date not null,
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


