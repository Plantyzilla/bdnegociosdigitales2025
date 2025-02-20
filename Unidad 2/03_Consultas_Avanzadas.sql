use northwind2;
#Seleccionar todas las categorias y productos

select categoryid, categoryName, productName, Unit, price from
categories
inner join
products
on categories.categoryid = products.categoryid;

select c.categoryid, categoryName, productName, Unit, price
from
categories as c
inner join
products as p
on c.categoryid = p.categoryid;

select c.categoryid as 'Número de categoria',
categoryName as 'Nombre Categoria', productName as 'Nombre de producto',
Unit as 'Existencia', price as 'Precio'
from
categories as c
inner join
products as p
on c.categoryid = p.categoryid;

select * 
from Products as p
join categories as ca
on p.categoryId = ca.CategoryID
where (ca.categoryName = 'beverages'or ca.CategoryName = 'condiments')
and (p.Unit>=18 and p.unit<=30);

select * 
from Products as p
join categories as ca
on p.categoryId = ca.CategoryID
where ca.categoryName in ('beverages', 'condiments')
and (p.Unit>=18 and p.unit<=30);

#Seleccionar los productos y sus importes realizados de marzo a junio de
#1996, mostrando la fecha de la orden, el id de producto y el importe

select o.OrderId, o.OrderDate, od.ProductId,
(od.Price * od.Quantity) as importe
from orders as o
inner join OrderDetails as od
on od.OrderId = o.OrderId
where o.orderDate between '1996-07-01' and '1996-10-31';

#Consultas Básicas con inner join

#1.- Obtener los nombres de los clientes y los países a los que se
#enviaron sus pedidos = Fallida

select o.CompanyName, o.ShipCountry
from Orders as o
inner join Customers as c
on c.CustomerId = o.CustomerId
order by 2 desc
;

#2.-Obtener los productos y sus respectivos proveedores = Lograda

select p.ProductName as 'Nombre producto',
s.ContactName as 'Nombre del provedor'
from
products as p
inner join
suppliers as s
on p.SupplierID = s.SupplierID;

#3.-Obtener los pedidos y los empleados que los gestionaron = Fallida

select o.OrderId, concat(e.Title, '-', e.FirtsName, ' ', e.lastName) as 'Nombre'
from
orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID;

 #4.-Listar los productos junto con sus precios y las categoría a la que pertenece = Fallida
 
 select p.ProductName as 'Productos',
 c.Price as 'Precios'
 from 
 products as p
 inner join
 categories as c
 on p.CategoryID = c.CategoryID
 ;
 
 #5.-Obtener el nombre del cliente, el numero de orden y la fecha de orden = Incompleta
 
 #select
 #from customers as c
 #inner join orders as o
 #on c.Customers = o.CustomerID;
 
 #6.-Listar las ordenes mostrando el numero de orden, el nombre del producto y
 #la cantidad que se vendio = Lograda pero no mostro nada

select od.OrderId as 'Numero de orden',
p.ProductName as 'Nombre del producto',
od.Quantity as 'Cantidad vendida'
from OrderDetails as od
inner join products as p
on od.ProductID = p.ProductID
where od.OrderId = 11031
order by od.Quantity desc;