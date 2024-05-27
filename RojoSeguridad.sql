--ROL USUARIO--

CREATE ROLE USUARIOS;

-- Permisos sobre las tablas
GRANT SELECT, INSERT ON Usuario TO USUARIOS;
GRANT UPDATE ON Usuario TO USUARIOS;

GRANT SELECT, INSERT ON Pago TO USUARIOS;

GRANT SELECT, INSERT ON Gratis TO USUARIOS;

-- Permisos sobre los paquetes
GRANT EXECUTE ON Usuario_Package TO USUARIOS;
GRANT EXECUTE ON UsuarioPremium_Package TO USUARIOS;
GRANT EXECUTE ON EstadoSuscripcion_Package TO USUARIOS;




--ROL ADMINISTRADOR--

CREATE ROLE ADMINISTRADORES;

-- Permisos sobre las tablas
GRANT SELECT, INSERT,DELETE ON Publicidad TO ADMINISTRADORES;

GRANT SELECT, INSERT ON Liga TO ADMINISTRADORES;
GRANT UPDATE ON Liga TO ADMINISTRADORES;

GRANT SELECT, INSERT ON Partido TO ADMINISTRADORES;
GRANT UPDATE ON Partido TO ADMINISTRADORES;

GRANT SELECT,INSERT ON Estadisticas TO ADMINISTRADORES;

GRANT SELECT,INSERT ON Clasificacion TO ADMINISTRADORES;

--Permisos sobre los paquetes
GRANT EXECUTE ON Publicidad_Package TO ADMINISTRADORES;
GRANT EXECUTE ON Liga_Package TO ADMINISTRADORES;
GRANT EXECUTE ON GestionPartidos TO ADMINISTRADORES;
GRANT EXECUTE ON EstadisticasPartido_Package TO ADMINISTRADORES;
GRANT EXECUTE ON Clasificacion_Package TO ADMINISTRADORES;






--ROL GERENTE EQUIPO--

CREATE ROLE GERENTE_EQUIPOS;

-- Permisos sobre las tablas
GRANT SELECT, INSERT ON CuerpoTecnico TO GERENTE_EQUIPOS;
GRANT UPDATE ON CuerpoTecnico TO GERENTE_EQUIPOS;
GRANT DELETE ON CuerpoTecnico TO GERENTE_EQUIPOS;

GRANT SELECT, INSERT ON Jugador TO GERENTE_EQUIPOS;
GRANT UPDATE ON Jugador TO GERENTE_EQUIPOS;

-- Permisos sobre los paquetes
GRANT EXECUTE ON RegistroEquipo_Package TO GERENTE_EQUIPOS;
GRANT EXECUTE ON CuerpoTecnico_Package TO GERENTE_EQUIPOS;
GRANT EXECUTE ON Jugador_Package TO GERENTE_EQUIPOS;




