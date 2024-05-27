ALTER TABLE Pago
ADD CONSTRAINT CK_Pago_FechaInicio_FechaFin
CHECK(fechaFin>fechaInicio);

ALTER TABLE Liga
ADD CONSTRAINT CK_Liga_FechaInicio_FechaFin
CHECK(fechaFin>fechaInicio);

ALTER TABLE Partido
ADD CONSTRAINT CK_Partido_GolLocal_GolVisitante
CHECK(golesLocal>=0 AND golesVisitante >=0);

ALTER TABLE Estadisticas
ADD CONSTRAINT CK_Estadisticas_posesionLocal_posesionVisitante
CHECK(posesionLocal>=0 AND posesionVisitante >=0);
