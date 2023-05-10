USE MASTER
GO

CREATE DATABASE PARCIAL1
GO

USE PARCIAL1
GO

CREATE TABLE MARCAS
(
Cod_Marca_MA CHAR(4) NOT NULL,
Marca_MA VARCHAR(20) NOT NULL,
Taller_Oficial_MA VARCHAR(20) NOT NULL,
CONSTRAINT PK_MARCAS PRIMARY KEY(Cod_Marca_MA)
)
GO

CREATE TABLE MODELOS
(
Cod_Marca_MO CHAR(4) NOT NULL,
Cod_Modelo_MO CHAR(4) NOT NULL,
Modelo_MO VARCHAR(20) NOT NULL,
Tipo_Vehiculo_MO VARCHAR(20) NOT NULL,
Cant_Puertas_MO VARCHAR(20) NOT NULL,
CONSTRAINT PK_MODELOS PRIMARY KEY(Cod_Marca_MO, Cod_Modelo_MO),
CONSTRAINT FK_MODELOS_MARCAS FOREIGN KEY (Cod_Marca_MO) REFERENCES MARCAS(COD_MARCA_MA)
)
GO

CREATE TABLE MOVILES
(
Cod_Movil_MV CHAR(4) NOT NULL,
Cod_Marca_MV CHAR(4) NOT NULL,
Cod_Modelo_MV CHAR(4) NOT NULL,
Consecionaria_MV VARCHAR(20) NOT NULL,
Baja_MV BIT DEFAULT 0,
CONSTRAINT PK_MOVILES PRIMARY KEY(Cod_Movil_MV),
CONSTRAINT FK_MOVILES_MODELOS FOREIGN KEY (Cod_Marca_MV, Cod_Modelo_MV) REFERENCES MODELOS(COD_MARCA_MO, Cod_Modelo_MO)
)
GO

-- INSERT MARCAS
INSERT INTO MARCAS (Cod_Marca_MA, Marca_MA, Taller_Oficial_MA) VALUES ('M001', 'Toyota', 'Taller Toyota');
INSERT INTO MARCAS (Cod_Marca_MA, Marca_MA, Taller_Oficial_MA) VALUES ('M002', 'Ford', 'Taller Ford');
INSERT INTO MARCAS (Cod_Marca_MA, Marca_MA, Taller_Oficial_MA) VALUES ('M003', 'Chevrolet', 'Taller Chevrolet');
INSERT INTO MARCAS (Cod_Marca_MA, Marca_MA, Taller_Oficial_MA) VALUES ('M004', 'Nissan', 'Taller Nissan');
INSERT INTO MARCAS (Cod_Marca_MA, Marca_MA, Taller_Oficial_MA) VALUES ('M005', 'Honda', 'Taller Honda');

-- INSERT MODELOS
INSERT INTO MODELOS (Cod_Marca_MO, Cod_Modelo_MO, Modelo_MO, Tipo_Vehiculo_MO, Cant_Puertas_MO) VALUES ('M001', 'M101', 'Corolla', 'Sedan', '4 puertas');
INSERT INTO MODELOS (Cod_Marca_MO, Cod_Modelo_MO, Modelo_MO, Tipo_Vehiculo_MO, Cant_Puertas_MO) VALUES ('M001', 'M202', 'Hilux', 'Camioneta', '4 puertas');
INSERT INTO MODELOS (Cod_Marca_MO, Cod_Modelo_MO, Modelo_MO, Tipo_Vehiculo_MO, Cant_Puertas_MO) VALUES ('M002', 'M101', 'Mustang', 'Deportivo', '2 puertas');
INSERT INTO MODELOS (Cod_Marca_MO, Cod_Modelo_MO, Modelo_MO, Tipo_Vehiculo_MO, Cant_Puertas_MO) VALUES ('M002', 'M202', 'Explorer', 'SUV', '4 puertas');
INSERT INTO MODELOS (Cod_Marca_MO, Cod_Modelo_MO, Modelo_MO, Tipo_Vehiculo_MO, Cant_Puertas_MO) VALUES ('M003', 'M303', 'Camaro', 'Deportivo', '2 puertas');

-- INSERT MOVILES
INSERT INTO MOVILES (Cod_Movil_MV, Cod_Marca_MV, Cod_Modelo_MV, Consecionaria_MV) VALUES ('MV01', 'M001', 'M101', 'Concesionaria A');
INSERT INTO MOVILES (Cod_Movil_MV, Cod_Marca_MV, Cod_Modelo_MV, Consecionaria_MV) VALUES ('MV02', 'M001', 'M202', 'Concesionaria B');
INSERT INTO MOVILES (Cod_Movil_MV, Cod_Marca_MV, Cod_Modelo_MV, Consecionaria_MV) VALUES ('MV03', 'M002', 'M202', 'Concesionaria C');
INSERT INTO MOVILES (Cod_Movil_MV, Cod_Marca_MV, Cod_Modelo_MV, Consecionaria_MV) VALUES ('MV04', 'M002', 'M202', 'Concesionaria D');
INSERT INTO MOVILES (Cod_Movil_MV, Cod_Marca_MV, Cod_Modelo_MV, Consecionaria_MV) VALUES ('MV05', 'M003', 'M303', 'Concesionaria E');