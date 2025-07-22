--Consultas para construir KPIs
--Tasa de Conversión de leads a clientes
select 
	ROUND(100.0 * (select count(*) from oportunidades_total
		where estado_oportunidad = 'Ganada'
	) / (select count(*) from leads_total));

--
