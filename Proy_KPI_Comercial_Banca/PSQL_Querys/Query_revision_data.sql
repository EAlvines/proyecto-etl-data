--Revisión y limpieza
select count(*) as Total_datos_ventas from ventas_total;
select count(*) as Total_datos_oportunidades from oportunidades_total;
select count(*) as Total_datos_leads from leads_total;

--Validacion temporal - rango de fechas
select 
	min(fecha_contacto), max(fecha_contacto) 
	from leads_total; 
select 
	min(fecha_oportunidad), max(fecha_oportunidad) 
	from oportunidades_total;

select * from oportunidades_total
select * from ventas_total

--Hay oportunidades sin lead Vinculado?
select * from oportunidades_total O
left join leads_total l on O.lead_id = l.lead_id
where l.lead_id is null;
--Todas tienen vinculación

--Ventas sin cliente o sin oportunidad?
select * from ventas_total v
left join cliente c on v.cliente_id = c.cliente_id
where c.cliente_id is null;

select * from ventas_total v
left join oportunidades_total o on v.oportunidad_id = o.oportunidad_id
where o.oportunidad_id is null;

select * from oportunidades_total
select * from ventas_total

