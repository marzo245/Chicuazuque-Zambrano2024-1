--XPaquetes--

DROP PACKAGE Usuario_Package;

DROP PACKAGE UsuarioPremium_Package;

DROP PACKAGE EstadoSuscripcion_Package;

DROP PACKAGE Publicidad_Package;

DROP PACKAGE Liga_Package;

DROP PACKAGE GestionPartidos;

DROP PACKAGE EstadisticasPartido_Package;

DROP PACKAGE Clasificacion_Package;

DROP PACKAGE RegistroEquipo_Package;

DROP PACKAGE CuerpoTecnico_Package;

DROP PACKAGE Jugador_Package;

--XRoles y Permisos--


--XROL--
DROP ROLE USUARIO;

DROP ROLE ADMINISTRADOR;

DROP ROLE GERENTE_EQUIPO;


--XPERMISOS--


-- Permisos sobre las tablas
REVOKE SELECT, INSERT ON Usuario TO USUARIO;
REVOKE UPDATE ON Usuario TO USUARIO;

REVOKE SELECT, INSERT ON UsuarioPremium TO USUARIO;

REVOKE SELECT, INSERT ON CuentaGratis TO USUARIO;

-- Permisos sobre los paquetes
REVOKE EXECUTE ON Usuario_Package TO USUARIO;
REVOKE EXECUTE ON UsuarioPremium_Package TO USUARIO;
REVOKE EXECUTE ON EstadoSuscripcion_Package TO USUARIO;





-- Permisos sobre las tablas
REVOKE SELECT, INSERT,DELETE ON Publicidad TO ADMINISTRADOR;

REVOKE SELECT, INSERT ON Liga TO ADMINISTRADOR;
REVOKE UPDATE ON Liga TO ADMINISTRADOR;

REVOKE SELECT, INSERT ON Partido TO ADMINISTRADOR;
REVOKE UPDATE ON Partido TO ADMINISTRADOR;

REVOKE SELECT,INSERT ON Estadisticas TO ADMINISTRADOR;

REVOKE SELECT,INSERT ON Clasificacion TO ADMINISTRADOR;

--Permisos sobre los paquetes
REVOKE EXECUTE ON Publicidad_Package TO ADMINISTRADOR;
REVOKE EXECUTE ON Liga_Package TO ADMINISTRADOR;
REVOKE EXECUTE ON GestionPartidos TO ADMINISTRADOR;
REVOKE EXECUTE ON EstadisticasPartido_Package TO ADMINISTRADOR;
REVOKE EXECUTE ON Clasificacion_Package TO ADMINISTRADOR;




-- Permisos sobre las tablas
REVOKE SELECT, INSERT ON CuerpoTecnico TO GERENTE_EQUIPO;
REVOKE UPDATE ON CuerpoTecnico TO GERENTE_EQUIPO;
REVOKE DELETE ON CuerpoTecnico TO GERENTE_EQUIPO;

REVOKE SELECT, INSERT ON Jugador TO GERENTE_EQUIPO;
REVOKE UPDATE ON Jugador TO GERENTE_EQUIPO;

-- Permisos sobre los paquetes
REVOKE EXECUTE ON RegistroEquipo_Package TO GERENTE_EQUIPO;
REVOKE EXECUTE ON CuerpoTecnico_Package TO GERENTE_EQUIPO;
REVOKE EXECUTE ON Jugador_Package TO GERENTE_EQUIPO;