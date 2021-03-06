ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

DROP TABLE ANTEC_POSTULACION CASCADE CONSTRAINTS;

DROP TABLE COMUNA CASCADE CONSTRAINTS;

DROP TABLE CRITERIO_ACT_DOCENCIA CASCADE CONSTRAINTS;

DROP TABLE CRITERIO_ANT_NOTAS CASCADE CONSTRAINTS;

DROP TABLE CRITERIO_DECLA_INTERES CASCADE CONSTRAINTS;

DROP TABLE CRITERIO_EDAD CASCADE CONSTRAINTS;

DROP TABLE CRITERIO_ESTADO_CIVIL CASCADE CONSTRAINTS;

DROP TABLE CRITERIO_EXP_LABORAL CASCADE CONSTRAINTS;

DROP TABLE CRITERIO_OBJ_ESTUDIO CASCADE CONSTRAINTS;

DROP TABLE CRITERIO_PUEBLO_ORIGIN CASCADE CONSTRAINTS;

DROP TABLE CRITERIO_RANKING CASCADE CONSTRAINTS;

DROP TABLE CRITERIO_REG_EXTREMA CASCADE CONSTRAINTS;

DROP TABLE CRITERIO_RETRI_POSTULANTE CASCADE CONSTRAINTS;

DROP TABLE EST_CIVIL CASCADE CONSTRAINTS;

DROP TABLE EST_ESPECIALIZACION CASCADE CONSTRAINTS;

DROP TABLE ESTUDIO_SEC CASCADE CONSTRAINTS;

DROP TABLE ESTUDIO_UNI CASCADE CONSTRAINTS;

DROP TABLE EXP_LABORAL CASCADE CONSTRAINTS;

DROP TABLE FORMULARIO CASCADE CONSTRAINTS;

DROP TABLE GRADOS_ACAD CASCADE CONSTRAINTS;

DROP TABLE IDIOMA CASCADE CONSTRAINTS;

DROP TABLE LINEA_INVES CASCADE CONSTRAINTS;

DROP TABLE OBJE_POSTULACION CASCADE CONSTRAINTS;

DROP TABLE PAIS CASCADE CONSTRAINTS;

DROP TABLE POSTULANTE CASCADE CONSTRAINTS;

DROP TABLE REGION CASCADE CONSTRAINTS;

DROP TABLE TITULO_PROF CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE ANTEC_POSTULACION (
    ID_ANTECEDENTES       INTEGER NOT NULL,
    SUBESP_MEDICA         VARCHAR2(30) NOT NULL,
    NOM_INSTI_ACAD        VARCHAR2(50) NOT NULL,
    RANKING_INSTITUCION1  NUMBER(3) NOT NULL,
    DURACION              NUMBER(4) NOT NULL,
    ID_REG                INTEGER NOT NULL
);

ALTER TABLE ANTEC_POSTULACION ADD CONSTRAINT ID_ANTECEN_CHK CHECK ( ID_ANTECEDENTES >= 10 );

ALTER TABLE ANTEC_POSTULACION ADD CONSTRAINT ANTEC_POSTULACION_PK PRIMARY KEY ( ID_ANTECEDENTES );

CREATE TABLE COMUNA (
    ID_COMUNA   INTEGER NOT NULL,
    NOM_COMUNA  VARCHAR2(15) NOT NULL,
    ID_REG      INTEGER NOT NULL
);

ALTER TABLE COMUNA ADD CONSTRAINT COMUNA_PK PRIMARY KEY ( ID_COMUNA );

CREATE TABLE CRITERIO_ACT_DOCENCIA (
    TIPO     VARCHAR2(10) NOT NULL,
    PUNTAJE  NUMBER(1) NOT NULL
);

CREATE TABLE CRITERIO_ANT_NOTAS (
    RANGO_MIN  NUMBER(2,1) NOT NULL,
    RANGO_MAX  NUMBER(2,1) NOT NULL,
    PUNTAJE    NUMBER(1) NOT NULL
);

CREATE TABLE CRITERIO_DECLA_INTERES (
    TIPO     VARCHAR2(20) NOT NULL,
    PUNTAJE  NUMBER(1) NOT NULL
);

CREATE TABLE CRITERIO_EDAD (
    RANGO_MIN  NUMBER(3) NOT NULL,
    RANGO_MAX  NUMBER(3) NOT NULL,
    PUNTAJE    NUMBER(1) NOT NULL
);

CREATE TABLE CRITERIO_ESTADO_CIVIL (
    TIPO     VARCHAR2(20) NOT NULL,
    PUNTAJE  NUMBER(1) NOT NULL
);

CREATE TABLE CRITERIO_EXP_LABORAL (
    RANGO    NUMBER(3) NOT NULL,
    PUNTAJE  NUMBER(1) NOT NULL
);

CREATE TABLE CRITERIO_OBJ_ESTUDIO (
    TIPO     VARCHAR2(20) NOT NULL,
    PUNTAJE  NUMBER(1) NOT NULL
);

CREATE TABLE CRITERIO_PUEBLO_ORIGIN (
    NOMBRE   VARCHAR2(20) NOT NULL,
    PUNTAJE  NUMBER(1) NOT NULL
);

CREATE TABLE CRITERIO_RANKING (
    RANGO_MIN  NUMBER(3) NOT NULL,
    RANGO_MAX  NUMBER(3) NOT NULL,
    PUNTAJE    NUMBER(1) NOT NULL
);

