#Consulta de agregado
#Solo devuelven un solo regristro
#sum, avg, count, count(*), max y min

#Cuantos clientes tengo
select count(*) as 'Numero de clientes'
from customers;

#Cuantas regiones hay
select count(*)
from customers
where CustomerID is null;

#seleccionar el numero de productos por
#categoria
select CategoryID, count(*)
from products
group by CategoryID;

select categories.categoryName,
count(*) as 'Numero de Productos'
from 
categories
inner join Products as p
on categories.categoryID = p.CategoryID
group by categories.categoryName;

select * from products;
select categoryid, avg(Price) as 'Precio promedio'
from Products
group by CategoryID;

#seleccionar el numero de pedidos realizados por cada empleado por el
#ultimo trmestre de 1996

select employeeID, count(*) as 'Numero de pedidos'
from orders
group by EmployeeID;

select employeeID ,count(*) from orders
where OrderDate between '1996-10-01' and '1996-12-31'
group by employeeID;

#seleccionar la suma total de unidades vendidas por cada producto
#Nota: Los corchetes no existen en MySQL

select ProductID, sum(Quantity) as 'Unidades vendidas'
from OrderDetails
group by OrderID, ProductID
Order by 1 asc;

select ProductID, sum(Quantity) as 'Unidades vendidas'
from OrderDetails
group by OrderID, ProductID
Order by 2 asc;

#Seleccionar el numero de productos
#por categoria, pero solo aquellos que
#tengan mas de 10 productos

select dis CategoryID ,count(price) as 'total products'
from products
where categoryID in (1,3,4)
group by categoryID
having count(*) > 10;

#Listar las ordenes agrupadas por empleado, pero solo muestre aquellos
#que hayan gestion mas de 10 pedidos

select * from orders;

