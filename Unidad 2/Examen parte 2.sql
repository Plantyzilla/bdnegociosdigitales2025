-- Examen parte #2
use Northwind
select * from Products
select * from [Order Details]
select * from Orders
select * from Customers
select * from Employees
go
--1.- Nombre del cliente y su identificador, nombre completo del empleado, fecha de la orden, fecha de envio y el costo del pleto
create or alter view vistaPedidos_InformacionClientesyEmpleados
as
select p.ProductName as 'Nombre del producto',
p.UnitsInStock as 'Cantidad',
p.QuantityPerUnit as 'cantidad pedida',
cu.ContactName as 'Cliente',
CONCAT(em.FirstName, ' ', em.LastName) as 'Nombre de Empleado',
od.OrderDate 'Fecha de orden',
od.RequiredDate 'Fecha de envio',
ode.UnitPrice as 'Costo del pleto'
from Products as p
inner join [Order Details] as ode
on ode.ProductID = p.ProductID
inner join Orders as od
on od.OrderID = ode.OrderID
inner join Employees as em
on em.EmployeeID = od.EmployeeID
inner join Customers as cu
on cu.CustomerID = od.CustomerID;
go

select * from vistaPedidos_InformacionClientesyEmpleados
go

--2.- Nombre del producto, nombre de la categoria, precio unitario, cantidad vendida y el importe

select * from Products
select * from Categories
select * from [Order Details]
select * from Orders
go

create or alter view vistaPedidos_InformacionProductosyCategorias
as
select p.ProductName as 'Nombre del producto',
c.CategoryName as 'Nombre de la categoria',
p.UnitsInStock as 'Cantidad',
p.QuantityPerUnit as 'cantidad pedida',
ode.UnitPrice as 'Precio Unitario',
p.QuantityPerUnit as 'Cantidad vendida',
(ode.Quantity * ode.UnitPrice) as 'Importe'
from Products as p
inner join [Order Details] as ode
on ode.ProductID = p.ProductID
inner join Orders as od
on od.OrderID = ode.OrderID
inner join Categories as c
on c.CategoryID = p.CategoryID
go

select * from vistaPedidos_InformacionProductosyCategorias
go
