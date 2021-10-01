DROP TABLE CALCULO_PROCESO_POSTULANTE;
DROP TABLE ERROR_DATOS;
DROP SEQUENCE SEQ_ERROR;

/

---- TABLA DE RESUMEN
CREATE TABLE CALCULO_PROCESO_POSTULANTE  (
    RUN_POSTULANTE                      VARCHAR2(15) NOT NULL,
    NOMBRE_POSTULANTE                   VARCHAR2(50) NOT NULL,
    EDAD	                            NUMBER(3) NOT NULL,
    PTJE_EDAD	                        NUMBER(6) NOT NULL,
    EST_CIVIL	                        VARCHAR2 (50) NOT NULL,
    PTJE_EST_CIVIL	                    NUMBER(6) NOT NULL,
    PUEBLO_IND_ORIG                     VARCHAR2 (50) NOT NULL,
    PTJE_PUEBLO_IND_ORIG                NUMBER(6) NOT NULL,
    ZONA_EXTREMA	                    VARCHAR2 (50) NOT NULL,
    PTJE_ZONA_EXTREMA	                NUMBER(6) NOT NULL,
    ANTEC_ACAD	                        NUMBER (6) NOT NULL,
    PJE_ANTEC_ACAD	                    NUMBER(6) NOT NULL,
    TRAYEC_EXP_LABORAL	                VARCHAR2 (50) NOT NULL,
    PTJE_TRAYEC_EXP_LABORAL	            NUMBER(6) NOT NULL,
    DOCENCIA_INVEST                     VARCHAR2 (50) NOT NULL,
    PTJE_DOCENCIA_INVEST 	            NUMBER(6) NOT NULL,
    OBJETIVO_ESTUDIO	                VARCHAR2 (50) NOT NULL,
    PTJE_OBJETIVO_ESTUDIO               NUMBER(6) NOT NULL,
    INTERES                             VARCHAR2 (50) NOT NULL,
    PTJE_INTERES                        NUMBER(6) NOT NULL,
    RETRIBUCION	                        VARCHAR2 (50) NOT NULL,
    PTJE_RETRIB                         NUMBER(6) NOT NULL,
    INST_EDUC_EXTRANJERA	            VARCHAR2 (50) NOT NULL,
    PTJE_RANKING_INST_EDUC_EXTRANJERA   NUMBER(6) NOT NULL,
    PTJE_TOTAL                          NUMBER(6,2) NOT NULL);
    


--- TABLA DE ERRORES
CREATE SEQUENCE SEQ_ERROR;

CREATE TABLE ERROR_DATOS (
    ID_ERROR NUMBER(9),
    NOMBRE_SUBPROGRAMA VARCHAR2 (100),
    ERROR_ORACLE VARCHAR2 (100));
/



--------------------------------------------------------------------------------
-------------------------------- SPEC ------------------------------------------
CREATE OR REPLACE PACKAGE PKG_CALCULO_POSTULANTE 
AS 

V_SQLERRM VARCHAR2(250);
FUNCTION FN_EST_CIVIL (P_ID_ESTCIVIL IN NUMBER) RETURN VARCHAR2;
FUNCTION FN_PUEBLO_IND_ORIG (P_ID_POSTULANTE IN NUMBER) RETURN VARCHAR2;
FUNCTION FN_INST_EDUC_EXTRANJERA (P_ID_ANTECEDENTES IN NUMBER) RETURN VARCHAR2;
FUNCTION FN_ZONA_EXTREMA (P_REGION IN VARCHAR2) RETURN VARCHAR2;

END PKG_CALCULO_POSTULANTE;

--------------------------------------------------------------------------------
--------------------------------- BODY -----------------------------------------
CREATE OR REPLACE PACKAGE BODY PKG_CALCULO_POSTULANTE 
AS 


FUNCTION FN_EST_CIVIL (P_ID_ESTCIVIL IN NUMBER) RETURN VARCHAR2
AS
V_EST_CIVIL VARCHAR2(30);
BEGIN
    EXECUTE IMMEDIATE  'SELECT DESCRIPCION 
                        FROM EST_CIVIL 
                        WHERE ID_ESTCIVIL = :B_ID_ESTCIVIL'
                        INTO V_EST_CIVIL USING P_ID_ESTCIVIL;
    RETURN V_EST_CIVIL;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    V_SQLERRM:=SQLERRM;
    INSERT INTO ERROR_DATOS
        VALUES (SEQ_ERROR.NEXTVAL,'Error en la funci�n FN_EST_CIVIL del package PKG_CALCULO_POSTULANTE', V_SQLERRM);

