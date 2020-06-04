-- Generado por Oracle SQL Developer Data Modeler 17.3.0.261.1529
--   en:        2020-06-04 14:28:00 COT
--   sitio:      Oracle Database 12c
--   tipo:      Oracle Database 12c



CREATE TABLE acessos (
    ace_id                 NUMBER NOT NULL,
    ace_fecha_intento      VARCHAR2(12) NOT NULL,
    ace_tipo_acceso        VARCHAR2(20) NOT NULL,
    ace_observaciones      VARCHAR2(250),
    usuarios_usu_usuario   VARCHAR2(50) NOT NULL
);

ALTER TABLE acessos ADD CONSTRAINT acessos_pk PRIMARY KEY ( ace_id );

CREATE TABLE clientes (
    cli_id                 NUMBER NOT NULL,
    cli_cuenta_ahorros     NUMBER NOT NULL,
    cli_fecha_registro     VARCHAR2(12) NOT NULL,
    usuarios_usu_usuario   VARCHAR2(50) NOT NULL
);

CREATE UNIQUE INDEX clientes__idx ON
    clientes ( usuarios_usu_usuario ASC );

ALTER TABLE clientes ADD CONSTRAINT clientes_pk PRIMARY KEY ( cli_cuenta_ahorros );

CREATE TABLE creditos (
    cre_id                        NUMBER NOT NULL,
    clientes_cli_cuenta_ahorros   NUMBER NOT NULL,
    usuarios_usu_usuario          VARCHAR2(50) NOT NULL,
    cre_tipo_amortizacion         VARCHAR2(20) NOT NULL,
    cre_monto                     FLOAT(2) NOT NULL,
    cre_plazo                     VARCHAR2(25) NOT NULL,
    cre_numero_cuotas             NUMBER NOT NULL
);

ALTER TABLE creditos ADD CONSTRAINT creditos_pk PRIMARY KEY ( cre_id );

CREATE TABLE cuotas (
    cuo_id                 NUMBER NOT NULL,
    cuo_fecha              DATE NOT NULL,
    cuot_monto             FLOAT(2) NOT NULL,
    cuo_estado             VARCHAR2(20) NOT NULL,
    creditos_cre_id        NUMBER NOT NULL,
    estadocuentas_ect_id   NUMBER NOT NULL
);

ALTER TABLE cuotas ADD CONSTRAINT cuotas_pk PRIMARY KEY ( cuo_id );

CREATE TABLE depositos (
    dep_id                        NUMBER NOT NULL,
    dep_iden_depositante          VARCHAR2(13) NOT NULL,
    dep_nombre_depositante1       VARCHAR2(250) NOT NULL,
    dep_monto                     FLOAT(2) NOT NULL,
    clientes_cli_cuenta_ahorros   NUMBER NOT NULL,
    usuarios_usu_usuario          VARCHAR2(50) NOT NULL,
    estadocuentas_ect_id          NUMBER NOT NULL
);

ALTER TABLE depositos ADD CONSTRAINT depositos_pk PRIMARY KEY ( dep_id );

CREATE TABLE estadocuentas (
    ect_id                        NUMBER NOT NULL,
    ect_fecha                     DATE NOT NULL,
    ect_tipo_operacion            VARCHAR2(25) NOT NULL,
    ect_saldo                     FLOAT(2) NOT NULL,
    clientes_cli_cuenta_ahorros   NUMBER NOT NULL
);

ALTER TABLE estadocuentas ADD CONSTRAINT estadocuentas_pk PRIMARY KEY ( ect_id );

CREATE TABLE personas (
    per_id               NUMBER NOT NULL,
    per_identificacion   VARCHAR2(13) NOT NULL,
    per_nombre           VARCHAR2(250) NOT NULL,
    per_apellido         VARCHAR2(250) NOT NULL,
    per_telefono         VARCHAR2(50) NOT NULL,
    per_direccion        VARCHAR2(250) NOT NULL,
    per_correo           VARCHAR2(250) NOT NULL
);

ALTER TABLE personas ADD CONSTRAINT personas_pk PRIMARY KEY ( per_identificacion );

