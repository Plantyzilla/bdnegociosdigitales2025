-- Lenguaje SQL-LMD (Insert, Update, Delete, Select CRUD)
--Consultas Simples 

use Northwind;

--Mostrar todos los clientes, prveedores, categorias, prodcutos, ordenes, detalle de orden con todas las columnas de datos de la empresa

Select * from Customers;

Select * from Employees;

Select * from Orders;

Select * from Suppliers;

Select * from Products;

Select * from Shippers;

Select * from Categories;

Select * from [Order Details];

-- Proyeccion

Select ProductID, ProductName, UnitPrice, UnitsInStock from Products;

--Seleccionar o mostrar el numero d eempleado su primer nombre, su cargo, ciudad y pais

Select EmployeeID, FirstName, Title, City, Country from Employees;

--Alias de columna

--En base de la consulta anterior, visualizar el employeeID como numero empleado, el firstname como primerNombre, Title como cargo, city como ciudad, country como pais.

Select EmployeeID as [Numero Empleado], FirstName as primerNombre, Title as Cargo, City as Ciudad, Country 'Pais' from Employees;

--Campo calculado, seleccionar el importe de cada uno de los productos vendidos en una orden 

select *,(UnitPrice * Quantity) as Import from [Order Details];

--Seleccionar las fechas de orden, año, dia, cliente que las ordeno y el empleado que las realizo

select OrderDate as 'Fecha de Orden', 
year(OrderDate) as 'Año de la Orden', 
MONTH(OrderDate) as 'Mes de la Orden', 
day(OrderDate) as 'Dia de la Orden', 
CustomerID, 
EmployeeID  
from Orders;

-- Filas Duplicadas

select * from Customers;

--Mostrar los paises donde se tienen clientes, mostrando los paises

select distinct Country as Pais from Customers order by Country;

-- Distinct se usa para solo mostrar los datos distintos

-- Clausula Where

-- Operadores Relacionales o test de comparación (<,>,=,<=,>=,!= o <>)

Select * from Customers ;

--Seleccionar el cliente BOLID

select CustomerID as 'Numero Cliente', CompanyName as 'Nombre Compañia', City as 'Ciudad', Country as Pais from Customers where CustomerID = 'BOLID';

Select CustomerID as Identificador, CompanyName as 'Nombre Compañia', ContactName as Contacto, City as Ciudad, Country as Pais from Customers where Country = 'Germany';

-- Seleccionar todos los clientes que no sean de alemania

Select CustomerID as Identificador, CompanyName as 'Nombre Compañia', ContactName as Contacto, City as Ciudad, Country as Pais from Customers where Country != 'Germany';

-- Seleccionar su nombre de producto, categoria ala que pertenece,  unidad de existencia, precio, pero solo donde su precio sea mayor a 100

select ProductName as 'Nombre del Producto', UnitsInStock as Existencia, CategoryID as Categoria, UnitPrice as Precio, (UnitPrice * UnitsInStock) as 'Costo Inventario' from Products where UnitPrice > 100;

--Seleccionar las ordenes de compra mostrando la fecha de orden, fecha de entrega, fecha de envio, el clientea quien se vendio de 1996

select OrderDate as 'Fecha de Orden', RequiredDate as 'Fecha de Entrega' , ShippedDate as 'Fecha de Envio', CustomerID as Cliente from Orders where year (OrderDate) ='1996';

select * from Orders;

-- Mostrar todas las ordenes de compra donde la cantidad de productos comprados sea mayor a 5 

select Quantity as Cantidad from [Order Details] WHERE Quantity > 40;

--Mostrar el nombre completo del empleado, su numero de empleado, fecha de nacimiento, la ciudad y fecha de contratacion y esta debe de ser de aquellos que fueron contratados despues de 1993,
--Los resultados en sus encabezados deben ser en español.

Select (FirstName + ' ' + LastName) as 'Nombre Completo', EmployeeID as 'Numero de Empleado', BirthDate as 'Fecha de Nacimiento', City as Ciudad, HireDate as 'Fecha de Contratacion' from Employees where YEAR (HireDate) = 1993;

Select concat(FirstName, ' ', LastName) as 'Nombre Completo', EmployeeID as 'Numero de Empleado', BirthDate as 'Fecha de Nacimiento', City as Ciudad, HireDate as 'Fecha de Contratacion' from Employees where YEAR (HireDate) = 1993;

-- Mostrar los empleados que no son dirigidos por el jefe 2