END FN_EST_CIVIL;

--------------------------------------------------------------------------------

FUNCTION FN_PUEBLO_IND_ORIG (P_ID_POSTULANTE IN NUMBER) RETURN VARCHAR2
AS
V_PUEBLO_IND VARCHAR2(30);
BEGIN
    SELECT PUEBLO_INDIGENA 
        INTO V_PUEBLO_IND
    FROM FORMULARIO
    WHERE ID_POSTULANTE = P_ID_POSTULANTE;
    RETURN V_PUEBLO_IND;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RETURN 'NINGUNO';
    
    WHEN OTHERS THEN
    V_SQLERRM:=SQLERRM;
    INSERT INTO ERROR_DATOS
        VALUES (SEQ_ERROR.NEXTVAL,'(Retorna por defecto) Error en la funci�n FN_PUEBLO_IND_ORIG del package PKG_CALCULO_POSTULANTE', V_SQLERRM);

END FN_PUEBLO_IND_ORIG;

--------------------------------------------------------------------------------

FUNCTION FN_INST_EDUC_EXTRANJERA(P_ID_ANTECEDENTES IN NUMBER) RETURN VARCHAR2
AS
V_INST_EXTRANJERA VARCHAR2(50);

BEGIN
    SELECT AP.NOM_INSTI_ACAD 
        INTO V_INST_EXTRANJERA
    FROM ANTEC_POSTULACION AP
    JOIN FORMULARIO F
        ON AP.ID_ANTECEDENTES = F.ID_ANTECEDENTES
    JOIN POSTULANTE P
        ON F.ID_POSTULANTE = P.ID_POSTULANTE
    WHERE  AP.ID_ANTECEDENTES = P_ID_ANTECEDENTES;
    RETURN V_INST_EXTRANJERA;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    V_SQLERRM:=SQLERRM;
    INSERT INTO ERROR_DATOS
        VALUES (SEQ_ERROR.NEXTVAL,'Error en la funci�n FN_INST_EDUC_EXTRANJERA del package PKG_CALCULO_POSTULANTE', V_SQLERRM);

END FN_INST_EDUC_EXTRANJERA;


FUNCTION FN_ZONA_EXTREMA (P_REGION IN VARCHAR2) RETURN VARCHAR2
AS
V_REGION VARCHAR2(40);

BEGIN
    SELECT REGION
        INTO V_REGION
    FROM CRITERIO_REG_EXTREMA
    WHERE  REGION = P_REGION ;
    RETURN V_REGION;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RETURN 'NINGUNA';
    
    WHEN OTHERS THEN
    V_SQLERRM:=SQLERRM;
    INSERT INTO ERROR_DATOS
        VALUES (SEQ_ERROR.NEXTVAL,'(Retorna por defecto) Error en la funci�n FN_ZONA_EXTREMA del package PKG_CALCULO_POSTULANTE', V_SQLERRM);
    
END FN_ZONA_EXTREMA;

END PKG_CALCULO_POSTULANTE;
/


--------------------------------------------------------------------------------
--	Una funci�n almacenada que permita obtener el puntaje por la instituci�n de 
-- educaci�n extranjera elegida por el postulante.
CREATE OR REPLACE FUNCTION FN_PTJE_INSTITUCION(P_RANKING_INSTITUCION1 IN NUMBER) 
RETURN NUMBER 
AS 
V_PTJE_INSTITUCION NUMBER;
V_SQLERRM VARCHAR2(250);
BEGIN

    SELECT PUNTAJE
        INTO V_PTJE_INSTITUCION
    FROM CRITERIO_RANKING CR
        WHERE P_RANKING_INSTITUCION1 BETWEEN CR.RANGO_MIN AND CR.RANGO_MAX;

    RETURN V_PTJE_INSTITUCION;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RETURN 0;
    
    WHEN OTHERS THEN
    V_SQLERRM:=SQLERRM;
    INSERT INTO ERROR_DATOS
        VALUES (SEQ_ERROR.NEXTVAL,'(Retorna por defecto) Error en funcion almacenada FN_PTJE_INSTITUCION', V_SQLERRM);
    
END FN_PTJE_INSTITUCION;
/


