CREATE TABLE Cliente (
	cliente_id INT primary key,
	nombre_cliente text,
	tipo_cliente text,
	tipo_documento text,
	documento text,
	segmento_cliente text,
	ciudad text
);

create table productos (
	producto_id INT primary key,
	tipo_producto text,
	nombre_producto text,
	categoria_producto text
);

create table ejecutivo_ventas (
	ejecutivo_id INT Primary key,
	nombre_ejecutivo text,
	canal_asignado text,
	zona text
);

CREATE TABLE leads_total (
    lead_id INT PRIMARY KEY,
    fecha_contacto DATE,
    canal_origen TEXT,
    producto_interesado TEXT,
    ejecutivo_asignado_id INT,
    estado_lead TEXT
);

CREATE TABLE oportunidades_total (
    oportunidad_id INT PRIMARY KEY,
    lead_id INT,
    fecha_oportunidad DATE,
    estado_oportunidad TEXT,
    producto_ofertado TEXT,
    monto_estimado NUMERIC,
    FOREIGN KEY (lead_id) REFERENCES leads_total(lead_id)
);

CREATE TABLE ventas_total (
    venta_id INT PRIMARY KEY,
    oportunidad_id INT,
    cliente_id INT,
    producto_contratado TEXT,
    fecha_venta DATE,
    monto_venta NUMERIC,
    canal_venta TEXT,
    FOREIGN KEY (oportunidad_id) REFERENCES oportunidades_total(oportunidad_id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);


SELECT * FROM ejecutivo_ventas

CREATE TABLE leads_abril (
	lead_id INT,
    fecha_contacto DATE,
    canal_origen TEXT,
    producto_interesado TEXT,
    ejecutivo_asignado_id INT,
    estado_lead TEXT
);

CREATE TABLE leads_mayo (
	lead_id INT,
    fecha_contacto DATE,
    canal_origen TEXT,
    producto_interesado TEXT,
    ejecutivo_asignado_id INT,
    estado_lead TEXT
);

CREATE TABLE leads_junio (
	lead_id INT,
    fecha_contacto DATE,
    canal_origen TEXT,
    producto_interesado TEXT,
    ejecutivo_asignado_id INT,
    estado_lead TEXT
);

create table oportunidades_abril (
	oportunidad_id INT,
	lead_id INT,
	fecha_oportunidad DATE,
	estado_oportunidad TEXT,
    producto_ofertado TEXT,
    monto_estimado NUMERIC
);

create table oportunidades_mayo (
	oportunidad_id INT,
	lead_id INT,
	fecha_oportunidad DATE,
	estado_oportunidad TEXT,
    producto_ofertado TEXT,
    monto_estimado NUMERIC
);

create table oportunidades_junio (
	oportunidad_id INT,
	lead_id INT,
	fecha_oportunidad DATE,
	estado_oportunidad TEXT,
    producto_ofertado TEXT,
    monto_estimado NUMERIC
);

CREATE TABLE ventas_abril (
    venta_id INT,
    oportunidad_id INT,
    cliente_id INT,
    producto_contratado TEXT,
    fecha_venta DATE,
    monto_venta NUMERIC,
    canal_venta TEXT
);

CREATE TABLE ventas_mayo (
    venta_id INT,
    oportunidad_id INT,
    cliente_id INT,
    producto_contratado TEXT,
    fecha_venta DATE,
    monto_venta NUMERIC,
    canal_venta TEXT
);

CREATE TABLE ventas_junio (
    venta_id INT,
    oportunidad_id INT,
    cliente_id INT,
    producto_contratado TEXT,
    fecha_venta DATE,
    monto_venta NUMERIC,
    canal_venta TEXT
);


select * from leads_total

--unir tablas
INSERT INTO leads_total
select * from leads_abril
union all
select * from leads_mayo
union all
select * from leads_junio;

insert into oportunidades_total
select * from oportunidades_abril
union all
select * from oportunidades_mayo
union all
select * from oportunidades_junio;

select * from ventas_abril

insert into ventas_total
select * from ventas_abril
union all
select * from ventas_mayo
union all
select * from ventas_junio;
