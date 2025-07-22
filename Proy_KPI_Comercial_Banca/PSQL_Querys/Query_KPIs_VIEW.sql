--Consultas para construir KPIs
--Tasa de Conversión de leads a clientes = % de leads que terminaron en una venta
select 
	to_char(l.fecha_contacto, 'yyyy-mm') as mes,
	round(100.00 * count(DISTINCT l.lead_id) 
	/ (select count(*) from leads_total where to_char(fecha_contacto, 'yyyy-mm') = to_char(fecha_contacto, 'yyyy-mm')), 2) 
	as Tasa_conversion
from ventas_total v
inner join oportunidades_total o on v.oportunidad_id = o.oportunidad_id
inner join leads_total l on o.lead_id = l.lead_id
GROUP by mes
ORDER by mes;
--
--KPI Ticket promedio: 
Select 
	to_char(fecha_venta, 'yyyy-mm') as mes,
	round(avg(monto_venta), 2) as Ticket_Promedio
from ventas_total
GROUP by mes;
--Significa que cada cliente gastó en promedio 4900 en abril, 5036 en mayo y 5189 en junio por transacción.
--Se obs que sube mes a mes se están vendiendo productos de mayor valor 

--Monto total de ventas
select
	to_char(fecha_venta, 'yyyy-mm') as mes,
	count(*) as cantidad_ventas,
	sum(monto_venta) as total_ventas
from ventas_total 
GROUP by mes;

--KPI Ventas por canal
create view vista_KPI_por_Canal as
select
	canal_venta,
	count(*) as cantidad_por_canal,
	sum(monto_venta) as monto_por_canal,
	round(avg(monto_venta), 2) as promedio_por_canal
from ventas_total
GROUP by canal_venta;


DROP VIEW if exists vista_kpi_comerciales;

--VIEW
CREATE or REPLACE VIEW vista_KPI_comerciales as 
select 
	to_char(v.fecha_venta, 'yyyy-mm') as mes,
	round(avg(v.monto_venta), 2) as Ticket_Promedio,
	count(*) as cantidad_ventas,
	sum(v.monto_venta) as total_ventas,
	round(100.00 * count(DISTINCT l.lead_id)/ (select count(*) from leads_total), 2) as tasa_conversion
	from ventas_total v
inner join oportunidades_total o on o.oportunidad_id = v.oportunidad_id
INNER join leads_total l on l.lead_id = o.lead_id
GROUP by mes
ORDER by mes;

select * from vista_kpi_comerciales
select * from vista_kpi_por_canal
select * from oportunidades_total
select * from leads_total;
select * from ventas_total