--------------------------------------------------------------------------------
-- Una funci�n almacenada que permita obtener el puntaje 
-- por la edad del postulante.
CREATE OR REPLACE FUNCTION FN_PTJE_EDAD(P_EDAD IN NUMBER) 
RETURN NUMBER 
AS 
V_PTJE_EDAD NUMBER;
V_SQLERRM VARCHAR2(250);
BEGIN
        SELECT PUNTAJE
            INTO V_PTJE_EDAD
        FROM CRITERIO_EDAD 
        WHERE P_EDAD BETWEEN RANGO_MIN AND RANGO_MAX;
    RETURN V_PTJE_EDAD;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    V_SQLERRM:=SQLERRM;
    INSERT INTO ERROR_DATOS
        VALUES (SEQ_ERROR.NEXTVAL,'Error en funcion almacenada FN_PTJE_EDAD', V_SQLERRM);
  
END FN_PTJE_EDAD;
/


--------------------------------------------------------------------------------
-- Una funci�n almacenada que permita obtener el puntaje por trayectoria y 
-- experiencia laboral del postulante
CREATE OR REPLACE FUNCTION FN_PTJE_EXP_LABORAL(P_EXP_LABORAL IN NUMBER) 
RETURN NUMBER 
AS 
V_PTJE_EXP NUMBER;
V_SQLERRM VARCHAR2(250);
BEGIN
    EXECUTE IMMEDIATE  'SELECT PUNTAJE
                        FROM CRITERIO_EXP_LABORAL
                        WHERE  RANGO = :B_EXP_LABORAL'
                    INTO V_PTJE_EXP USING P_EXP_LABORAL;
    RETURN V_PTJE_EXP;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RETURN 5;
    
    WHEN OTHERS THEN
    V_SQLERRM:=SQLERRM;
    INSERT INTO ERROR_DATOS
        VALUES (SEQ_ERROR.NEXTVAL,'(Retorna por defecto) Error en funcion almacenada FN_PTJE_EXP_LABORAL', V_SQLERRM);
        
END FN_PTJE_EXP_LABORAL;
/



--------------------------------------------------------------------------------
-------------------------------- TRIGGER ---------------------------------------
CREATE OR REPLACE TRIGGER TRG_CALCULO_TOTAL
BEFORE INSERT ON CALCULO_PROCESO_POSTULANTE
FOR EACH ROW

BEGIN
    
    :NEW.PTJE_TOTAL := :NEW.PTJE_EDAD * 0.05
                      + :NEW.PTJE_EST_CIVIL * 0.05
                      + :NEW.PTJE_PUEBLO_IND_ORIG * 0.10
                      + :NEW.PTJE_ZONA_EXTREMA * 0.10
                      + :NEW.PJE_ANTEC_ACAD * 0.10
                      + :NEW.PTJE_TRAYEC_EXP_LABORAL * 0.10
                      + :NEW.PTJE_DOCENCIA_INVEST * 0.10
                      + :NEW.PTJE_OBJETIVO_ESTUDIO * 0.10
                      + :NEW.PTJE_INTERES * 0.05
                      + :NEW.PTJE_RETRIB * 0.05
                      + :NEW.PTJE_RANKING_INST_EDUC_EXTRANJERA * 0.20; 
END TRG_CALCULO_TOTAL;
/


