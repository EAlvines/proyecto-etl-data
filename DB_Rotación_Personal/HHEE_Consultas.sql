SELECT * FROM HorasExtras_IBK

-- 1. Total de horas extras y costo total por área:
SELECT 
	Área,
	SUM(Horas_Extras) AS Total_HHEE,
	ROUND(SUM(Horas_Extras * Tarifa_Hora), 2) AS Costo_Total
FROM HorasExtras_IBK
GROUP BY Área
ORDER BY Costo_Total DESC;
--Nota: El área de MRK consume más HHEE por lo tanto genera mayor costo. 

--2. Promedio de horas extras por empleado:
SELECT 
	ID_Empleado,
	AVG(Horas_Extras) AS Promedio_HHEE
FROM HorasExtras_IBK
GROUP BY ID_Empleado;

--3. Horas extras por mes y área:
SELECT
	FORMAT(Fecha, 'yyyy-MM') AS Mes,
	Área,
	SUM(Horas_Extras) AS Horas_Mensuales
FROM HorasExtras_IBK
GROUP BY FORMAT(Fecha, 'yyyy-MM'), Área
ORDER BY Mes, Área DESC;