CREATE TABLE CRITERIO_REG_EXTREMA (
    REGION   VARCHAR2(40) NOT NULL,
    PUNTAJE  NUMBER(1) NOT NULL
);

CREATE TABLE CRITERIO_RETRI_POSTULANTE (
    TIPO     VARCHAR2(20) NOT NULL,
    PUNTAJE  NUMBER(1) NOT NULL
);

CREATE TABLE EST_CIVIL (
    ID_ESTCIVIL  INTEGER NOT NULL,
    DESCRIPCION  VARCHAR2(20) NOT NULL
);

ALTER TABLE EST_CIVIL ADD CONSTRAINT EST_CIVIL_PK PRIMARY KEY ( ID_ESTCIVIL );

CREATE TABLE EST_ESPECIALIZACION (
    ID_ESPEC          INTEGER NOT NULL,
    TIPO_ESTUDIO      VARCHAR2(50) NOT NULL,
    INSTITUCION       VARCHAR2(50) NOT NULL,
    NOM_PROG_ESTUDIO  VARCHAR2(30) NOT NULL,
    FECHA_OBTENCION   DATE NOT NULL,
    RANGO             VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN EST_ESPECIALIZACION.RANGO IS
    'ALTA,
MEDIA,
BAJA';

ALTER TABLE EST_ESPECIALIZACION ADD CONSTRAINT EST_ESPECIAIZACION_PK PRIMARY KEY ( ID_ESPEC );

CREATE TABLE ESTUDIO_SEC (
    ID_EST_SEC            INTEGER NOT NULL,
    DEPENDENCIA           VARCHAR2(30) NOT NULL,
    TIPO_ESTABLECIMIENTO  VARCHAR2(40) NOT NULL
);

ALTER TABLE ESTUDIO_SEC ADD CONSTRAINT ESTUDIO_SEC_PK PRIMARY KEY ( ID_EST_SEC );

CREATE TABLE ESTUDIO_UNI (
    ID_EST_UNI    INTEGER NOT NULL,
    DEPENDENCIA   VARCHAR2(30) NOT NULL,
    TIPO_INGRESO  VARCHAR2(40) NOT NULL
);

ALTER TABLE ESTUDIO_UNI ADD CONSTRAINT ESTUDIO_UNI_PK PRIMARY KEY ( ID_EST_UNI );

CREATE TABLE EXP_LABORAL (
    ID_EXP            INTEGER NOT NULL,
    TIPO_EXPERIENCIA  VARCHAR2(50) NOT NULL,
    NOM_EMPRESA       VARCHAR2(30) NOT NULL,
    CERT_LABORAL      BLOB NOT NULL,
    FEC_INICIO        DATE NOT NULL,
    FECHA_TERMINO     DATE NOT NULL
);

COMMENT ON COLUMN EXP_LABORAL.CERT_LABORAL IS
    'Certificado(s) Laboral continuo o discontinuo, de a lo menos dos a?os, en jornada de al menos 22 horas en Servicios de Salud P?blica; establecimientos de salud municipal; las Fuerzas Armadas y/o Carabineros de Chile; Universidades del Estado y sus respectivos hospitales universitarios; servicios de la Administraci?n del Estado, empresas fiscales e instituciones aut?noma.';

ALTER TABLE EXP_LABORAL ADD CONSTRAINT EXP_LABORAL_PK PRIMARY KEY ( ID_EXP );

CREATE TABLE FORMULARIO (
    ID_FORMULARIO     INTEGER NOT NULL,
    INTERES           VARCHAR2(20),
    RETRIBUCION       VARCHAR2(20),
    FECHA_POST        DATE NOT NULL,
    CANT_HIJOS        CHAR(2) NOT NULL,
    DISCAPACIDAD      CHAR(2) NOT NULL,
    PUEBLO_INDIGENA   VARCHAR2(20),
    COPIA_CEDULA      BLOB NOT NULL,
    CERT_PERMANENCIA  BLOB,
    ID_EST_SEC        INTEGER NOT NULL,
    ID_EST_UNI        INTEGER NOT NULL,
    ID_TITULO         INTEGER NOT NULL,
    ID_ESPEC          INTEGER NOT NULL,
    ID_EXP            INTEGER NOT NULL,
    ID_GRADOS         INTEGER NOT NULL,
    ID_ANTECEDENTES   INTEGER NOT NULL,
    ID_POSTULANTE     INTEGER NOT NULL,
    ID_INVEST         INTEGER NOT NULL,
    ID_OBJE           INTEGER NOT NULL
);

ALTER TABLE FORMULARIO ADD CONSTRAINT ID_FORM_CHK CHECK ( ID_FORMULARIO >= 1000 );

COMMENT ON COLUMN FORMULARIO.COPIA_CEDULA IS
    'Copia C?dula de Identidad chilena, por ambos lados, vigente hasta la fecha de cierre de la postulaci?n del concurso.';

COMMENT ON COLUMN FORMULARIO.CERT_PERMANENCIA IS
    'Certificado de vigencia de permanencia definitiva en Chile, solo en el caso de postulantes extranjeros. Este documento es otorgado por la Jefatura de Extranjer?a y Polic?a Internacional y debe mencionar, EXPRESAMENTE, que la Permanencia Definitiva del/de la extranjero/a en Chile se encuentra VIGENTE. No se admitir?n documentos emitidos con anterioridad a julio de 2017. ';

ALTER TABLE FORMULARIO ADD CONSTRAINT FORMULARIO_PK PRIMARY KEY ( ID_FORMULARIO );

CREATE TABLE GRADOS_ACAD (
    ID_GRADOS         INTEGER NOT NULL,
    TIPO_ESTUDIO      VARCHAR2(50) NOT NULL,
    INSTITUCION       VARCHAR2(50) NOT NULL,
    NOM_PROG_ESTUDIO  VARCHAR2(50) NOT NULL,
    ANNIO_OBTENCION   DATE NOT NULL,
    NOTA              NUMBER(2, 1) NOT NULL
);

ALTER TABLE GRADOS_ACAD ADD CONSTRAINT GRADOS_ACAD_PK PRIMARY KEY ( ID_GRADOS );

CREATE TABLE IDIOMA (
    ID_IDIOMA          INTEGER NOT NULL,
    DESCRIPCION        VARCHAR2(20) NOT NULL,
    CERT_ACRED_IDIOMA  BLOB NOT NULL
);

COMMENT ON COLUMN IDIOMA.CERT_ACRED_IDIOMA IS
    'Certificados de acreditaci?n de idioma. Los/as postulantes que inician estudios en el extranjero cuyos programas de Subespecialidad M?dica sean dictados en alem?n, franc?s o ingl?s, SIEMPRE deber?n presentar las pruebas y/o certificados que acrediten el dominio del idioma los cuales no deber?n tener una antig?edad superior a dos a?os contados desde la fecha de cierre de la postulaci?n al concurso.';

ALTER TABLE IDIOMA ADD CONSTRAINT IDIOMA_PK PRIMARY KEY ( ID_IDIOMA );

CREATE TABLE LINEA_INVES (
    ID_INVEST           INTEGER NOT NULL,
    LINEA_INVESTIG      VARCHAR2(30) NOT NULL,
    DISCIP_PRIN_INVEST  VARCHAR2(500) NOT NULL,
    RANGO               VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN LINEA_INVES.RANGO IS
    'EXCELENTE, 
MUY BUENO, 
BUENO, 
REGULAR';

ALTER TABLE LINEA_INVES ADD CONSTRAINT LINEA_INVES_PK PRIMARY KEY ( ID_INVEST );

CREATE TABLE OBJE_POSTULACION (
    ID_OBJE       INTEGER NOT NULL,
    OBJETIVO      VARCHAR2(100) NOT NULL,
    INTERES       VARCHAR2(100) NOT NULL,
    APLI_ESTUDIO  VARCHAR2(100) NOT NULL,
    RANGO         VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN OBJE_POSTULACION.RANGO IS
    'EXCELENTE, 
MUY BUENO, 
BUENO, 
REGULAR';

ALTER TABLE OBJE_POSTULACION ADD CONSTRAINT OBJE_POSTULACION_PK PRIMARY KEY ( ID_OBJE );

CREATE TABLE PAIS (
    ID_PAIS   INTEGER NOT NULL,
    NOM_PAIS  VARCHAR2(20) NOT NULL
);

ALTER TABLE PAIS ADD CONSTRAINT ID_PAIS_CHK CHECK ( ID_PAIS >= 10 );

ALTER TABLE PAIS ADD CONSTRAINT PAIS_PK PRIMARY KEY ( ID_PAIS );

CREATE TABLE POSTULANTE (
    ID_POSTULANTE  INTEGER NOT NULL,
    PNOMBRE        VARCHAR2(20) NOT NULL,
    SNOMBRE        VARCHAR2(20),
    APPATERNO      VARCHAR2(20) NOT NULL,
    APMATERNO      VARCHAR2(20) NOT NULL,
    RUT            NUMBER(8) NOT NULL,
    DV_RUT         CHAR(1) NOT NULL,
    FECH_NACI      DATE NOT NULL,
    SEXO           VARCHAR2(10) NOT NULL,
    NUM_PASAPORTE  VARCHAR2(20),
    DIRECCION      VARCHAR2(50) NOT NULL,
    MAIL_PART      VARCHAR2(50),
    MAIL_LAB       VARCHAR2(50),
    MAIL_COM       VARCHAR2(50),
    ID_COMUNA      INTEGER NOT NULL,
    ID_ESTCIVIL    INTEGER NOT NULL,
    ID_IDIOMA      INTEGER NOT NULL
);

ALTER TABLE POSTULANTE ADD CONSTRAINT ID_POSTU_CHK CHECK ( ID_POSTULANTE >= 1 );

ALTER TABLE POSTULANTE ADD CONSTRAINT POSTULANTE_PK PRIMARY KEY ( ID_POSTULANTE );

CREATE TABLE REGION (
    ID_REG      INTEGER NOT NULL,
    NOM_REGION  VARCHAR2(30) NOT NULL,
    ID_PAIS     INTEGER NOT NULL
);

ALTER TABLE REGION ADD CONSTRAINT ID_REG_CHK CHECK ( ID_REG >= 100 );

ALTER TABLE REGION ADD CONSTRAINT REGION_PK PRIMARY KEY ( ID_REG );

CREATE TABLE TITULO_PROF (
    ID_TITULO              INTEGER NOT NULL,
    TIPO_ESTUDIO           VARCHAR2(20) NOT NULL,
    INSTITUCION            VARCHAR2(30) NOT NULL,
    NOM_CARRERA            VARCHAR2(30) NOT NULL,
    CERT_MED_CIRUJANO      BLOB NOT NULL,
    CERT_OBTENCION_TITULO  BLOB NOT NULL,
    COPIA_NOTAS            BLOB NOT NULL,
    FECHA_OBTENCION        DATE NOT NULL
);

COMMENT ON COLUMN TITULO_PROF.CERT_MED_CIRUJANO IS
    'Certificado o copia de t?tulo de m?dico cirujano. En el caso de los t?tulos obtenidos en el extranjero, el postulante deber?, adem?s, demostrar que se encuentra habilitado para ejercer legalmente la profesi?n de m?dico en Chile, mediante cualquier medio habilitado por la normativa chilena vigente.';

COMMENT ON COLUMN TITULO_PROF.CERT_OBTENCION_TITULO IS
    'Documento que certifique que el postulante obtuvo el t?tulo de especialidad m?dica correspondiente.';

COMMENT ON COLUMN TITULO_PROF.COPIA_NOTAS IS
    'COPIA Concentraci?n de notas de Pregrado suscrito por la autoridad competente (Los postulantes deber?n adjuntar todas las hojas del certificado). El documento aportado debe corresponder a las notas relativas al mismo t?tulo profesional o licenciatura adjunta a la postulaci?n.';

ALTER TABLE TITULO_PROF ADD CONSTRAINT TITULO_PROF_PK PRIMARY KEY ( ID_TITULO );

ALTER TABLE COMUNA
    ADD CONSTRAINT COM_REG_FK FOREIGN KEY ( ID_REG )
        REFERENCES REGION ( ID_REG );

ALTER TABLE FORMULARIO
    ADD CONSTRAINT FORM_ANTEC_POSTULACION_FK FOREIGN KEY ( ID_ANTECEDENTES )
        REFERENCES ANTEC_POSTULACION ( ID_ANTECEDENTES );

ALTER TABLE FORMULARIO
    ADD CONSTRAINT FORM_EST_ESPECIAIZACION_FK FOREIGN KEY ( ID_ESPEC )
        REFERENCES EST_ESPECIALIZACION ( ID_ESPEC );

ALTER TABLE FORMULARIO
    ADD CONSTRAINT FORM_ESTUDIO_SEC_FK FOREIGN KEY ( ID_EST_SEC )
        REFERENCES ESTUDIO_SEC ( ID_EST_SEC );

ALTER TABLE FORMULARIO
    ADD CONSTRAINT FORM_ESTUDIO_UNI_FK FOREIGN KEY ( ID_EST_UNI )
        REFERENCES ESTUDIO_UNI ( ID_EST_UNI );

ALTER TABLE FORMULARIO
    ADD CONSTRAINT FORM_EXP_LABORAL_FK FOREIGN KEY ( ID_EXP )
        REFERENCES EXP_LABORAL ( ID_EXP );

ALTER TABLE FORMULARIO
    ADD CONSTRAINT FORM_GRADOS_ACAD_FK FOREIGN KEY ( ID_GRADOS )
        REFERENCES GRADOS_ACAD ( ID_GRADOS );

ALTER TABLE FORMULARIO
    ADD CONSTRAINT FORM_LINEA_INVES_FK FOREIGN KEY ( ID_INVEST )
        REFERENCES LINEA_INVES ( ID_INVEST );

ALTER TABLE FORMULARIO
    ADD CONSTRAINT FORM_OBJE_POSTULACION_FK FOREIGN KEY ( ID_OBJE )
        REFERENCES OBJE_POSTULACION ( ID_OBJE );

ALTER TABLE FORMULARIO
    ADD CONSTRAINT FORM_POSTULANTE_FK FOREIGN KEY ( ID_POSTULANTE )
        REFERENCES POSTULANTE ( ID_POSTULANTE );

ALTER TABLE FORMULARIO
    ADD CONSTRAINT FORM_TITULO_PROF_FK FOREIGN KEY ( ID_TITULO )
        REFERENCES TITULO_PROF ( ID_TITULO );

ALTER TABLE REGION
    ADD CONSTRAINT PAIS_FK FOREIGN KEY ( ID_PAIS )
        REFERENCES PAIS ( ID_PAIS );

ALTER TABLE POSTULANTE
    ADD CONSTRAINT POSTU_COMUNA_FK FOREIGN KEY ( ID_COMUNA )
        REFERENCES COMUNA ( ID_COMUNA );

ALTER TABLE POSTULANTE
    ADD CONSTRAINT POSTU_EST_CIVIL_FK FOREIGN KEY ( ID_ESTCIVIL )
        REFERENCES EST_CIVIL ( ID_ESTCIVIL );

ALTER TABLE POSTULANTE
    ADD CONSTRAINT POSTU_IDIOMA_FK FOREIGN KEY ( ID_IDIOMA )
        REFERENCES IDIOMA ( ID_IDIOMA );

ALTER TABLE ANTEC_POSTULACION
    ADD CONSTRAINT REGION_FK FOREIGN KEY ( ID_REG )
        REFERENCES REGION ( ID_REG );

--------------------------- SECUENCIAS
DROP SEQUENCE SQ_POSTULANTE;
DROP SEQUENCE SQ_ID_PAIS;
DROP SEQUENCE SQ_ID_FORMULARIO;
DROP SEQUENCE SQ_ID_REGION;
DROP SEQUENCE SQ_ID_ANTECEDENTES;

-- SEC. 1 POSTULANTE
CREATE SEQUENCE SQ_POSTULANTE
INCREMENT BY 1 
START WITH 1 
MAXVALUE 99999
MINVALUE 1;

-- SEC. 2 pais
CREATE SEQUENCE SQ_ID_PAIS
INCREMENT BY 10
START WITH 10
MAXVALUE 9999999999999
MINVALUE 10;

-- SEC. 3 fOrmulariO
CREATE SEQUENCE SQ_ID_FORMULARIO
INCREMENT BY 1
START WITH 1000
MAXVALUE 9999999999999
MINVALUE 1000;

-- SEC. 4 regiOn
CREATE SEQUENCE SQ_ID_REGION
INCREMENT BY 100
START WITH 100
MAXVALUE 9999999999999
MINVALUE 100;

-- SEC. 5 antecedentes pOstulaciOn
CREATE SEQUENCE SQ_ID_ANTECEDENTES
INCREMENT BY 10
START WITH 10
MAXVALUE 9999999999999
MINVALUE 10;


--------------------------- INSERT

--------------------- ESTUDIO_SEC 
INSERT INTO ESTUDIO_SEC VALUES (1,'COLEGIO RUBEN CASTRO', 'MUNICIPAL');
INSERT INTO ESTUDIO_SEC VALUES (2,'COLEGIO SAN IGNACIO', 'PRIVADO');
INSERT INTO ESTUDIO_SEC VALUES (3,'COLEGIO AUSTRAL', 'PRIVADO');
INSERT INTO ESTUDIO_SEC VALUES (4,'COLEGIO LOS CONQUISTADORES', 'MUNICIPAL');
INSERT INTO ESTUDIO_SEC VALUES (5,'COLEGIO ALONSO DE ERCILLA', 'PRIVADO');


--------------------- ESTUDIO_UNI 
INSERT INTO ESTUDIO_UNI VALUES (1,'UNIVERSIDAD CATOLICA DE CHILE', 'PAA');
INSERT INTO ESTUDIO_UNI VALUES (2,'UNIVERSIDAD DE VALPARAISO', 'PSU');
INSERT INTO ESTUDIO_UNI VALUES (3,'UNIVERSIDAD DE CHILE', 'PAA');
INSERT INTO ESTUDIO_UNI VALUES (4,'UNIVERSIDAD DE CONCEPCION', 'PSU');
INSERT INTO ESTUDIO_UNI VALUES (5,'UNIVERSIDAD PEDRO DE VALDIVIA', 'PSU');


--------------------- TITULO_PROF
INSERT INTO TITULO_PROF VALUES (1,'PREGRADO','UNIVERSIDAD CATOLICA DE CHILE', 'MEDICINA', EMPTY_BLOB(), EMPTY_BLOB(),EMPTY_BLOB(),'20/11/1995');
INSERT INTO TITULO_PROF VALUES (2,'PREGRADO','UNIVERSIDAD DE VALPARAISO', 'MEDICINA', EMPTY_BLOB(), EMPTY_BLOB(),EMPTY_BLOB(),'7/10/2001');
INSERT INTO TITULO_PROF VALUES (3,'PREGRADO','UNIVERSIDAD DE CHILE', 'MEDICINA', EMPTY_BLOB(), EMPTY_BLOB(),EMPTY_BLOB(),'30/08/2009');
INSERT INTO TITULO_PROF VALUES (4,'PREGRADO','UNIVERSIDAD DE CONCEPCION', 'MEDICINA', EMPTY_BLOB(), EMPTY_BLOB(),EMPTY_BLOB(),'2/08/2012');
INSERT INTO TITULO_PROF VALUES (5,'PREGRADO','UNIVERSIDAD PEDRO DE VALDIVIA', 'MEDICINA', EMPTY_BLOB(), EMPTY_BLOB(),EMPTY_BLOB(),'20/09/2015');

--------------------- ESTUDIO_ESPECIALIZACION
INSERT INTO EST_ESPECIALIZACION VALUES (1,'POSTGRADO', 'UNIVERSIDAD CATOLICA DE CHILE', 'CARDIOLOGIA','20/11/2001','ALTA');
INSERT INTO EST_ESPECIALIZACION VALUES (2,'POSTGRADO', 'UNIVERSIDAD DE CHILE', 'ENDOCRINOLOGIA','20/11/2007','MEDIA');
INSERT INTO EST_ESPECIALIZACION VALUES (3,'POSTGRADO', 'UNIVERSIDAD DE VALPARAISO', 'GASTROENTEROLOGIA','20/11/2014','BAJA');
INSERT INTO EST_ESPECIALIZACION VALUES (4,'POSTGRADO', 'UNIVERSIDAD CATOLICA DE CHILE', 'GERIATRIA','20/11/2018','ALTA');
INSERT INTO EST_ESPECIALIZACION VALUES (5,'POSTGRADO', 'UNIVERSIDAD DE CHILE', 'HEMATOLOGIA','20/11/2020','MEDIA');


--------------------- EXP_LABORAL
INSERT INTO EXP_LABORAL VALUES (1,'CONTROL Y VALORACION DE LA SALUD', 'CLINICA SANTA MARIA', EMPTY_BLOB(), '20/03/1999','20/03/2021');
INSERT INTO EXP_LABORAL VALUES (2,'CONTROL Y VALORACION DE LA SALUD', 'CLINICA INDISA', EMPTY_BLOB(), '15/06/2010','15/06/2021');
INSERT INTO EXP_LABORAL VALUES (3,'CONTROL Y VALORACION DE LA SALUD', 'CLINICA LOS CARRERA', EMPTY_BLOB(), '7/01/2013','7/01/2021');
INSERT INTO EXP_LABORAL VALUES (4,'CONTROL Y VALORACION DE LA SALUD', 'HOSPITAL SAN BORJA', EMPTY_BLOB(), '12/09/2012','12/09/2021');
INSERT INTO EXP_LABORAL VALUES (5,'CONTROL Y VALORACION DE LA SALUD', 'HOSPITAL DR. GUSTAVO FRICKE', EMPTY_BLOB(), '4/05/2015','20/03/2021');


--------------------- GRADOS_ACAD
INSERT INTO GRADOS_ACAD VALUES (1,'MAGISTER', 'UNIVERSIDAD CATOLICA DE CHILE', 'MAGISTER EN EPIDEMIOLOGIA', '20/11/2015',6.6);
INSERT INTO GRADOS_ACAD VALUES (2,'MAGISTER', 'UNIVERSIDAD CATOLICA DE CHILE', 'MAGISTER EN NUTRICION', '20/11/2011',6.3);
INSERT INTO GRADOS_ACAD VALUES (3,'DOCTORADO', 'UNIVERSIDAD DE CHILE', 'DOCTORADO EN NEUROCIENCIA', '20/11/2017',5.5);
INSERT INTO GRADOS_ACAD VALUES (4,'DOCTORADO', 'UNIVERSIDAD CATOLICA DE CHILE', 'DOCTORADO EN EPIDEMIOLOGIA', '20/11/2018',5.4);
INSERT INTO GRADOS_ACAD VALUES (5,'MAGISTER', 'UNIVERSIDAD DE CHILE', 'MAGISTER EN SALUD PUBLICA', '20/11/2012',5.1);


--------------------- IDIOMA
INSERT INTO IDIOMA VALUES (1,'ESPA?OL',EMPTY_BLOB());
INSERT INTO IDIOMA VALUES (2,'INGLES',EMPTY_BLOB());
INSERT INTO IDIOMA VALUES (3,'PORTUGES',EMPTY_BLOB());
INSERT INTO IDIOMA VALUES (4,'FRANCES',EMPTY_BLOB());
INSERT INTO IDIOMA VALUES (5,'CREOLE',EMPTY_BLOB());


--------------------- EST_CIVIL
INSERT INTO EST_CIVIL VALUES (1,'CASADO');
INSERT INTO EST_CIVIL VALUES (2,'DIVORCIADO');
INSERT INTO EST_CIVIL VALUES (3,'SOLTERO');


--------------------- PAIS
INSERT INTO PAIS VALUES (SQ_ID_PAIS.NEXTVAL,'CHILE');--10
INSERT INTO PAIS VALUES (SQ_ID_PAIS.NEXTVAL,'AUSTRALIA');--20
INSERT INTO PAIS VALUES (SQ_ID_PAIS.NEXTVAL,'USA');--30
INSERT INTO PAIS VALUES (SQ_ID_PAIS.NEXTVAL,'CANADA');--40
INSERT INTO PAIS VALUES (SQ_ID_PAIS.NEXTVAL,'REINO UNIDO');--50


--------------------- REGION
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'ARICA Y PARINACOTA',10);--100
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'TARAPACA',10);--200
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'ANTOFAGASTA',10);--300
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'ATACAMA',10);--400
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'COQUIMBO',10);--500
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'VALPARAISO',10);--600
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'SANTIAGO',10);--700
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'O?HIGGINS',10);--800
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'MAULE',10);--900
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'?UBLE',10);--1000
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'BIOBIO',10);--1100
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'ARAUCANIA',10);--1200
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'LOS RIOS',10);--1300
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'LOS LAGOS',10);--1400
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'AYSEN',10);--1500
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'MAGALLANES',10);--1600
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'SYDNEY',20);--1700
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'CAMBRIDGE',30);--1800
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'BERKELEY',30);--1900
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'TORONTO',40);--2000
INSERT INTO REGION VALUES (SQ_ID_REGION.NEXTVAL,'OXFORD',50);--2100


