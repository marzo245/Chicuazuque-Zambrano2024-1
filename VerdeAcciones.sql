-- Primero, eliminar las claves foráneas existentes si existen

BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE Gratis DROP CONSTRAINT FK_Gratis_Sesion';
    EXECUTE IMMEDIATE 'ALTER TABLE Ve DROP CONSTRAINT FK_Ve_Gratis';
    EXECUTE IMMEDIATE 'ALTER TABLE Ve DROP CONSTRAINT FK_Ve_Publicidad';
    EXECUTE IMMEDIATE 'ALTER TABLE Pago DROP CONSTRAINT FK_Pago_Sesion';
    EXECUTE IMMEDIATE 'ALTER TABLE Tarjeta DROP CONSTRAINT FK_Tarjeta_Pago';
    EXECUTE IMMEDIATE 'ALTER TABLE Essujugadorfavorito DROP CONSTRAINT FK_Essujugadorfavorito_Pago';
    EXECUTE IMMEDIATE 'ALTER TABLE Essujugadorfavorito DROP CONSTRAINT FK_Essujugadorfavorito_JugadorT';
    EXECUTE IMMEDIATE 'ALTER TABLE Essuequipofavorito DROP CONSTRAINT FK_Essuequipofavorito_Pago';
    EXECUTE IMMEDIATE 'ALTER TABLE Essuequipofavorito DROP CONSTRAINT FK_Essuequipofavorito_Equipo';
    EXECUTE IMMEDIATE 'ALTER TABLE Pertenece DROP CONSTRAINT FK_Pertenece_JugadorN';
    EXECUTE IMMEDIATE 'ALTER TABLE Pertenece DROP CONSTRAINT FK_Pertenece_Equipo';
    EXECUTE IMMEDIATE 'ALTER TABLE CuerpoTecnico DROP CONSTRAINT FK_CuerpoTecnico_Equipo';
    EXECUTE IMMEDIATE 'ALTER TABLE Partido DROP CONSTRAINT FK_Partido_EquipoL';
    EXECUTE IMMEDIATE 'ALTER TABLE Partido DROP CONSTRAINT FK_Partido_EquipoV';
    EXECUTE IMMEDIATE 'ALTER TABLE Partido DROP CONSTRAINT FK_Partido_LigaNombre';
    EXECUTE IMMEDIATE 'ALTER TABLE Partido DROP CONSTRAINT FK_Partido_LigaFecha';
    EXECUTE IMMEDIATE 'ALTER TABLE Liga DROP CONSTRAINT FK_Liga_EquipoG';
    
    EXECUTE IMMEDIATE 'ALTER TABLE Clasificacion DROP CONSTRAINT FK_Clasificacion_Equipo';
    EXECUTE IMMEDIATE 'ALTER TABLE Clasificacion DROP CONSTRAINT FK_Clasificacion_LigaNombre';
    EXECUTE IMMEDIATE 'ALTER TABLE Clasificacion DROP CONSTRAINT FK_Clasificacion_LigaFecha';
    EXECUTE IMMEDIATE 'ALTER TABLE Estadisticas DROP CONSTRAINT FK_Estadisticas_Equipo';
    EXECUTE IMMEDIATE 'ALTER TABLE Estadisticas DROP CONSTRAINT FK_Estadisticas_Partido';
    EXECUTE IMMEDIATE 'ALTER TABLE Estadisticas DROP CONSTRAINT FK_Estadisticas_JugadorN';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2443 THEN -- Ignore "constraint does not exist" error
            RAISE;
        END IF;
END;
/
ALTER TABLE Liga DROP CONSTRAINT FK_Liga_EquipoG;
ALTER TABLE Estadisticas DROP CONSTRAINT FK_Estadisticas_Equipo;
ALTER TABLE Clasificacion DROP CONSTRAINT FK_Clasificacion_LigaNombre;
ALTER TABLE Clasificacion DROP CONSTRAINT FK_Clasificacion_Equipo; 
ALTER TABLE Estadisticas DROP CONSTRAINT FK_Estadisticas_JugadorN;
ALTER TABLE Estadisticas DROP CONSTRAINT FK_Estadisticas_Partido;


-- ACCIONES--

-- Gratis
ALTER TABLE Gratis
ADD CONSTRAINT FK_Gratis_Sesion
FOREIGN KEY (sesion)
REFERENCES Sesion(correo)
ON DELETE CASCADE;

-- Ve
ALTER TABLE Ve
ADD CONSTRAINT FK_Ve_Gratis
FOREIGN KEY (gratis)
REFERENCES Gratis(sesion)
ON DELETE CASCADE;

