#Creacion de la base de datos tienda1

#Crea la base de datos tienda1
create database tienda1;

#Usar la base de datos
use tienda1;

#SQL-LDD
#Crear la tabla categoria
create table categoria(
categoriaid int not null,
nombre varchar(20) not null,
constraint pk_categoria
primary key (categoriaid),
constraint unico_nombre
unique (nombre)
);

#SQL-LMD
#Agregar regristros a la tabla categoria
insert into categoria
values (1, 'Carnes frias');

insert into categoria(categoriaid,nombre)
values(2, 'linea blanca');

insert into categoria(nombre,categoriaid)
values ('vinos y licores',3);

insert into categoria
values  (4, 'Ropa'),
		(5, 'Dulces'),
		(6, 'Lacteos');
        
insert into categoria(nombre, categoriaid)
values ('Panaderia', 7),
		('Zapateria', 8),
        ('Jugueteria', 9);
        
insert into categoria
values (10, 'Arina');

#Tabla productos
create table productos1 (
productoid int not null,
nombreProducto varchar (20) not null,
descripcion varchar (80),
#Aqui no existe "money" aqui es "decimal (10,2)"
precio decimal (10,2),
existencia int not null,
categoriaid int null,
constraint pk_producto1
primary key (productoid),
constraint unico_descripcion
unique (nombreProducto),
constraint chk_precio
check (precio>0.0 and precio<=1000),
constraint chk_existencia
check (existencia>0 and existencia <=200),
constraint fk_categoria_productos1
foreign key (categoriaid)
references categoria (categoriaid)
);
insert into producto1
values (1, 'Miguelito','Dulce sano para la lombriz', 34.5,45,5);

        
select * from categoria;