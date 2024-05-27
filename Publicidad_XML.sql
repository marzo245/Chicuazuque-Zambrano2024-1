select * from publicidad;

--se anade tipo de dato XML--
ALTER TABLE Publicidad ADD (URL_XML XMLTYPE);

--se borra la columna URL y se deja solo URL_XML-- 
ALTER TABLE Publicidad DROP COLUMN URL;

--se renombre la columna URL_XML  a URL--
ALTER TABLE Publicidad RENAME COLUMN URL_XML TO URL;

--se crea un trigger para validar los datos a la hora de la insercion--
CREATE OR REPLACE TRIGGER trg_validate_url
BEFORE INSERT OR UPDATE ON Publicidad
FOR EACH ROW
BEGIN
    -- Validar que el contenido del XML siga el patron especificado
    IF NOT (:NEW.URL.existsNode('/url[starts-with(text(), "http://") or starts-with(text(), "https://") or starts-with(text(), "www.")]') = 1) THEN
        RAISE_APPLICATION_ERROR(-20000, 'URL debe comenzar con "http://", "https://", o "www."');
    END IF;
END;
/