ALTER TABLE Ve
ADD CONSTRAINT FK_Ve_Publicidad
FOREIGN KEY (publicidad)
REFERENCES Publicidad(nombre)
ON DELETE CASCADE;



-- Pago
ALTER TABLE Pago
ADD CONSTRAINT FK_Pago_Sesion
FOREIGN KEY (sesion)
REFERENCES Sesion(correo)
ON DELETE CASCADE;




-- Tarjeta
ALTER TABLE Tarjeta
ADD CONSTRAINT FK_Tarjeta_Pago
FOREIGN KEY (pago)
REFERENCES Pago(sesion)
ON DELETE CASCADE;

-- Es su jugador favorito
ALTER TABLE Essujugadorfavorito
ADD CONSTRAINT FK_Essujugadorfavorito_Pago
FOREIGN KEY (pago)
REFERENCES Pago(sesion)
ON DELETE CASCADE;




ALTER TABLE Essujugadorfavorito 
ADD CONSTRAINT FK_Essujugadorfavorito_JugadorT 
FOREIGN KEY (jugadornit, jugadortid) REFERENCES Jugador(nit, tid)
ON DELETE CASCADE;



-- Es su equipo favorito
ALTER TABLE Essuequipofavorito
ADD CONSTRAINT FK_Essuequipofavorito_Pago
FOREIGN KEY (pago)
REFERENCES Pago(sesion)
ON DELETE CASCADE;



ALTER TABLE Essuequipofavorito 
ADD CONSTRAINT FK_Essuequipofavorito_Equipo 
FOREIGN KEY (equipo) 
REFERENCES Equipo(nombre);




-- Pertenece 
ALTER TABLE Pertenece 
ADD CONSTRAINT FK_Pertenece_JugadorN 
FOREIGN KEY (jugadorNit, jugadorTid) 
REFERENCES Jugador(nit, tid)
ON DELETE CASCADE;

ALTER TABLE Pertenece 
ADD CONSTRAINT FK_Pertenece_Equipo 
FOREIGN KEY (equipo) 
REFERENCES Equipo(nombre);

-- CuerpoTecnico 
ALTER TABLE CuerpoTecnico 
ADD CONSTRAINT FK_CuerpoTecnico_Equipo 
FOREIGN KEY (equipo) 
REFERENCES Equipo(nombre);

-- Partido 
ALTER TABLE Partido 
ADD CONSTRAINT FK_Partido_EquipoL 
FOREIGN KEY (equipoLocal) 
REFERENCES Equipo(nombre);

ALTER TABLE Partido 
ADD CONSTRAINT FK_Partido_EquipoV 
FOREIGN KEY (equipoVisitante) 
REFERENCES Equipo(nombre);

ALTER TABLE Partido 
ADD CONSTRAINT FK_Partido_LigaNombre 
FOREIGN KEY (ligaNombre, ligaFecha) 
REFERENCES Liga(nombre, fechaInicio)
ON DELETE CASCADE;
----------------------------------------------------------------------------
-- Liga 
ALTER TABLE Liga 
ADD CONSTRAINT FK_Liga_EquipoG 
FOREIGN KEY (ganador) 
REFERENCES Equipo(nombre);


-- Clasificacion 
ALTER TABLE Clasificacion 
ADD CONSTRAINT FK_Clasificacion_Equipo 
FOREIGN KEY (equipo) 
REFERENCES Equipo(nombre);

ALTER TABLE Clasificacion 
ADD CONSTRAINT FK_Clasificacion_LigaNombre 
FOREIGN KEY (ligaNombre, ligaFecha) 
REFERENCES Liga(nombre, fechaInicio)
ON DELETE CASCADE;

-- Estadisticas 
ALTER TABLE Estadisticas 
ADD CONSTRAINT FK_Estadisticas_Equipo 
FOREIGN KEY (equipo) 
REFERENCES Equipo(nombre);

----------------------------------------------------------------------------




ALTER TABLE Estadisticas 
ADD CONSTRAINT FK_Estadisticas_Partido 
FOREIGN KEY (partidoCodigo) 
REFERENCES Partido(codigo)
ON DELETE CASCADE;


----------------------------------------------------------------------------


ALTER TABLE Estadisticas
ADD CONSTRAINT FK_Estadisticas_JugadorN
FOREIGN KEY (jugadornit, jugadortid)
REFERENCES Jugador(nit, tid)
ON DELETE CASCADE;



