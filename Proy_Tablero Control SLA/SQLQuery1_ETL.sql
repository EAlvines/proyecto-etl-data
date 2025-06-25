--CONSOLIDAR TODAS LAS TABLAS
SELECT * INTO TICKETS_1Q
FROM (
	SELECT * FROM tickets_enero
	UNION ALL
	SELECT * FROM tickets_febrero
	UNION ALL
	SELECT * FROM tickets_marzo ) AS Union_tickets;

--LIMPIEZA Y NORMALIZACION
--Eliminar duplicados
WITH TICKET_DUPLICADOS AS (
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY ID_Ticket ORDER BY Fecha_Registro) AS rn
	FROM TICKETS_1Q
)
DELETE FROM TICKET_DUPLICADOS
WHERE rn > 1;

--Revisar valores nulos o incosistentes

SELECT Calificacion_Cliente, count(*) as nulos
FROM TICKETS_1Q
WHERE Calificacion_Cliente	IS NULL OR Calificacion_Cliente NOT BETWEEN 1 AND 5
Group by Calificacion_Cliente;

SELECT * FROM tickets_1Q WHERE Calificacion_Cliente IS NULL OR Calificacion_Cliente NOT BETWEEN 1 AND 5;
SELECT * FROM TICKETS_1Q WHERE MES IS NULL;

--Crear columna de mes
ALTER TABLE TICKETS_1Q
ADD Mes varchar(50);

UPDATE TICKETS_1Q
SET Mes = DATENAME(MONTH,Fecha_Registro);

-- consultar estructura de la tabla
select
	column_name, data_type
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'TICKETS_1Q';

EXEC sp_help TICKETS_1Q;

select * from tickets_1q

--Añadir nueva columna "Rango_Satisfaccion" 
ALTER TABLE TICKETS_1Q ADD Rango_Satisfaccion varchar(50);

UPDATE TICKETS_1Q
SET Rango_Satisfaccion = 
	CASE
		WHEN Satisfaccion < 75 THEN 'Malo'
		WHEN Satisfaccion >= 75 AND Satisfaccion < 85 THEN 'Bueno'
		WHEN Satisfaccion >= 85 THEN 'Excelente'
	END;