--------------------- COMUNA
INSERT INTO COMUNA VALUES (1, 'ARICA',100);
INSERT INTO COMUNA VALUES (2, 'LA SERENA',500);
INSERT INTO COMUNA VALUES (3, 'TALCAHUANO',1100);
INSERT INTO COMUNA VALUES (4, 'SANTIAGO',700);
INSERT INTO COMUNA VALUES (5, 'COYHAIQUE',1500);


--------------------- ANTE_DE_POSTULACION   
INSERT INTO ANTEC_POSTULACION VALUES (SQ_ID_ANTECEDENTES.NEXTVAL,'CARDIOLOGIA','University Of Sydney',37,2,1700);
INSERT INTO ANTEC_POSTULACION VALUES (SQ_ID_ANTECEDENTES.NEXTVAL,'GASTROENTEROLOGIA','Harvard University',1,2,1800);
INSERT INTO ANTEC_POSTULACION VALUES (SQ_ID_ANTECEDENTES.NEXTVAL,'NEUROLOGIA PEDIATRICA','University Of TOrOntO',6,2,2000);
INSERT INTO ANTEC_POSTULACION VALUES (SQ_ID_ANTECEDENTES.NEXTVAL,'NEUROLOGIA','University Of OxfOrd',11,2,2100);
INSERT INTO ANTEC_POSTULACION VALUES (SQ_ID_ANTECEDENTES.NEXTVAL,'REUMATOLOGIA','University Of CalifOrnia Berkeley',101,2,1900);
                                                                                                                    

