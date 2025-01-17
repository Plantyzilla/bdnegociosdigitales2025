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
values (10, 'Panaderia');
        
select * from categoria;