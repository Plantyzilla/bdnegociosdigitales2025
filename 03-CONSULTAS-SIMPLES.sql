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

--Seleccionar Empleados que no viven en Londres o Seattle y que fueron contratados despues de 1995

Select CONCAT(FirstName, ' ', LastName) as 'Nombre Completo', HireDate, City, Country from Employees where NOT(City = 'London' or City = 'Seattle') and year(HireDate) >= 1992;

Select CONCAT(FirstName, ' ', LastName) as 'Nombre Completo', HireDate, City, Country from Employees where City <> 'London' and City <> 'Seattle' and year(HireDate) >= 1992;

--Clausula IN (OR)

-- Seleccionar los productos con categorias 1, 3 o 5

Select ProductName, CategoryID, UnitPrice from Products where CategoryID = 1 or CategoryID = 3 or CategoryID = 5 order by CategoryID;

Select ProductName, CategoryID, UnitPrice from Products where CategoryID IN (1,3,5) order by CategoryID;

--Seleccionar todas ordenes de la region RJ, Tachira y que no tengan region asignada

Select OrderID, OrderDate, ShipRegion, ShipCountry from Orders where ShipRegion IN ('RJ', 'Táchira') or ShipRegion is null;

--seleccionar las ordenes que sse tengan cantidades de 12, 9 o 40 y descuento de 0.15 o 0.05

Select OrderID, Quantity, Discount from [Order Details] where Quantity in (12, 9, 40) and Discount in (0.15, 0.05) order by Quantity;

--Clausula Between (Siempre va en el WHERE)

-- beetwen valorInicial and valorFinal
--Mostrar los productos con un precio entre 10 y 50

select * from Products where UnitPrice >= 10 and UnitPrice <=50;

select * from Products where UnitPrice between 10 and 50;

--Seleccionar todos los pedidos realizados entre el primero de enero y el 30 de junio de 1997

Select OrderID, OrderDate, ShipVia, ShipCountry from Orders where MONTH(OrderDate) between 01 and 06 and day(OrderDate) between 01 and 30 and year(OrderDate) = 1997;

Select OrderID, OrderDate, ShipVia, ShipCountry from Orders where OrderDate between '1997-01-01' and  '1997-06-30';

select * from Orders

--Seleccionar todos los empleados contratados entre 1992 y 1994 que trabajan en londres

Select EmployeeID, CONCAT(FirstName, ' ', LastName) as 'Nombre Completo', Title, HireDate, City from Employees where (year(HireDate) between 1992 and 1994) and City = 'London' ;

Select * from Employees

select OrderID as 'Numero de orden', OrderDate as 'Fecha de Orden', RequiredDate as 'Fecha de Entrega', Freight as 'Peso', ShipCountry as 'Pais' from orders where Freight >=50 and Freight<=200 and (ShipCountry = 'France' or ShipCountry = 'Germany');

select OrderID as 'Numero de orden', OrderDate as 'Fecha de Orden', RequiredDate as 'Fecha de Entrega', Freight as 'Peso', ShipCountry as 'Pais' from orders where Freight between 50 and 200 and (ShipCountry in ('France', 'Germany'));

--Seleccionar todos los productos que tengan un precio entre 5 y 20 dolares o que sean de la categoria 1, 2 o 3

Select ProductID, ProductName, UnitPrice, UnitsInStock, CategoryID from Products where UnitPrice between 5 and 20 or CategoryID in (1, 2, 3);

Select ProductName, CategoryID, UnitPrice from Products where UnitPrice >=5 and UnitPrice <= 20 or (CategoryID = 1 or CategoryID = 2 or CategoryID = 3);

--Empleados con numero de trabajador entre 3 y 7 que no trabajan en londres ni seattle

select EmployeeID as 'Numero de Empledado', CONCAT(FirstName, ' ', LastName) as 'Nombre Completo', City as Ciudad from Employees where EmployeeID between 3 and 7 and NOT City in ('London', 'Seattle');

select EmployeeID as 'Numero de Empledado', CONCAT(FirstName, ' ', LastName) as 'Nombre Completo', City as Ciudad from Employees where EmployeeID >= 3 AND EmployeeID <= 7 and (City <> 'London' and City <> 'Seattle');

select EmployeeID as 'Numero de Empledado', CONCAT(FirstName, ' ', LastName) as 'Nombre Completo', City as Ciudad from Employees where EmployeeID >= 3 AND EmployeeID <= 7 and not City in ('London', 'Seattle');

--Clausula Like Patrones
-- Patrones 
-- 1) % (Porcentaje) -> Representa cero o mas caracteres en el patron de busqueda
-- 2) _ (Guion Bajo) -> Representa exactamente un caracter en el patron de busqueda
-- 3) [] (Corchetes) -> Se utiliza para definir un conjunto de caracteres, buscando cualquiera de ellos en la posicion especifica
-- 4) [^] (Acento Circunflenjo) -> Se utiliza para buscar caracteres que no estan dentro del conjunto especifico

-- Buscar los productos que comienzan con C

Select * from Products where ProductName like 'C%';

Select * from Products where ProductName like 'Ch%';

Select * from Products where ProductName like 'Cha%' and UnitPrice = 18;

-- Buscar todos los productos que terminen con E

Select * from Products where ProductName like '%E';

-- Seleccionar todos los clientes cuyo nombre de empresa contiene co en cualquier parte

select * from Customers where CompanyName like '%co%';

-- Seleccionar los empleados cuyo nombre comienze con "A" y tenga exactamente 5 caracteres

Select * from Employees where FirstName like 'A_____';

-- Seleccionar los productos que comiencen con A o B
Select * from Products where ProductName like '[ABC]%';

Select * from Products where ProductName like '[A-M]%';

-- Seleccionar todos los productos que no comiencen con A o B

Select * from Products where ProductName like '[^AB]%';

-- Seleccionar todos los prodcutos donde el nombre tenga la A pero no la E

Select * from Products where ProductName like 'B[^E]%';

-- Clausula Order by
-- 
Select ProductID, ProductName, UnitPrice, UnitsInStock from Products order by UnitPrice desc;

Select ProductID, ProductName, UnitPrice as precio, UnitsInStock from Products order by 'precio' desc;

-- Seleccionar los clientes ordeados por el pais y dentro por ciudad

Select CustomerID, Country, City from Customers WHERE Country in ('Brazil', 'Germany') order by Country asc, City asc;

Select CustomerID, Country, City from Customers WHERE Country in ('Brazil', 'Germany') order by Country asc, City desc;

Select CustomerID, Country, City from Customers WHERE (Country ='Brazil' or Country = 'Germany') and Region is not null order by Country asc, City desc;

Select CustomerID, Country, City from Customers WHERE (Country ='Brazil' or Country = 'Germany') and Region is not null order by Country, City desc;

Select * from Customers order by Country asc, City desc;

Select * from Customers order by Country desc, City asc;

Select * from Customers order by Country desc, City desc;