--------------------- LINEA_INVES
INSERT INTO LINEA_INVES VALUES (5,'MEDICINA CLINICA','LOrem ipsum dolor sit amet, cOnsectetur adipiscing elit.','ALTA');
INSERT INTO LINEA_INVES VALUES (10,'CIENCIAS BIOMEDICAS','LOrem ipsum dolor sit amet, cOnsectetur adipiscing elit.','MEDIA');
INSERT INTO LINEA_INVES VALUES (15,'EPIDEMIOLOGIA y SALUD PUBLICA','LOrem ipsum dolor sit amet, cOnsectetur adipiscing elit.','BAJA');
INSERT INTO LINEA_INVES VALUES (20,'MEDICINA CLINICA','LOrem ipsum dolor sit amet, cOnsectetur adipiscing elit.','ALTA');
INSERT INTO LINEA_INVES VALUES (25,'EDUCACION MEDICA','LOrem ipsum dolor sit amet, cOnsectetur adipiscing elit.','MEDIA');


--------------------- OBJE_POSTULACION
INSERT INTO OBJE_POSTULACION VALUES (20, 'LOrem ipsum dolor sit amet', 'LOrem ipsum dolor sit amet, cOnsectetur', 'LOrem ipsum dolor sit amet, cOnsectetur adipiscing elit.','EXCELENTE');
INSERT INTO OBJE_POSTULACION VALUES (30, 'LOrem ipsum dolor sit amet', 'LOrem ipsum dolor sit amet, cOnsectetur','LOrem ipsum dolor sit amet, cOnsectetur adipiscing elit.','MUY BUENO');
INSERT INTO OBJE_POSTULACION VALUES (40, 'LOrem ipsum dolor sit amet', 'LOrem ipsum dolor sit amet, cOnsectetur','LOrem ipsum dolor sit amet, cOnsectetur adipiscing elit.','EXCELENTE');
INSERT INTO OBJE_POSTULACION VALUES (50, 'LOrem ipsum dolor sit amet', 'LOrem ipsum dolor sit amet, cOnsectetur','LOrem ipsum dolor sit amet, cOnsectetur adipiscing elit.','BUENO');
INSERT INTO OBJE_POSTULACION VALUES (60, 'LOrem ipsum dolor sit amet', 'LOrem ipsum dolor sit amet, cOnsectetur','LOrem ipsum dolor sit amet, cOnsectetur adipiscing elit.','MUY BUENO');


