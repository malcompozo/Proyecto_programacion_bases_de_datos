—USUARIOS CONSULTAS

/*
DROP USER DUENO_TABLAS;
DROP ROLE ROL_DTAB;
*/


CREATE USER DUENO_TABLAS
IDENTIFIED BY "UsuarioTablas2021"
DEFAULT TABLESPACE DATA
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON DATA;

CREATE ROLE ROL_DTAB;
GRANT CREATE SESSION TO PROY_SEMESTRAL;
GRANT CREATE SESSION TO DUENO_TABLAS;
GRANT CREATE TABLE, INSERT ANY TABLE, UPDATE ANY TABLE, DELETE ANY TABLE,
CREATE SEQUENCE, CREATE PUBLIC SYNONYM, DROP PUBLIC SYNONYM, CREATE INDEXTYPE TO DUENO_TABLAS;
GRANT ROL_DTAB TO DUENO_TABLAS;
ALTER USER DUENO_TABLAS DEFAULT ROLE "ROL_DTAB";
/

/*
DROP USER DESARROLLADOR_1;
DROP ROLE ROL_DES1;
*/

CREATE USER DESARROLLADOR_1
IDENTIFIED BY "Desa_Uno2021"
DEFAULT TABLESPACE DATA
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON DATA;

CREATE ROLE ROL_DES1;
GRANT CREATE SESSION TO PROY_SEMESTRAL;
GRANT CREATE SESSION TO DESARROLLADOR_1;
GRANT CREATE PROCEDURE, CREATE TRIGGER, CREATE VIEW, CREATE MATERIALIZED VIEW TO DESARROLLADOR_1;
GRANT ROL_DES1 TO DESARROLLADOR_1;
ALTER USER DESARROLLADOR_1 DEFAULT ROLE "ROL_DES1";

/

/*
DROP USER DESARROLLADOR_2;
DROP ROLE ROL_DES2;
*/

CREATE USER DESARROLLADOR_2
IDENTIFIED BY "Desa_Dos2021"
DEFAULT TABLESPACE DATA
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON DATA;

CREATE ROLE ROL_DES2;

GRANT CREATE SESSION TO DESARROLLADOR_2;
GRANT CREATE SESSION TO DESARROLLADOR_2;
GRANT CREATE PROCEDURE, CREATE TRIGGER, CREATE SEQUENCE, CREATE VIEW, CREATE MATERIALIZED VIEW TO DESARROLLADOR_2;

GRANT ROL_DES2 TO DESARROLLADOR_2;
ALTER USER DESARROLLADOR_2 DEFAULT ROLE "ROL_DES2";

/

--DROP ROLE ROL_CONSULTAS;

CREATE ROLE ROL_CONSULTAS;

GRANT CREATE SESSION TO PROY_SEMESTRAL;

GRANT ROL_CONSULTAS TO DESARROLLADOR_1;
GRANT ROL_CONSULTAS TO DESARROLLADOR_2;

ALTER USER DESARROLLADOR_1 DEFAULT ROLE "ROL_CONSULTAS";
ALTER USER DESARROLLADOR_2 DEFAULT ROLE "ROL_CONSULTAS";



