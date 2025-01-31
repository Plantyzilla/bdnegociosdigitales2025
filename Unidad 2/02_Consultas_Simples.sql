# Lenguaje SQL-LMD (Insert, delate, select, CRUD)
# Consultas simples

use northwind;

# Mostrar todos los clientes, proveedores, categorias, productos
# de la empresa
select * from Customers;
select * from Employees;
select * from Orders;
select * from Suppliers;
select * from Products;
select * from Shippers;
select * from categories;
select * from OrderDetails;
# Proyeccion 
select ProductID, ProductName, UnitPrice, UnitsInStock
from products;

select * from customers;

#Mostrar los paices en donde en donde se tienen clientes,
#mostrar solamente paises

select distinct Country from customers
order by Country;

#Mostrar todas las ordenes de compra donde  la cantidad
#de productos comprados sea mayor a 5

select * from OrderDetails
where Quantity >= 40;

#Mostrar el nombre completo del empleado, su numero de empleado,
#fecha de nacimiento, la ciudad y fecha de contratación y esta debe
#ser de aquellos que fueron contratados despues de 1993,
#Los resultados en sus encabezados deben ser mostrados en español

select firstName + '',
lastsName as Nombre,
EmployeeID as 'Numero de empleados',
BirthDate as 'Fecha de nacimiento',
City as Ciudad,
HireDate as 'Fecha de contratacion'
from employees
where year (HireDate) > 1993