CREATE TABLE retiros (
    ret_id                            NUMBER NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    ret_identificacion_beneficiario   VARCHAR2(13) NOT NULL,
    ret_monto                         FLOAT(2) NOT NULL,
    ret_fecha                         DATE NOT NULL,
    usuarios_usu_usuario              VARCHAR2(50) NOT NULL,
    clientes_cli_cuenta_ahorros       NUMBER NOT NULL,
    estadocuentas_ect_id              NUMBER NOT NULL
);

ALTER TABLE retiros ADD CONSTRAINT retiros_pk PRIMARY KEY ( ret_id );


--  ERROR: UK name length exceeds maximum allowed length(30) 

ALTER TABLE retiros ADD CONSTRAINT retiros_ret_identificacion_beneficiario_un UNIQUE ( ret_identificacion_beneficiario );

CREATE TABLE usuarios (
    usu_id                        NUMBER NOT NULL,
    usu_usuario                   VARCHAR2(50) NOT NULL,
    usu_password                  VARCHAR2(50) NOT NULL,
    usu_tipo_usuario              VARCHAR2(25) NOT NULL,
    usu_fecha_registro            VARCHAR2(50) NOT NULL,
    personas_per_identificacion   VARCHAR2(13) NOT NULL
);

CREATE UNIQUE INDEX usuarios__idx ON
    usuarios ( personas_per_identificacion ASC );

ALTER TABLE usuarios ADD CONSTRAINT usuarios_pk PRIMARY KEY ( usu_usuario );

ALTER TABLE acessos
    ADD CONSTRAINT acessos_usuarios_fk FOREIGN KEY ( usuarios_usu_usuario )
        REFERENCES usuarios ( usu_usuario );

ALTER TABLE clientes
    ADD CONSTRAINT clientes_usuarios_fk FOREIGN KEY ( usuarios_usu_usuario )
        REFERENCES usuarios ( usu_usuario );

ALTER TABLE creditos
    ADD CONSTRAINT creditos_clientes_fk FOREIGN KEY ( clientes_cli_cuenta_ahorros )
        REFERENCES clientes ( cli_cuenta_ahorros );

ALTER TABLE creditos
    ADD CONSTRAINT creditos_usuarios_fk FOREIGN KEY ( usuarios_usu_usuario )
        REFERENCES usuarios ( usu_usuario );

ALTER TABLE cuotas
    ADD CONSTRAINT cuotas_creditos_fk FOREIGN KEY ( creditos_cre_id )
        REFERENCES creditos ( cre_id );

ALTER TABLE cuotas
    ADD CONSTRAINT cuotas_estadocuentas_fk FOREIGN KEY ( estadocuentas_ect_id )
        REFERENCES estadocuentas ( ect_id );

ALTER TABLE depositos
    ADD CONSTRAINT depositos_clientes_fk FOREIGN KEY ( clientes_cli_cuenta_ahorros )
        REFERENCES clientes ( cli_cuenta_ahorros );

ALTER TABLE depositos
    ADD CONSTRAINT depositos_estadocuentas_fk FOREIGN KEY ( estadocuentas_ect_id )
        REFERENCES estadocuentas ( ect_id );

ALTER TABLE depositos
    ADD CONSTRAINT depositos_usuarios_fk FOREIGN KEY ( usuarios_usu_usuario )
        REFERENCES usuarios ( usu_usuario );

ALTER TABLE estadocuentas
    ADD CONSTRAINT estadocuentas_clientes_fk FOREIGN KEY ( clientes_cli_cuenta_ahorros )
        REFERENCES clientes ( cli_cuenta_ahorros );

ALTER TABLE retiros
    ADD CONSTRAINT retiros_clientes_fk FOREIGN KEY ( clientes_cli_cuenta_ahorros )
        REFERENCES clientes ( cli_cuenta_ahorros );

ALTER TABLE retiros
    ADD CONSTRAINT retiros_estadocuentas_fk FOREIGN KEY ( estadocuentas_ect_id )
        REFERENCES estadocuentas ( ect_id );

ALTER TABLE retiros
    ADD CONSTRAINT retiros_usuarios_fk FOREIGN KEY ( usuarios_usu_usuario )
        REFERENCES usuarios ( usu_usuario );

ALTER TABLE usuarios
    ADD CONSTRAINT usuarios_personas_fk FOREIGN KEY ( personas_per_identificacion )
        REFERENCES personas ( per_identificacion );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             2
-- ALTER TABLE                             24
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   2
-- WARNINGS                                 0
