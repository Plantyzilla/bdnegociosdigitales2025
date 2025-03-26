# Practica de views
## Por: Yael Tolentino Osornio
## Sirve para emcapsular una consulta muy grande = sintaxis
```sql
/* create view nombreVista
as
select columnas
from tabla
where condicion
*/

use Northwind
go

create view VistaCategorias_todas
as
select CategoryID, CategoryName, [Description], Picture 
from Categories;
go

select * from VistaCategorias_todas
where CategoryName = 'Beverages'
go
```
## "drop view" es para borrar, "alter view" es para hacer un cambio, "order by" no se puede ejecutar en las views solo despues de que se creo.
## Ejercicios:
```sql
-- crear una vista que permita visualisar solamente los clientes de México y Brasil

go
create or alter view VistaClientes_Latinos
as
select Country, City, CompanyName
from Customers
where Country in ('Mexico', 'Brazil')
go

select CompanyName as Cliente, City as Ciudad, Country as pais
from VistaClientes_Latinos
where City = 'Sao Paulo'
order by 2 desc

--Crear una vista que obtenga los datos de todas las ordenes, los productos, categorias de producto,
--en la orden calcular el importe

go
create or alter view [dbo]. [vistaOrdenesCompra]
as
Select o.OrderID as 'Numero de Orden', 
o.OrderDate as 'Fecha de Orden', 
o.RequiredDate as 'Fecha de Requisicion',
CONCAT(e.FirstName, ' ', e.LastName) as 'Nombre de Empleado', 
cu.CompanyName as 'Nombre del Cliente', 
p.ProductName as 'Nombre del Producto',
c.CategoryName as 'Nombre de la Categoria', 
od.UnitPrice as 'Precio de Venta', 
od.Quantity as 'Cantidad de Venta', 
(od.Quantity * od.UnitPrice) as 'Importe'
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on p.ProductID = od.ProductID
inner join Orders as o
on od.OrderID = o.OrderID
inner join Customers as cu
on o.CustomerID = cu.CustomerID
inner join Employees as e
on o.EmployeeID = e.EmployeeID
go

select count(distinct [Numero de Orden]) as [Numero de Ordenes]
from vistaOrdenesCompra
go

select sum([Cantidad de venta] * [Precio de venta]) as [Importe total]
from vistaOrdenesCompra;
go

select sum(importe) as [Importe total]
from vistaOrdenesCompra
where year([Fecha de orden]) between '1995' and '1996';
go

select [Nombre del Cliente] as 'Nombre cliente',
sum(importe) as [Importe total]
from vistaOrdenesCompra
where year([Fecha de orden])
between '1995' and '1996'
group by [Nombre del Cliente]
having count(*)>2;
go

create schema rh;
go

create table rh.tablarh (
			id int primary key,
			nombre nvarchar (50)
)
go

--Vistas Horizontales
create or alter view rh.ViewCategoriasProductos
as
select c.CategoryID, CategoryName, p.ProductID, p.ProductName
from
Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID;
go

select * from rh.ViewCategoriasProductos
```