--------------------------------------------------------------------------------
--------------------------- PROCEDIMIENTO PRINCIPAL ----------------------------
CREATE OR REPLACE PROCEDURE SP_CALCULO_PROCESO_POSTULANTE
IS
    R_CALCULO_PROCESO_POSTULANTE   CALCULO_PROCESO_POSTULANTE%ROWTYPE;
    V_SQLERRM VARCHAR2(250);
    
    CURSOR C_CALCULO IS
        SELECT
            
            AP.ID_ANTECEDENTES "ID_ANTECEDENTES",
            AP.RANKING_INSTITUCION1 "RANKING_INSTITUCION1",
            TO_CHAR(PO.RUT,'99G999G999')||'-'||PO.DV_RUT "RUN_POSTULANTE",
            INITCAP(PO.PNOMBRE||' '||PO.SNOMBRE||' '||PO.APPATERNO||' '||PO.APMATERNO) "NOMBRE_POSTULANTE",
            TRUNC(MONTHS_BETWEEN(SYSDATE,PO.FECH_NACI)/12) "EDAD", 
            EC.ID_ESTCIVIL "COD_ESTCIVIL",
            CEC.PUNTAJE "PTJE_EST_CIVIL",
            PO.ID_POSTULANTE "ID_POSTULANTE",
            NVL(CPO.PUNTAJE,0) "PTJE_PUEBLO_IND_ORIG",
            RE.NOM_REGION "REGION",
            NVL(CRE.PUNTAJE,0) "PTJE_ZONA_EXTREMA",
            GA.NOTA "ANTEC_ACAD",
            CAN.PUNTAJE "PJE_ANTEC_ACAD",
            TRUNC(MONTHS_BETWEEN(EL.FECHA_TERMINO,EL.FEC_INICIO)/12) TRAYEC_EXP_LABORAL,
            INITCAP(LI.RANGO) DOCENCIA_INVEST,
            CAD.PUNTAJE "PTJE_DOCENCIA_INVEST",
            INITCAP(OP.RANGO) "OBJETIVO_ESTUDIO",
            COE.PUNTAJE "PTJE_OBJETIVO_ESTUDIO",
            INITCAP(FO.INTERES) "INTERES",
            CDI.PUNTAJE "PTJE_INTERES",
            INITCAP(FO.RETRIBUCION) RETRIBUCION,
            CRP.PUNTAJE "PTJE_RETRIB"

        FROM POSTULANTE PO

            JOIN EST_CIVIL EC
                ON PO.ID_ESTCIVIL = EC.ID_ESTCIVIL
            JOIN CRITERIO_ESTADO_CIVIL CEC
                ON EC.DESCRIPCION IN CEC.TIPO
            JOIN FORMULARIO FO
                ON PO.ID_POSTULANTE = FO.ID_POSTULANTE
            LEFT JOIN CRITERIO_PUEBLO_ORIGIN CPO
                ON FO.PUEBLO_INDIGENA IN CPO.NOMBRE
            JOIN COMUNA CO
                ON CO.ID_COMUNA = PO.ID_COMUNA
            JOIN REGION RE
                ON CO.ID_REG = RE.ID_REG
            LEFT JOIN CRITERIO_REG_EXTREMA CRE
                ON RE.NOM_REGION IN CRE.REGION
            JOIN GRADOS_ACAD GA
                ON FO.ID_GRADOS = GA.ID_GRADOS
            JOIN CRITERIO_ANT_NOTAS CAN
                ON GA.NOTA BETWEEN CAN.RANGO_MIN AND CAN.RANGO_MAX
            JOIN EXP_LABORAL EL
                ON FO.ID_EXP = EL.ID_EXP
            LEFT JOIN CRITERIO_EXP_LABORAL CEL
                ON TRUNC(MONTHS_BETWEEN(EL.FECHA_TERMINO,EL.FEC_INICIO)/12) IN CEL.RANGO
            JOIN LINEA_INVES LI
                ON FO.ID_INVEST = LI.ID_INVEST
            JOIN CRITERIO_ACT_DOCENCIA CAD
                ON LI.RANGO IN CAD.TIPO
            JOIN OBJE_POSTULACION OP
                ON FO.ID_OBJE = OP.ID_OBJE
            JOIN CRITERIO_OBJ_ESTUDIO COE
                ON OP.RANGO IN COE.TIPO
            JOIN CRITERIO_DECLA_INTERES CDI
                ON FO.INTERES IN CDI.TIPO
            JOIN CRITERIO_RETRI_POSTULANTE CRP
                ON FO.RETRIBUCION IN CRP.TIPO
            JOIN ANTEC_POSTULACION AP
                ON FO.ID_ANTECEDENTES = AP.ID_ANTECEDENTES
            LEFT JOIN CRITERIO_RANKING CR
                ON AP.RANKING_INSTITUCION1 BETWEEN CR.RANGO_MIN AND CR.RANGO_MAX
        ;

