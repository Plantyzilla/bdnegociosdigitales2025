# Practica de Consultas avansadas
## Por: Yael Tolentino Osornio
## Ejercicios:

```sql
use Northwind
-- Seleccinar todos las categorias y productos 

select * from 
categories 
inner join 
products 
on categories.categoryid = products.categoryid;


select categories.categoryid, CategoryName, ProductName, 
UnitsInStock, UnitPrice 
from 
categories 
inner join 
products 
on categories.categoryid = products.categoryid;


select c.categoryid as [Número de Categoria], 
CategoryName as 'Nombre Categoria', ProductName as 'Nombre de Producto', 
UnitsInStock as 'Existencia', UnitPrice as Precio
from 
categories as c
inner join 
products as p
on c.categoryid = p.categoryid;


-- Seleccionar los productos de la categorias beverages y condiments donde
-- la existencia este entre 18 y 30 

select * 
from Products as p
join Categories as ca
on p.CategoryID = ca.CategoryID
where (ca.CategoryName = 'beverages' or ca.CategoryName = 'condiments')
and (p.UnitsInStock>=18 and p.UnitsInStock<=30)

select * 
from Products as p
join Categories as ca
on p.CategoryID = ca.CategoryID
where ca.CategoryName in ('beverages', 'condiments')
and p.UnitsInStock between 18 and 30;

-- Seleccionar los productos y sus importes realizados de marzo a junio de
-- de 1996, mostrando la fecha de la orden, el id del producto y el importe

select o.OrderID, o.OrderDate, od.ProductID, 
(od.UnitPrice * od.Quantity) as importe  
from Orders as o
inner join [Order Details] as od 
on od.OrderID = o.OrderID
where o.OrderDate between '1996-07-01' and '1996-10-31'

-- Mostrar el importe total de ventas de la consulta anterior 

select concat('$',' ',sum(od.Quantity * od.UnitPrice)) as importe 
from Orders as o
inner join [Order Details] as od 
on od.OrderID = o.OrderID
where o.OrderDate between '1996-07-01' and '1996-10-31'

-- Consultas Básicas con inner join 

-- 1.  Obtener los nombres de los clientes y los paises a los que se 
-- enviaron sus pedidos

select c.CompanyName as 'Nombre del Cliente', 
o.ShipCountry as 'País de Envio'
from Orders as o
inner join Customers as c
on c.CustomerID = o.CustomerID
order by 2 desc

select c.CompanyName, o.ShipCountry
from Orders as o
inner join Customers as c
on c.CustomerID = o.CustomerID
order by o.ShipCountry desc



-- 2. obtener los productos y sus respectivos proveedores
select p.ProductName as 'Nombre Producto', 
s.CompanyName as [Nombre del Proveedor]
from 
Suppliers as s
inner join 
products as p
on p.SupplierID = s.SupplierID

-- 3. Obtener los pedidos y los empleados que los gestionaron
select o.OrderID, concat (e.Title, ' - ', e.FirstName, '  ', e.LastName) as 'Nombre'
from 
Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID

-- 4. Listar los productos juntos con sus precios y la categoria a la que pertencen
      select p.ProductName as 'Nombre del Producto', 
	  p.UnitPrice as [Precio], c.CategoryName as 'Nombre Categoria'
	  from Categories as c
	  inner join 
	  Products as p
	  on c.CategoryID = p.CategoryID

-- 5. Obtener el nombre del cliente, el numero de orden y la fecha de orden
   Select c.CompanyName as [Cliente], 
   o.OrderID as [Número de Orden], o.OrderDate as [Fecha de Orden]
   from Customers as c
   inner join Orders as o
   on c.CustomerID = o.CustomerID
-- 6. Listar las ordenes mostrando el numero de orden, el nombre del producto y 
 --   la cantidad que se vendio
 select od.OrderID as [Numero de Orden], 
 p.ProductName as [Nombre del Producto], 
 od.Quantity as [Cantidad Vendida]
 from [Order Details] as od
 inner join Products as p
 on od.ProductID = p.ProductID
 order by od.Quantity desc

 select od.OrderID as [Numero de Orden], 
 p.ProductName as [Nombre del Producto], 
 od.Quantity as [Cantidad Vendida]
 from [Order Details] as od
 inner join Products as p
 on od.ProductID = p.ProductID
 where od.OrderID = 11031
 order by od.Quantity desc
 


 select top 5 od.OrderID as [Numero de Orden], 
 p.ProductName as [Nombre del Producto], 
 od.Quantity as [Cantidad Vendida]
 from [Order Details] as od
 inner join Products as p
 on od.ProductID = p.ProductID
 order by od.Quantity desc


 select od.OrderID as [Numero de Orden], 
 count(*) as 'cantidad de Productos vendidos'
 from [Order Details] as od
 inner join Products as p
 on od.ProductID = p.ProductID
 group by od.OrderID
 order by od.OrderID desc

 select * from 
 [Order Details] as od
 where od.OrderID = 11077


 -- 7. obtener los empleados y sus respectivos jefes
 select concat(e1.FirstName, ' ', e1.LastName) as [Empleado], 
 concat(j1.FirstName, ' ', j1.LastName) as [Jefe]
 from Employees as e1
 inner join Employees as j1
 on e1.ReportsTo = j1.EmployeeID

 select FirstName, ReportsTo
 from Employees

 -- 8 Listar los pedidos y el nombre de la empresa de transporte utilizada
 select o.OrderID, s.CompanyName as [Transportista] from
 Orders as o
 inner join 

 Shippers as s
 on o.ShipVia = s.ShipperID
```
 # Consultas inner join intermedias