--------------------- POSTULANTE
INSERT INTO POSTULANTE VALUES (SQ_POSTULANTE.NEXTVAL,'MARIA','CRISTINA', 'LOPEZ', 'PEREZ',15980762,2,'18/02/1977',
'FEMENINO',NULL,'EL RAULI 312 MIRAFLORES ALTO',NULL, NULL, NULL,1,1,1 );

INSERT INTO POSTULANTE VALUES (SQ_POSTULANTE.NEXTVAL,'JUAN','JOSE', 'REYES', 'NAVARRO',17465390,1,'07/01/1983',
'MASCULINO',NULL,'LOS CARRERA 987',NULL, NULL, NULL,1,2,2);

INSERT INTO POSTULANTE VALUES (SQ_POSTULANTE.NEXTVAL,'MAXIMILIANO', NULL, 'TORRES', 'SALINAS',18709562,5,'17/03/1993',
'MASCULINO',NULL,'JUAN FRANCISCO ITURRA 2345, POBLACION SOL NACIENTE',NULL, NULL, NULL,3,1,3);

INSERT INTO POSTULANTE VALUES (SQ_POSTULANTE.NEXTVAL,'FELIPE', 'ANDRES', 'OSORIO', 'HODAR',13876234,'K','04/04/1973',
'MASCULINO',NULL,'AVDA. VICU?A MACKENNA 234',NULL, NULL, NULL,4,3,4);

