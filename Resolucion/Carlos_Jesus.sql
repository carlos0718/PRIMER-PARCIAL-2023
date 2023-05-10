--1.- Informe todos los modelos registrados de una determinada marca.
select mo.* from MODELOS mo
join MARCAS ma on ma.Cod_Marca_MA = mo.Cod_Marca_MO
WHERE ma.Marca_MA like 'Toyota'

--2.- Informe los nombres de los talleres oficiales cuyas marcas no comiencen con vocal, 
--posteriormente una “O” o una “I”, seguida de cualquier carácter individual, 
--y cualquier cadena de caracteres.

SELECT ma.Taller_Oficial_MA from MARCAS ma
where ma.Marca_MA not like '[aeiou]' and ma.Marca_MA not like '_[oi]%'

--3. Informe los modelos y los talleres donde se atienden los móviles comprados
-- en una determinada concesionaria.

SELECT mo.Modelo_MO, ma.Taller_Oficial_MA From MODELOS mo
join MARCAS ma on ma.Cod_Marca_MA = mo.Cod_Marca_MO
join MOVILES mv on mv.Cod_Marca_MV = ma.Cod_Marca_MA
WHERE mv.Consecionaria_MV like 'Concesionaria B'
GO
--4. Informe la cantidad de móviles, marca y modelo, agrupados por marca y modelo.

SELECT mv.Cod_Marca_MV, mv.Cod_Modelo_MV, COUNT(*) FROM MOVILES mv
GROUP BY  mv.Cod_Marca_MV, mv.Cod_Modelo_MV