select EmployeeID , concat(FirstName, ' ', LastName) as 'Nombre Completo' , ReportsTo from Employees where ReportsTo != 2 ;

select * from Employees where ReportsTo != 2 ;

-- Seleccionar todos los empleados que no tengan un jefe

select * from Employees where ReportsTo is null;

--Operadores Logicos (OR, AND, NOT)
--Seleccionar los productos que tengan un precio de entre 10 y 50 

select ProductName AS 'Nombre de Producto' ,UnitPrice AS Precio, UnitsInStock AS Existencia from Products where UnitPrice >= 10 AND UnitPrice <= 50 order by UnitPrice;

-- Mostrar todos los pedidos realizados por clientes que no son de alemania

select OrderID as 'Numero de Orden', CustomerID as 'Numero de cliente', EmployeeID as 'Numero de Empleado', OrderDate as 'Fecha de Pedido', ShipCity as Ciudad, ShipCountry as Pais from Orders where NOT ShipCountry = 'Germany' order by ShipCountry;

select OrderID as 'Numero de Orden', CustomerID as 'Numero de cliente', EmployeeID as 'Numero de Empleado', OrderDate as 'Fecha de Pedido', ShipCity as Ciudad, ShipCountry as Pais from Orders where NOT ShipCountry != 'Germany' order by ShipCountry;

-- Seleccionar clientes de Mexico o USA

select CustomerID as 'Numero cliente', ContactName as Nombre, Country as Pais from Customers where Country = 'Mexico' OR Country = 'USA';

--Seleccionar empleados que nacieron entre 1955 y 1958 que viven en londres

Select EmployeeID as 'Numero de Empleado', (FirstName + ' ' + LastName) as 'Nombre Completo', BirthDate as 'Fecha de Nacimiento', City as Ciudad from Employees where (YEAR(BirthDate) >= 1955 and YEAR(BirthDate) <= 1958) and City = 'London';

-- Seleccionar pedidos con fletes de peso (Freight) mayor a 100 y enviados a Francia o España

Select * from Orders where Freight > 100 and (ShipCountry = 'France' or ShipCountry = 'Spain') order by ShipCountry;

--seleccionar las primeras 5 ordenes de compra
-- para mysql es Limit 

select top 5 * from Orders ;

-- Seleccionar Productos con precio entre $10 y  $50 que no esten descontinuados y tengan mas de 20 unidades en stock 33

select ProductName, UnitPrice, UnitsInStock, Discontinued from Products where (UnitPrice >= 10 and UnitPrice <= 50) and Discontinued = 0 and UnitsInStock > 20;

--Seleccionar Pedidos enviados a francia o alemania, pero con un flete menor a 50 114

Select OrderID, ShipCountry, Freight from Orders where (ShipCountry = 'France' or ShipCountry = 'Germany') and Freight < 50;

--Seleccionar clientes que no son de mexico o USA y que tengan Fax registrado 57

select CustomerID, CompanyName, ContactName, Country, Fax from Customers where NOT (Country = 'Mexico' or Country = 'USA') and Fax is not null;

select CustomerID, CompanyName, ContactName, Country, Fax from Customers where (Country != 'Mexico' and Country != 'USA') and Fax is not null;

--Seleccionar los pedidos con  un flete mayor a 100 enviados a brasil o  argentina, pero no enviados por el transportista1

Select OrderID, OrderDate, Freight, ShipVia, ShipCountry from Orders where Freight >= 100 and (ShipCountry = 'Brazil' or ShipCountry = 'Argentina') and  NOT ShipVia = 1;

--1. Productos con categoría 1, 3 o 5 32

select * from Products where CategoryID = 1 or CategoryID = 3 or CategoryID = 5 order by CategoryID; 

--2. Clientes de México, Brasil o Argentina

select * from Customers;
--3. Pedidos enviados por los transportistas 1, 2 o 3 y con flete mayor a 50
--4. Empleados que trabajan en Londres, Seattle o Buenos Aires
--5. Pedidos de clientes en Francia o Alemania, pero con un flete menor a 100
--6. Productos con categoría 2, 4 o 6 y que NO estén descontinuados
--7. Clientes que NO son de Alemania, Reino Unido ni Canadá
--8. Pedidos enviados por transportistas 2 o 3, pero que NO sean a USA ni Canadá
--9. Empleados que trabajan en 'London' o 'Seattle' y fueron contratados después de 1995
--10. Productos de categorías 1, 3 o 5 con stock mayor a 50 y que NO están descontinuados