INSERT INTO POSTULANTE VALUES (SQ_POSTULANTE.NEXTVAL,'JORGE', NULL,'PONCE','ORTEGA',21723900,7,'08/02/1985',
'MASCULINO',NULL,'AVDA. MARIA PINTO 9874',NULL, NULL, NULL,5,1,5);


--------------------- FORMULARIO
INSERT INTO FORMULARIO VALUES (SQ_ID_FORMULARIO.NEXTVAL,'EXCELENTE','EXCELENTE','20/03/2021',8,'NO','NO',EMPTY_BLOB(),EMPTY_BLOB(),1,1,1,1,1,1,10,1,5,20);--13
INSERT INTO FORMULARIO VALUES (SQ_ID_FORMULARIO.NEXTVAL,'EXCELENTE','MUY BUENO','20/03/2021',1,'NO','RAPA NUI',EMPTY_BLOB(),EMPTY_BLOB(),2,2,2,2,2,2,20,2,10,30);
INSERT INTO FORMULARIO VALUES (SQ_ID_FORMULARIO.NEXTVAL,'EXCELENTE','EXCELENTE','20/03/2021',3,'NO','NO',EMPTY_BLOB(),EMPTY_BLOB(),3,3,3,3,3,3,30,3,15,40);
INSERT INTO FORMULARIO VALUES (SQ_ID_FORMULARIO.NEXTVAL,'EXCELENTE','MUY BUENO','20/03/2021',0,'NO','NO',EMPTY_BLOB(),EMPTY_BLOB(),4,4,4,4,4,4,40,4,20,50);
INSERT INTO FORMULARIO VALUES (SQ_ID_FORMULARIO.NEXTVAL,'EXCELENTE','EXCELENTE','20/03/2021',1,'NO','NO',EMPTY_BLOB(),EMPTY_BLOB(),5,5,5,5,5,5,50,5,25,60);


