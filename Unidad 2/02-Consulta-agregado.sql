-- Consultas de Agregados 
-- Nota: Solo devuelven un solo registro sum, avg, count(*), max, min

--Cuantos clientes tengo

use Northwind;

Select count(*) as 'Número de clientes' from Customers;

-- Cuantas regiones hay
Select COUNT(*) from Customers where Region is null;

select count (distinct Region) from Customers where Region is not null;


--NIKO
--seleccciona el precio mas bajo de los productos

select min(UnitPrice) as 'precio minimo' from Products;

select avg(UnitsInStock) as 'unidades en stock' from Products;

select min(UnitsInStock) as 'unidades en stock' from Products;

select UnitsInStock as 'unidades en stock' from Products;

-- seleccionar cuantos pedidos ecisten 

select * from Orders;

select count(*) as 'numeros pedidos' from Orders;

-- calcula el total de dinero vendido

select *  from [Order Details]

select sum(UnitPrice * Quantity) as 'total dinero' from [Order Details]

select sum(UnitPrice * Quantity - (unitprice * Quantity * Discount)) 
 as 'total dinero' from [Order Details]

-- calcula el total de unidades en stock de todos los productos

select sum(UnitsInStock) as 'en stock' from Products;

-- Calcula el total de dinero vendido
select * from [Order Details]

-- Calcula el total de unidades en stock de todos los productos

Select sum(UnitsInStock) as 'Total Stock' from Products;

--Seleccionar el total de dinero que se gano en el ultimo trimestre de 1996

select * from Products 

--Seleccionar cuantos prodcutos tengo 

Select count(*) from Products;
--Seleccionar cuantos productos hay por categoria

Select * from Products;


--GROUP BY--
--Seleccionar el numero de productos por categoria

select count(CategoryID) as 'Categoria ID', COUNT(*) as 'Productos' from Products;

select CategoryID as 'Categoria ID', COUNT(*) as 'Productos' from Products group by CategoryID;

select CategoryID as 'Categoria ID', COUNT(*) as 'Numero de Productos' from Products group by CategoryID;

select p.CategoryID ,count(*) as 'Numero de productos' from 
Categories as c
inner join Products as p 
on c.CategoryID = p.CategoryID group by p.CategoryID;

select Categories.CategoryName ,count(*) as 'Numero de productos' from 
Categories
inner join Products as p 
on Categories.CategoryID = p.CategoryID group by Categories.CategoryName;

-- Calcular el precio promedio de los productos por cada categoria AVG es para promedios.

Select CategoryID, avg(UnitPrice) as 'Precio Promedio' from Products group by CategoryID;


-- Seleccionar el numero de pedidos realizados por cada empleado

Select * from Orders

select EmployeeID, COUNT(OrderID) as 'Numero de pedidos' from Orders group by EmployeeID;

select EmployeeID, COUNT(*) as 'Numero de pedidos' from Orders 
where OrderDate between '1996-01-10' 
and '1996-31-12' group by EmployeeID;



-- Seleccionar la suma total de unidades vendidas por cada producto
Select ProductID, sum(Quantity) from [Order Details] group by ProductID;

Select top 5 ProductID, sum(Quantity) as 'Numero de Productos Vendidos'
from [Order Details] 
group by ProductID 
order by 2 desc;

Select ProductID, sum(Quantity) as 'Numero de Productos Vendidos'
from [Order Details] 
group by ProductID 
order by 2 desc;


Select OrderID, ProductID, sum(Quantity) as 'Numero de Productos Vendidos' 
from [Order Details] 
group by OrderID, ProductID order by 2 desc;

-- Seleccionar el numero de productos por categoria, pero solo aquellos que tengan mas de 10 productos

Select * from Products

Select CategoryID, sum(UnitPrice) from Products WHERE CategoryID in (1,3,4) group by CategoryID having sum(UnitPrice) > 10;

Select CategoryID, COUNT(*) from Products group by CategoryID having count(*) > 10;

-- Paso 1
Select * from Products
Select distinct CategoryID from Products;

--Paso 2
Select CategoryID, UnitsInStock from Products 
where CategoryID in (2, 4, 8) 
order by CategoryID;

--Paso 3
Select CategoryID, sum(UnitsInStock) from Products 
where CategoryID in (2, 4, 8) 
group by CategoryID
order by CategoryID;

--Paso 4
Select CategoryID, sum(UnitsInStock) from Products 
where CategoryID in (2, 4, 8) 
group by CategoryID
having count (*) > 10
order by CategoryID;

Select CategoryID, sum(UnitsInStock) from Products 
where CategoryID in (2, 4, 8) 
group by CategoryID
having sum (CategoryID) > 10
order by CategoryID;

--Listar las ordenes agrupadas por el empleado, pero que solo muestre aquellos que hayan gestionado mas de 10 pedidos

Select EmployeeID, count(OrderID) from Orders group by EmployeeID having COUNT(OrderID) > 10;

Select EmployeeID, count(OrderID) from Orders group by EmployeeID;