BEGIN
    EXECUTE IMMEDIATE ('TRUNCATE TABLE CALCULO_PROCESO_POSTULANTE');
    EXECUTE IMMEDIATE ('TRUNCATE TABLE ERROR_DATOS');

    FOR R_CALCULO IN C_CALCULO LOOP

        R_CALCULO_PROCESO_POSTULANTE.RUN_POSTULANTE                     := R_CALCULO.RUN_POSTULANTE;
        R_CALCULO_PROCESO_POSTULANTE.NOMBRE_POSTULANTE                  := R_CALCULO.NOMBRE_POSTULANTE;
        R_CALCULO_PROCESO_POSTULANTE.EDAD                               := R_CALCULO.EDAD;
        R_CALCULO_PROCESO_POSTULANTE.PTJE_EDAD                          := FN_PTJE_EDAD(R_CALCULO.EDAD); -- FUNCION ALMACENADA
        R_CALCULO_PROCESO_POSTULANTE.EST_CIVIL                          := PKG_CALCULO_POSTULANTE.FN_EST_CIVIL(R_CALCULO.COD_ESTCIVIL); -- FUNCION DEL PACKAGE
        R_CALCULO_PROCESO_POSTULANTE.PTJE_EST_CIVIL                     := R_CALCULO.PTJE_EST_CIVIL;
        R_CALCULO_PROCESO_POSTULANTE.PUEBLO_IND_ORIG                    := PKG_CALCULO_POSTULANTE.FN_PUEBLO_IND_ORIG(R_CALCULO.ID_POSTULANTE); -- FUNCION DEL PACKAGE
        R_CALCULO_PROCESO_POSTULANTE.PTJE_PUEBLO_IND_ORIG               := R_CALCULO.PTJE_PUEBLO_IND_ORIG;
        R_CALCULO_PROCESO_POSTULANTE.ZONA_EXTREMA                       := PKG_CALCULO_POSTULANTE.FN_ZONA_EXTREMA(R_CALCULO.REGION); -- FUNCION DEL PACKAGE
        R_CALCULO_PROCESO_POSTULANTE.PTJE_ZONA_EXTREMA                  := R_CALCULO.PTJE_ZONA_EXTREMA;
        R_CALCULO_PROCESO_POSTULANTE.ANTEC_ACAD                         := R_CALCULO.ANTEC_ACAD;
        R_CALCULO_PROCESO_POSTULANTE.PJE_ANTEC_ACAD                     := R_CALCULO.PJE_ANTEC_ACAD;
        R_CALCULO_PROCESO_POSTULANTE.TRAYEC_EXP_LABORAL                 := R_CALCULO.TRAYEC_EXP_LABORAL;
        R_CALCULO_PROCESO_POSTULANTE.PTJE_TRAYEC_EXP_LABORAL            := FN_PTJE_EXP_LABORAL(R_CALCULO.TRAYEC_EXP_LABORAL); -- FUNCION ALMACENADA
        R_CALCULO_PROCESO_POSTULANTE.DOCENCIA_INVEST                    := R_CALCULO.DOCENCIA_INVEST;
        R_CALCULO_PROCESO_POSTULANTE.PTJE_DOCENCIA_INVEST               := R_CALCULO.PTJE_DOCENCIA_INVEST;
        R_CALCULO_PROCESO_POSTULANTE.OBJETIVO_ESTUDIO                   := R_CALCULO.OBJETIVO_ESTUDIO;
        R_CALCULO_PROCESO_POSTULANTE.PTJE_OBJETIVO_ESTUDIO              := R_CALCULO.PTJE_OBJETIVO_ESTUDIO;
        R_CALCULO_PROCESO_POSTULANTE.INTERES                            := R_CALCULO.INTERES;
        R_CALCULO_PROCESO_POSTULANTE.PTJE_INTERES                       := R_CALCULO.PTJE_INTERES;
        R_CALCULO_PROCESO_POSTULANTE.RETRIBUCION                        := R_CALCULO.RETRIBUCION;
        R_CALCULO_PROCESO_POSTULANTE.PTJE_RETRIB                        := R_CALCULO.PTJE_RETRIB;
        R_CALCULO_PROCESO_POSTULANTE.INST_EDUC_EXTRANJERA               := PKG_CALCULO_POSTULANTE.FN_INST_EDUC_EXTRANJERA(R_CALCULO.ID_ANTECEDENTES);-- FUNCION DEL PACKAGE
        R_CALCULO_PROCESO_POSTULANTE.PTJE_RANKING_INST_EDUC_EXTRANJERA  := FN_PTJE_INSTITUCION(R_CALCULO.RANKING_INSTITUCION1);-- FUNCION ALMACENADA
        R_CALCULO_PROCESO_POSTULANTE.PTJE_TOTAL                         := 0;
        
      
        INSERT INTO CALCULO_PROCESO_POSTULANTE VALUES R_CALCULO_PROCESO_POSTULANTE;

    END LOOP;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
    V_SQLERRM:=SQLERRM;
    INSERT INTO ERROR_DATOS
        VALUES (SEQ_ERROR.NEXTVAL,'Error en prodecimiento principal SP_CALCULO_PROCESO_POSTULANTE', V_SQLERRM);

END SP_CALCULO_PROCESO_POSTULANTE;

/

EXEC SP_CALCULO_PROCESO_POSTULANTE;
SELECT * FROM CALCULO_PROCESO_POSTULANTE;
SELECT * FROM ERROR_DATOS;