--------------------- CRITERIO_EDAD
INSERT INTO CRITERIO_EDAD VALUES (0,29,5);
INSERT INTO CRITERIO_EDAD VALUES (30,39,3);
INSERT INTO CRITERIO_EDAD VALUES (40,99,1);


--------------------- CRITERIO_ESTADO_CIVIL
INSERT INTO CRITERIO_ESTADO_CIVIL VALUES ('CASADO',5);
INSERT INTO CRITERIO_ESTADO_CIVIL VALUES ('CONVIVIENTE CIVIL',4);
INSERT INTO CRITERIO_ESTADO_CIVIL VALUES ('SOLTERO',3);
INSERT INTO CRITERIO_ESTADO_CIVIL VALUES ('DIVORCIADO',2);
INSERT INTO CRITERIO_ESTADO_CIVIL VALUES ('VIUDO',1);

--------------------- CRITERIO_PUEBLO_ORIGIN
INSERT INTO CRITERIO_PUEBLO_ORIGIN VALUES ('ATACAME?OS',5);
INSERT INTO CRITERIO_PUEBLO_ORIGIN VALUES ('AYMARA',5);
INSERT INTO CRITERIO_PUEBLO_ORIGIN VALUES ('KOLLA',5);
INSERT INTO CRITERIO_PUEBLO_ORIGIN VALUES ('DIAGUITA',5);
INSERT INTO CRITERIO_PUEBLO_ORIGIN VALUES ('MAPUCHE',5);
INSERT INTO CRITERIO_PUEBLO_ORIGIN VALUES ('RAPA NUI',5);
INSERT INTO CRITERIO_PUEBLO_ORIGIN VALUES ('YAGAN',5);


