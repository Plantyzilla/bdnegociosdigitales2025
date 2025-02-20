
--Creación de la bas de datos tienda1

--Crear base de datos tienda 1

create database tienda1;

--Utilizar una base de datos 

use tienda1;

-- SQL - LDD
--Crear tabla de categoria 

create table categoria(
categoriaID int not null,
nombrecatego varchar (20) not null,
constraint pk_categoria
primary key (categoriaID),
constraint unico_nombre
unique (nombrecatego)
);

-- SQL - LMD
--Agregar registros a la tabla categoria

insert into categoria
values(1, 'Carnes Frias');

insert into categoria(categoriaID, nombrecatego)
values (2, 'Linea Blanca');

insert into  categoria(nombrecatego, categoriaID)
values ('Vinos y Licores', 3);

insert into categoria
values (4, 'Ropa'),
(5, 'Dulces'),
(6, 'Lacteos');

insert into categoria (nombrecatego, categoriaID)
values ('Panaderia', 7),
('Zapateria', 8),
('Jugeteria', 9);

insert into categoria
values (10, 'Panaderia');

select * from categoria;

select * from categoria
order by categoriaID asc;
-- Tabla  Productos --

create table producto1(
productId int not null,
nombreProducto varchar (20) not null,
descripcion varchar (80),
precio money not null,
existencia int not null,
categoriaID int null,
constraint pk_producto1
primary key (productId),
constraint unico_nombreProducto
unique (nombreProducto),
constraint chk_precio
check (precio > 0.0 and precio <= 1000),
constraint chk_existencia
check (existencia > 0 and existencia <= 200),
constraint fk_categoria_producto1
foreign key (categoriaID)
references categoria (categoriaID)
)
select * from categoria;

select * from producto1 where categoriaID = 5;

insert into producto1
values (1, 'Miguelito', 'Dulce para la lobriz', 34.5, 45, 5);

insert into producto1
values (2, 'Tupsi Pop', 'Dulce resano para el diente', 1000, 45, 5);

insert into producto1
values (3, 'Plancha', 'Plancha facil el suit', 256.3, 45, 2);

create table cliente(
clienteID int not null identity (1, 1),
codigoCliente varchar (15) not null,
nombre varchar (30) not null,
direccion varchar (100) not null,
telefono varchar (19),
constraint pk_cliente
primary key (clienteID),
constraint unico_codigoCliente
unique (codigoCliente)
);

/*constraint fk_detalleOrden_Orden
foreign key (ordenfk)
references (ordenID)*/

create table detalleOrden (
ordenfk int not null,
productfk int not null,
preciocompra money not null,
cantidad int not null,
constraint pk_detalleorden
primary key (ordenfk, productfk),
constraint chk_preciocompra
check (preciocompra > 0.0 and preciocompra <= 20000),
constraint chk_cantidad
check (cantidad > 0),
constraint fk_detalleOrden_producto1
foreign key (productfk)
references producto1(productId),

);

create table ordenCompra(
ordenID int not null identity (1,1),
fechaCompra date not null,
clientefk int not null,
constraint pk_ordenCompra
primary key (ordenID),
constraint fk_ordenCompra_Cliente
foreign key (clientefk)
references cliente (clienteID)
);

ALTER TABLE detalleOrden
add constraint fk_detalleOrden_ordenCompra
foreign key (ordenfk)
references ordenCompra (ordenID);