```sql
 -- 9. Obtener la cantidad total de productos vendidos por categoria

  select c.CategoryName as 'Nombre Categoria', 
 sum(Quantity) as 'Productos Vendidos'
 from Categories as c
 INNER JOIN Products as p
 on c.CategoryID = p.CategoryID
 INNER JOIN [Order Details] as od
 on od.ProductID = p.ProductID
 group by c.CategoryName
 order by c.CategoryName

 -- 10. Obtener el total de ventas por empleado

 select concat( e.FirstName, ' ', e.LastName) as Nombre ,
 sum((od.Quantity * od.UnitPrice) - 
 (od.Quantity * od.UnitPrice) * od.Discount)  
 as Total
 from Orders as o
 inner join Employees as e
 on o.EmployeeID = e.EmployeeID
 inner join [Order Details] as od
 on od.OrderID = o.OrderID
 group by e.FirstName, e.LastName
 
 select count(*)
 from Orders as o
 where EmployeeID = 1

 select * from 
 Orders as o
 where EmployeeID = 1

 select e.FirstName ,count(o.OrderID)
 from Orders as o
 inner join Employees as e
 on o.EmployeeID = e.EmployeeID
 inner join [Order Details] as od
 on od.OrderID = o.OrderID
 where e.EmployeeID =1
 group by e.FirstName
 


 select *
 from Orders as o
 inner join [Order Details] as od
 on o.OrderID = od.OrderID
 inner join Employees as e
 on e.EmployeeID = o.EmployeeID

 -- 11. Listar los clientes y la 
 -- cantidad de pedidos que han realizado
  select c.CompanyName as [Cliente], 
 count(o.OrderID) as [Numero de Ordenes] 
 from Customers as c
 inner join Orders as o
 on c.CustomerID = o.CustomerID
 group by c.CompanyName
 order by [Numero de Ordenes] desc

 select c.CompanyName as [Cliente], 
 count(*) as [Numero de Ordenes] 
 from Customers as c
 inner join Orders as o
 on c.CustomerID = o.CustomerID
 group by c.CompanyName
 order by [Numero de Ordenes] desc

 select c.CompanyName as [Cliente], 
 count(*) as [Numero de Ordenes] 
 from Customers as c
 inner join Orders as o
 on c.CustomerID = o.CustomerID
 group by c.CompanyName
 order by 2 desc

 select c.CompanyName as [Cliente], 
 count(*) as [Numero de Ordenes] 
 from Customers as c
 inner join Orders as o
 on c.CustomerID = o.CustomerID
 group by c.CompanyName
 order by count(*) desc

 -- 12. Obtener los empleados que han gestionado pedidos
 -- enviados a alemania

 SELECT concat(e.FirstName, ' ', e.LastName) as [Nombre]
 FROM Employees as e
 INNER JOIN orders as o
 ON e.EmployeeID = o.EmployeeID
 where o.ShipCountry = 'Germany'


 SELECT distinct concat(e.FirstName, ' ', e.LastName) as [Nombre]
 FROM Employees as e
 INNER JOIN orders as o
 ON e.EmployeeID = o.EmployeeID
 where o.ShipCountry = 'Germany'

 -- 13. Listar los productos junto con el nombre del 
 -- proveedor y el país de origen

 select p.ProductName as [Nombre Producto], 
 s.CompanyName as [Proveedor], 
 s.Country as [País de Origen]
 from Products as p
 inner join Suppliers as s
 on p.SupplierID = s.SupplierID
 order by 1 asc

 -- 14. Obtener los pedidos agrupados por país de envio

    Select o.ShipCountry as [País de Envio], 
	count(o.OrderID) as [Numero de Ordenes]
	from Orders as o
	group by o.ShipCountry 
	order by 2 desc
	 

 -- 15. Obtener los empleados y la cantidad de territorios
 -- en los que trabajan

 select concat(e.FirstName, ' ', e.LastName) as [Nombre],
 count(et.TerritoryID) as [Cantidad Territorios]
 from Employees as e
 inner join EmployeeTerritories as et
 on e.EmployeeID = et.EmployeeID
 group by concat(e.FirstName, ' ', e.LastName)

 select concat(e.FirstName, ' ', e.LastName) as [Nombre],
 count(et.TerritoryID) as [Cantidad Territorios]
 from Employees as e
 inner join EmployeeTerritories as et
 on e.EmployeeID = et.EmployeeID
 group by e.FirstName, e.LastName

 select concat(e.FirstName, ' ', e.LastName) as [Nombre],
 t.TerritoryDescription
 ,count(et.TerritoryID) as [Cantidad Territorios]
 from Employees as e
 inner join EmployeeTerritories as et
 on e.EmployeeID = et.EmployeeID
 INNER JOIN Territories as t
 on et.TerritoryID = t.TerritoryID
 group by e.FirstName, e.LastName, t.TerritoryDescription
 order by [Nombre], t.TerritoryDescription desc
 -- 16. Listar las categorias y la cantidad de productos 
 -- que contienen
 select c.CategoryName as [Categoria], 
 count(p.ProductID) as [Cantidad de Productos]
 from Categories as c
 inner join Products as p
 on c.CategoryID = p.CategoryID
 group by c.CategoryName
 order by 2 desc

 -- 17. Obtener la cantidad total de productos vendidos por
 -- proveedor

 select s.CompanyName as [Proveedor], 
 sum(od.Quantity) as [Total de productos Vendidos]
 from Suppliers as s
 inner join Products as p
 on s.SupplierID = p.SupplierID
 inner join [Order Details] as od
 on od.ProductID = p.ProductID
 group by s.CompanyName
 order by 2 desc


 -- 18. Obtener la cantidad de pedidos enviados por cada 
 -- empresa de transporte

 select s.CompanyName as [Transportista],count(*) as [Total de Pedidos] 
 from Orders as o
 inner join Shippers as s
 on o.ShipVia = s.ShipperID
 group by s.CompanyName


 select * from Orders

  select count(*) from Orders

  select count(OrderID) from Orders

  select count(ShipRegion) from Orders
```