--------------------- CRITERIO_REG_EXTREMA
INSERT INTO CRITERIO_REG_EXTREMA VALUES ('ARICA Y PARINACOTA',5);
INSERT INTO CRITERIO_REG_EXTREMA VALUES ('TARAPACA',4);
INSERT INTO CRITERIO_REG_EXTREMA VALUES ('AYSEN',4);
INSERT INTO CRITERIO_REG_EXTREMA VALUES ('MAGALLANES',5);


--------------------- CRITERIO_ANT_NOTAS
INSERT INTO CRITERIO_ANT_NOTAS VALUES (6.6,7.0,5);
INSERT INTO CRITERIO_ANT_NOTAS VALUES (6.0,6.5,4);
INSERT INTO CRITERIO_ANT_NOTAS VALUES (5.5,5.9,3);
INSERT INTO CRITERIO_ANT_NOTAS VALUES (5.2,5.4,2);
INSERT INTO CRITERIO_ANT_NOTAS VALUES (5.0,5.1,1);


--------------------- CRITERIO_EXP_LABORAL
INSERT INTO CRITERIO_EXP_LABORAL VALUES (7,5); 
INSERT INTO CRITERIO_EXP_LABORAL VALUES (6,5);
INSERT INTO CRITERIO_EXP_LABORAL VALUES (5,4);
INSERT INTO CRITERIO_EXP_LABORAL VALUES (4,3);
INSERT INTO CRITERIO_EXP_LABORAL VALUES (3,2);
INSERT INTO CRITERIO_EXP_LABORAL VALUES (2,1);


--------------------- CRITERIO_ACT_DOCENCIA
INSERT INTO CRITERIO_ACT_DOCENCIA VALUES ('ALTA',5);
INSERT INTO CRITERIO_ACT_DOCENCIA VALUES ('MEDIA',3);
INSERT INTO CRITERIO_ACT_DOCENCIA VALUES ('BAJA',2);


--------------------- CRITERIO_OBJ_ESTUDIO  
INSERT INTO CRITERIO_OBJ_ESTUDIO VALUES ('EXCELENTE',5);
INSERT INTO CRITERIO_OBJ_ESTUDIO VALUES ('MUY BUENO',4);
INSERT INTO CRITERIO_OBJ_ESTUDIO VALUES ('BUENO',3);
INSERT INTO CRITERIO_OBJ_ESTUDIO VALUES ('REGULAR', 1);


-------------------- CRITERIO_DECLA_INTERES 
INSERT INTO CRITERIO_DECLA_INTERES VALUES ('EXCELENTE',5);
INSERT INTO CRITERIO_DECLA_INTERES VALUES ('MUY BUENO',4);
INSERT INTO CRITERIO_DECLA_INTERES VALUES ('BUENO',3);
INSERT INTO CRITERIO_DECLA_INTERES VALUES ('REGULAR', 1);


--------------------- CRITERIO_RETRI_POSTULANTE 
INSERT INTO CRITERIO_RETRI_POSTULANTE VALUES ('EXCELENTE',5);
INSERT INTO CRITERIO_RETRI_POSTULANTE VALUES ('MUY BUENO',4);
INSERT INTO CRITERIO_RETRI_POSTULANTE VALUES ('BUENO',3);
INSERT INTO CRITERIO_RETRI_POSTULANTE VALUES ('REGULAR', 1);


--------------------- CRITERIO_RANKING
INSERT INTO CRITERIO_RANKING VALUES (1,10,5);
INSERT INTO CRITERIO_RANKING VALUES (11,20,4);
INSERT INTO CRITERIO_RANKING VALUES (21,30,3);
INSERT INTO CRITERIO_RANKING VALUES (31,50,2);
INSERT INTO CRITERIO_RANKING VALUES (51,100,1);

COMMIT;