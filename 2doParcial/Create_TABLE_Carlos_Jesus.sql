--CREATE DATABASE PARCIAL2_2022_2C
-- 2)
GO
CREATE TABLE Proveedores (
    CodProv_Pr char(10) NOT NULL PRIMARY KEY,
    RazonSocProv_Pr varchar(50) NOT NULL,
    TelProv_Pr varchar(20) NOT NULL,
    MailProv_Pr varchar(30)
);
GO
CREATE TABLE Artículos (
    CodArt_A char(10) NOT NULL,
    CodProv_A char(10) NOT NULL,
    DescArt_A varchar(10) NOT NULL,
    StockArt_A int NOT NULL DEFAULT 0,
    PrecioUnitArt_A decimal(8,2) NOT NULL DEFAULT 0,
    PuntoPedidoArt_A int NOT NULL DEFAULT 0,
    ActivoArt_A bit NOT NULL DEFAULT 1
    PRIMARY KEY (CodArt_A, CodProv_A),
    FOREIGN KEY (CodProv_A) REFERENCES Proveedores (CodProv_Pr)
);
GO
CREATE TABLE Facturas (
    NumFact_F int NOT NULL PRIMARY KEY IDENTITY(1,1),
    FechaFact_F date NOT NULL,
    TotalFact_F decimal(8,2) NOT NULL DEFAULT 0
);
GO
CREATE TABLE DetalleDeFacturas (
    NumFact_DF int NOT NULL ,
    CodProv_DF char(10) NOT NULL,
    CodArt_DF char(10) NOT NULL,
    CantArt_DF int NOT NULL,
    PrecioUnitArt_DF decimal(8,2) NOT NULL,
    PRIMARY KEY (NumFact_DF, CodArt_DF, CodProv_DF),
    FOREIGN KEY (NumFact_DF) REFERENCES Facturas (NumFact_F),
    FOREIGN KEY (CodArt_DF, CodProv_DF) REFERENCES Artículos (CodArt_A, CodProv_A)
);
GO
CREATE TABLE EstadosArticulos (
    CodEstArt_EA INT PRIMARY KEY IDENTITY(1,1),
    CodArt_EA char(10) NOT NULL,
    CodProv_EA char(10) NOT NULL,
    EstadoArt_EA bit NOT NULL,
    FechaCambio_EA date NOT NULL,
    FOREIGN KEY (CodArt_EA, CodProv_EA) REFERENCES Artículos (CodArt_A, CodProv_A)
);
GO
-- ===========================================
--3)
-- PROVEEDORES
INSERT INTO Proveedores (CodProv_Pr, RazonSocProv_Pr, TelProv_Pr, MailProv_Pr)
VALUES ('P001', 'Proveedor 1', '123456789', 'proveedor1@example.com');

INSERT INTO Proveedores (CodProv_Pr, RazonSocProv_Pr, TelProv_Pr, MailProv_Pr)
VALUES ('P002', 'Proveedor 2', '987654321', 'proveedor2@example.com');

-- ARTICULOS
INSERT INTO Artículos (CodArt_A, CodProv_A, DescArt_A, StockArt_A, PrecioUnitArt_A, PuntoPedidoArt_A, ActivoArt_A)
VALUES ('A001', 'P001', 'Artículo 1', 10, 10.99, 5, 1);

INSERT INTO Artículos (CodArt_A, CodProv_A, DescArt_A, StockArt_A, PrecioUnitArt_A, PuntoPedidoArt_A, ActivoArt_A)
VALUES ('A002', 'P002', 'Artículo 2', 5, 5.99, 3, 1);

--FACTURAS
INSERT INTO Facturas (FechaFact_F, TotalFact_F)
VALUES ('2023-06-13', 100.50);

INSERT INTO Facturas (FechaFact_F, TotalFact_F)
VALUES ('2023-06-14', 250.75);

--DETALLE FACTURA
INSERT INTO DetalleDeFacturas (NumFact_DF, CodProv_DF,  CodArt_DF, CantArt_DF, PrecioUnitArt_DF)
VALUES (1,'P001','A001', 2, 10.99);

INSERT INTO DetalleDeFacturas (NumFact_DF, CodProv_DF, CodArt_DF, CantArt_DF, PrecioUnitArt_DF)
VALUES (2, 'P002', 'A002', 3, 5.99);

--ESTADOSARTICULOS
INSERT INTO EstadosArticulos (CodArt_EA, CodProv_EA, EstadoArt_EA, FechaCambio_EA)
VALUES ('A001', 'P001', 1, '2023-06-13');

INSERT INTO EstadosArticulos (CodArt_EA, CodProv_EA, EstadoArt_EA, FechaCambio_EA)
VALUES ('A002', 'P002', 0, '2023-06-14');

--=================================
--4)Realice una consulta que devuelva el código y la descripción de todos los 
--Artículos desactivados de un proveedor determinado (RazonSocProv_Pr) a su elección.

SELECT A.CodArt_A, A.DescArt_A FROM Artículos A 
JOIN Proveedores P on P.CodProv_Pr = A.CodProv_A
WHERE A.ActivoArt_A = 0 AND P.RazonSocProv_Pr LIKE 'Proveedor 2'

--=============================

--5. Realice un Procedimiento Almacenado llamado SP_Información_Proveedor que ejecute 
--una consulta que devuelva el código del proveedor, su razón social, su número de teléfono 
--y su dirección de correo electrónico ingresando la variable @CodArt.
GO
CREATE PROCEDURE SP_Información_Proveedor
    @CodArt char(10)
AS
BEGIN
    SELECT P.CodProv_Pr, P.RazonSocProv_Pr, P.TelProv_Pr, P.MailProv_Pr
    FROM Proveedores P
    INNER JOIN Artículos A ON A.CodProv_A = P.CodProv_Pr
    WHERE A.CodArt_A = @CodArt;
END;

--EXEC SP_Información_Proveedor 'A001';

--===============================

--Realice un Trigger que ingrese un registro en la tabla EstadosArticulos indicando el artículo, 
--el estado que toma y la fecha y hora del cambio, 
--cuando se modifique el valor del campo ActivoArt_A de un determinado artículo.
GO
CREATE OR ALTER TRIGGER TR_Insertar_Estado_Articulo
ON Artículos
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @FechaCambio DATETIME = GETDATE(); -- Fecha y hora actual

    INSERT INTO EstadosArticulos (CodArt_EA, CodProv_EA, EstadoArt_EA, FechaCambio_EA)
    SELECT i.CodArt_A, i.CodProv_A, i.ActivoArt_A, @FechaCambio
    FROM inserted i
END;

