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
where year (HireDate) > 1993;

# Seleccionar clientes de México o USA
select * from Customers;

select * from Orders
limit 5;

#Seleccionar los productos con precio entre $10 y $50,
#que NO estén descontinuados y tengan más de 20 unidades en stock

select ProductName, UnitPrice, UnitsInStock, Discontinued
from products
where UnitPrice >=10 and UnitPrice <=50
					and Discontinued =0
                    and unitsInStock >20;

#Pedidos enviados a francia o alemania pero con un flete menor a 50

select OrderID, shipCountry, Freight
from orders
where ShipCountry = 'France' or ShipCountry = 'Germany'
		and Freight <50;

#Clientes que NO sean de México o USA

#Seleccionar las ordenes que tengan cantidades de 12, 9, o 40
#y descuento de 0.15 o 0.05

select * from products
where UnitPrice between 10 and 50;

#Seleccionar todos los pedidos realizados
#entre  el primero de enero y el 30 de junio de 1997

select * from orders;

select OrderID as 'Numeros',
CustomerID as 'clientes',
OrderDate as 'Fecha del pedido'
from orders
where (month(OrderDate) between 01 and 06) and day(OrderDate) between 01 and 30
and year(OrderDate);

#Selecionar todos los empleados contratados entre 1990 y 1995
#que trabajan en londres

select * from employees;

select EmployeeID as 'Numero del empleado',
LastName as 'Nombre',
FirstName as 'Apellido',
BirthDate as 'Día del contrato'
from employees
where date(BirthDate) between '1990' and '1995'; 

#Clausula Like
#Patrones:
		#1) % (Porcentaje) -> Representa cero o mas caracteres en el patron de busqueda.
        #2) _ (Guion bajo) -> Representa exactamente un caracter en el patron de busqueda.
        #3) [] (Corchetes) -> Se utilizan para definir un conjunto de caracteres, buscando
        #cualquiera de ellos en la posicion espesifica.
        #4) ^ (Potencia) -> Se utiliza para buscar caracteres que no estan dentro del
        #conjunto espesifico.
        