# Consultas Avanzadas 
```sql
  -- 19. Obtener los clientes que han realizado pedidos de productos distintos

select c.CompanyName, count(distinct ProductID) as [Numero Productos]
from 
Customers as c
INNER JOIN Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName
order by 2 Desc

-- 20. Listar los empleados con la cantidad total de pedidos que han gestionado, y a que 
-- clientes les han vendido, agrupandolos por nombre completo y dentro de este nombre por 
-- cliente, ordenadolos por la cantidad de mayor de pedidos

select concat(e.FirstName, ' ', e.LastName) as [Nombre]
,count(OrderID) as [Número de Ordenes]
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
group by e.FirstName, e.LastName
order by [Nombre] asc



select concat(e.FirstName, ' ', e.LastName) as [Nombre], 
c.CompanyName as [Cliente]
,count(OrderID) as [Número de Ordenes]
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
inner join Customers as c
on o.CustomerID = c.CustomerID
group by e.FirstName, e.LastName, c.CompanyName
order by [Nombre] asc, [Cliente]


-- 21. Listar las categorias con el total de ingresos generados por sus productos
select c.CategoryName,sum(od.Quantity * od.UnitPrice) as [Total]
from categories as c
inner join  Products as p
on c.CategoryID = p.CategoryID 
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by c.CategoryName

select c.CategoryName, p.ProductName ,sum(od.Quantity * od.UnitPrice) as [Total]
from categories as c
inner join  Products as p
on c.CategoryID = p.CategoryID 
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by c.CategoryName, p.ProductName
order by c.CategoryName

-- 22. Listar los clientes con el total ($) gastado en pedidos

select c.CompanyName, sum(od.Quantity * od.UnitPrice) as [Total]
from customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName

-- 23. Listar los pedidos realizados entre el 1 de enero de 1997 y el 30 de junio de 1997 y 
-- mostrar el total en dinero

select o.OrderDate, sum(od.Quantity * od.UnitPrice) as [Total]
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
where OrderDate between '1997-01-01' and '1997-06-30'
group by o.OrderDate


--24. Listar los productos con las categorias Beverages, seafood, confections

select p.ProductName, c.CategoryName 
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
where c.CategoryName in ('Beverages', 'seafood','confections')

-- 25. Listar los clientes ubicados en Alemania Y que hayan 
-- realizado pedidos antes del 1 de enero de 1997

select c.CompanyName, c.Country, o.OrderDate 
From Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
where country = 'Germany' 
and o.OrderDate<'1997-01-01'

-- 26. Listar los clientes que han realizado pedidos con un total entre $500 y $2000

select c.CompanyName, sum(od.Quantity * od.UnitPrice) as [Total]
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName
having sum(od.Quantity * od.UnitPrice) between 500 and 2000


-- Left Join, Right Join, Full Join y Cross Join

-- Practica de utilización de Left Join

-- Seleccionar los datos que se van a utilizar para insertar
-- en la tabla products_new

-- product_id, productName, customer, category, unitprice, 
-- discontinued, inserted_date
```