# Practicas de las consultas agregado
## Por: Yael Tolentino Osornio


## Consultas de agregado Nota: solo devuelven un solo registro sum, avg, count, count(*), max y min 

# Ejercicios
```sql
-- cuantos clientes tengo
select count(*) as 'Numero de clientes' 
from Customers

-- cuantas regiones hay
select count(*) 
from Customers
where region is null


select count(distinct region)
from Customers
where region is not null

select * from Orders
select count(*) from Orders
select count(ShipRegion) from Orders

select * from Products

-- Selecciona el precio mas bajo de los
-- productos
select min(UnitPrice), max(UnitPrice),
avg(UnitsInStock)
from Products;

-- Seleccionar cuantos pedidos existen 
select count(*) as [Número de Pedidos] 
from Orders

-- Calcula el total de dinero vendido
select sum(UnitPrice * Quantity ) 
from [Order Details]

select sum(UnitPrice * Quantity - 
 (UnitPrice  * Quantity * Discount) ) as Total
from [Order Details]
-- calcula el total de unidades en stock de 
-- todos los productos

select sum(UnitsInStock) as 'Total Stock' 
from Products

-- Seleccionar el numero de productos por
-- categoria
select CategoryID, count(*) as 'Numero de productos' 
from Products
group by CategoryID

select Categories.CategoryName, 
count(*) as [Numero de Productos] 
from 
Categories
inner join Products as p
on Categories.CategoryID = p.CategoryID
group by Categories.CategoryName

-- Calcular el precio promedio de los productos por cada categoria
select categoryid, avg(UnitPrice) as 'Precio Promedio'
from Products
group by CategoryID

-- seleccionar el numero de pedidos realizados por cada empleado por el
-- ultimo trimestre de 1996
select EmployeeID,count(*) as 'Numero de Pedidos'
from Orders
group by EmployeeID

select EmployeeID ,count(*) from Orders
where OrderDate between '1996-10-01' and '1996-12-31'
group by EmployeeID

-- Seleccionar la suma total de unidades vendidas por cada producto
select ProductID,sum(Quantity) as 'Numero de Productos vendidos' 
from [Order Details]
group by ProductID
order by 1 desc

select orderid, ProductID,sum(Quantity) as 'Numero de Productos vendidos'
from [Order Details]
group by orderid, ProductID
order by 2 desc

-- Seleccionar el numero de productos por categoria 
-- pero solo aquellos quie tengan mas de 10 productos

-- paso 1 
select * from Products
-- select distinct CategoryID from Products

-- paso 2
select CategoryID, UnitsInStock from Products
where CategoryID in (2,4,8)
order by CategoryID

-- paso 3

select CategoryID, sum(UnitsInStock) 
from Products
where CategoryID in (2,4,8)
group by CategoryID
order by CategoryID

-- paso 4
select CategoryID, sum(UnitsInStock) 
from Products
where CategoryID in (2,4,8)
group by CategoryID
having count(*)>10
order by CategoryID

-- Listar las ordenes agrupadas por empleado, pero que solo muestre aquellos
-- que hayan gestionado mas de 10 pedidos.
```