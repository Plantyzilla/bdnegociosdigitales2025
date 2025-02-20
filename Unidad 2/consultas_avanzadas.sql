#Inner Joins
![Inner join](../img/img/img)

use Northwind;

select s.CompanyName as 'Transportista', count(*) as 'Total de pedidos'
from 
Orders as o
inner join Shippers as s
on o.ShipVia = s.ShipperID
group by s.CompanyName;

select c.CompanyName, count(distinct ProductID) as [Numero Productos]
from
Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName
order by 2 desc;

--20 Listar los empleados con la cantidad total de pedidos que han gestionado y a que
--clientes les han vendido, agrupandolos por nombre completo y dentro de este nombre por
--cliente, ordenandolos por la cantidad de mayor de pedidos.

select concat(em.FirstName, ' ', em.LastName) as 'Nombre completo',
cu.CompanyName as 'Cliente',
count(OrderID) as 'Numero de pedidos'
from
orders as od
inner join Employees as em
on od.OrderID = em.EmployeeID
inner join Customers as cu
on od.CustomerID = cu.CustomerID
group by em.FirstName, em.LastName, cu.CompanyName
order by 'Nombre Completo' asc, 'Cliente';

-- 21. Listar las categorias con el total de ingresos generados por sus productos

select c.CategoryName as 'Nombre de la categoria', sum (od.Quantity * od.UnitPrice) as [Total]
from categories as c
inner join products as p
on p.ProductID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by c.CategoryName


-- 22. Listar los clientes con el total ($) gastados en pedidos
select * from Orders
select * from Customers
select * from [Order Details]

select c.CompanyName, sum(od.Quantity * od.Unitprice) as [Total]
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName

--23. Listar los pedidos realizados entre el 1 de enero de 1997 y el 30 de junio de 1997 y mostrar el 
--total en dinero

select o.OrdeDate , sum (od.Quantity * od.UnitPrice) as [Total]
from Orders as o 
inner join [Order Details] as od
on o.OrderID = od.OrderID
where OrderDate between '1997-01-01' and '1997-06-30'
group by o.OrderDate





--24. Listar los productos con las categorias Beverages,seafood, confections

select p.ProductName, c.CategoryName
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
where c.CategoryName in ('Beverages', 'seafood', 'confection')

--25. Listar los clientes ubicados en Alemania y que hayan realizado pedios antes del 1 de enero de 1997

select c.CompanyName, c.Country, o.OrderPrice
from Customers as c
inner join Orders as o 
on c.CustomerID = o.CustomerID
where country = 'Germany'
and o.OrderDate<'1997-01-01'

--26. Listar los clientes que han realizado pedidos con un total entre $500 y $20000
select c.CompanyName, sum(od.Quantity * od.UnitPrice) as [Total]
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName
having sum(od.Quantity * od.UnitPrice) between 500 and 2000

--Left join, Right join, Full join y Croos Join

