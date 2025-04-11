use Northwind;

--Muestra el nombre de los clientes (CompanyName) 
--y cuántos pedidos han hecho, pero solo los que tienen más de 5 pedidos.
select * from Customers;
select * from Orders;
go

select c.CompanyName as 'Clientes',
count(o.OrderID) as 'Cantidad de pedido'
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
group by c.CompanyName
having count(o.OrderID) > 5;
go

--Muestra el nombre del producto y su promedio de unidades vendidas 
--en los pedidos (OrderDetails), ordenado de mayor a menor.

select * from Products;
select * from [Order Details];
go

--Sin having
select p.ProductName as 'Nombre del producto',
AVG(od.Quantity) as 'Promedio'
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
group by p.ProductName 
order by AVG(od.Quantity) desc;
go
--Con having
select p.ProductName as 'Nombre del producto',
avg(od.Quantity) as 'Promedio'
from [Order Details] as od
inner join Products as p on od.ProductID = p.ProductID
group by p.ProductName
having avg(od.Quantity) > 20
order by avg(od.Quantity) desc;
go
--ORDER BY columna ASC   -> Menor a mayor (Ascendente)
--ORDER BY columna DESC  -> Mayor a menor (Descendente)

--Muestra el ID del pedido (OrderID), el nombre del cliente (CompanyName) 
--y el nombre completo del empleado (FirstName + LastName) que atendió el pedido.
select * from Orders;
select * from Customers;
select * from Employees;
go

select o.OrderID as 'Id del pedido',
c.CompanyName as 'Nombre del cliente',
e.FirstName + ' ' + e.LastName as 'Nombre completo del empleado'  
from Orders as o
inner join Customers as c
on o.CustomerID = c.CustomerID
inner join Employees as e
on o.EmployeeID = e.EmployeeID;
go

--Muestra el nombre de todos los productos (ProductName) y el nombre de su categoría (CategoryName),
--aunque el producto no tenga categoría asignada (es decir, que pueda salir NULL).
select * from Products;
select * from Categories;
go

select p.ProductName as 'Nombre de los productos',
c.CategoryName as 'Nombre de la categoria'
from Products as p
left join Categories as c
on p.CategoryID = c.CategoryID;
go

--Crea una vista llamada vista_stock_bajo que muestre el nombre del producto (ProductName), 
--las unidades en inventario (UnitsInStock) y el ID de la categoría (CategoryID), 
--solo para los productos con menos de 10 unidades en stock.
select * from Products;
select * from Categories;
go

create or alter view vista_stock_bajo
as
select p.ProductName as 'Nombre del producto',
p.UnitsInStock as 'Unidades en inventario',
p.CategoryID as 'Id de la categoria'
from Products as p
where UnitsInStock < 10;
go

select * from vista_stock_bajo;
go

--Crea un procedimiento llamado PedidosMesActual 
--que muestre todos los pedidos (Orders) realizados en el mes actual.

CREATE OR ALTER PROCEDURE PedidosMesActual
AS
BEGIN
    SELECT *
    FROM Orders
    WHERE MONTH(OrderDate) = MONTH(GETDATE())
      AND YEAR(OrderDate) = YEAR(GETDATE());
END;
GO

-- o en SQL Server:
EXEC PedidosMesActual;
go

CREATE OR ALTER PROCEDURE PedidosMesPrueba
AS
BEGIN
    SELECT *
    FROM Orders
    WHERE MONTH(OrderDate) = 4 AND YEAR(OrderDate) = 1997;
END;
GO

EXEC PedidosMesPrueba;
go
--Crea un procedimiento llamado ProductosPorProveedor que reciba un SupplierID como parámetro y muestre:
--ProductName
--UnitPrice
--UnitsInStock
--Solo para los productos que pertenezcan a ese proveedor.
select * from Products;
go


create or alter procedure productos_por_proveedor
@proveedor int
as
begin
	select p.ProductName as 'Nombre del producto',
		   p.UnitPrice as 'Precio unico',
		   p.UnitsInStock as 'Cantidad unica'
	from Products as p
	where SupplierID = @proveedor
end;
go

exec productos_por_proveedor '12';
go

--Crea un procedimiento llamado BuscarPedidosPorCliente que reciba como parámetro un CustomerID 
--y muestre los pedidos (Orders) que:
--Fueron hechos por ese cliente
--Y además tengan una fecha (OrderDate) posterior al 1 de enero de 1997
select * from Customers;
select * from Orders;
go

create or alter procedure Buscar_pedidos_por_cliente
@cliente nchar(50),
@fecha date
as
begin
	select c.CustomerID as 'Cliente',
	o.OrderDate as 'Fecha'
	from Customers as c
	inner join Orders as o
	on c.CustomerID = o.CustomerID
	where o.CustomerID = @cliente
		  and o.OrderDate > @fecha
end;
go

exec Buscar_pedidos_por_cliente 'ANATR', '1997-01-01';
go

/*CREATE OR ALTER PROCEDURE usp_InformeVentasPorEmpleado
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    BEGIN TRY
        -- Tabla temporal para calcular el total general de ventas
        DECLARE @TotalGeneralVentas MONEY;

        SELECT @TotalGeneralVentas = SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))
        FROM Orders o
        INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
        WHERE o.OrderDate BETWEEN @FechaInicio AND @FechaFin;

        -- Reporte por empleado
        SELECT 
            e.EmployeeID AS 'ID del empleado',
            e.FirstName + ' ' + e.LastName AS 'Nombre completo',
            COUNT(DISTINCT o.OrderID) AS 'Pedidos procesados',
            SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'Total ventas',
            CAST(
                (SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) * 100.0) / NULLIF(@TotalGeneralVentas, 0)
                AS DECIMAL(5,2)
            ) AS 'Porcentaje del total (%)'
        FROM Employees e
        INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
        INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
        WHERE o.OrderDate BETWEEN @FechaInicio AND @FechaFin
        GROUP BY e.EmployeeID, e.FirstName, e.LastName
        ORDER BY [Total ventas] DESC;
    
    END TRY
    BEGIN CATCH
        PRINT 'Ocurrió un error al generar el informe de ventas por empleado.';
    END CATCH
END;
GO */

--Crea un procedimiento llamado ClientesPorPais que:
--Reciba un parámetro: el nombre de un país (@pais)
--Devuelva el nombre de la empresa (CompanyName), contacto (ContactName) y ciudad (City)
--Solo de los clientes que pertenecen al país especificado
select * from Customers;
go

create or alter procedure clientes_por_pais
@pais nvarchar(15)
as
begin
	select c.Country as 'pais',
		   c.CompanyName as 'Nombre de la empresa',
		   c.ContactName as 'Contacto',
		   c.City as 'Ciudad'
	from Customers as c
	where c.Country = @pais
end;
go

exec clientes_por_pais 'Mexico';
go

--Crea un procedimiento llamado VerificarExistenciaCliente que:
--Reciba un parámetro: el ID de un cliente (@idCliente)
--Si el cliente existe en la tabla Customers, muestra su:
--CompanyName, ContactName, Country
--Si no existe, imprime un mensaje como: "Cliente no encontrado."

select * from Customers;
go

--exists -> haz algo si existe

create or alter procedure verificar_existencia_cliente
@idCliente nchar(5)
as
begin
if exists (select 1 from Customers where CustomerID = @idCliente)
begin
select c.CompanyName as 'Nombre del cliente',
	   c.ContactName as 'Contacto',
	   c.Country as 'Pais'
from Customers as c
where CustomerID = @idCliente;
end
else
begin
	 print 'El cliente no existe';
end
end;
go

execute verificar_existencia_cliente 'ALFKI';
go

--not exists -> haz algo si no existe

CREATE OR ALTER PROCEDURE verificar_cliente_no_existe
    @idCliente NCHAR(5)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @idCliente)
    BEGIN
        PRINT 'El cliente NO existe';
    END
    ELSE
    BEGIN
        SELECT CompanyName, Country FROM Customers WHERE CustomerID = @idCliente;
    END
END;
GO

EXEC verificar_cliente_no_existe 'ZZZZZ';  -- Cliente que no existe
EXEC verificar_cliente_no_existe 'ALFKI';  -- Cliente que sí existe
go

--Crea un procedimiento llamado VerificarClienteYPedidos que:
--Reciba un parámetro: @idCliente (NCHAR(5))
--Si el cliente no existe, imprime: "El cliente no existe."
--Si el cliente sí existe pero no tiene pedidos, imprime: "El cliente no tiene pedidos."
--Si el cliente existe y tiene pedidos, muestra:
--OrderID, OrderDate, ShipCountry (de la tabla Orders)
select CustomerID from Customers;
select * from Orders;
go

--Con ambos -> exists y not exists

create or alter procedure verificar_clientes_y_pedidos
@idCliente nchar(10)
as
begin
	 if not exists (select 1
					from Customers
					where CustomerID = @idCliente)
	begin
		print 'el cliente no existe';
	end
	else
	begin
		if not exists (select 1
					from Orders
					where CustomerID = @idCliente)
	begin
		print 'El cliente si existe pero no tiene pedidos';
	end
	else
	begin
		 select o.OrderID as 'Numero del Pedido',
		        o.OrderDate as 'Fecha del pedido',
				o.ShipCountry as 'Pais de envio'
		 from Orders as o
		 where CustomerID = @idCliente
		 end
	end
end;
go

execute verificar_clientes_y_pedidos 'PARIS';
go

CREATE OR ALTER PROCEDURE verificar_clientes_y_pedidos
    @idCliente NCHAR(10)
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM Customers
        WHERE CustomerID = @idCliente
    )
    BEGIN
        PRINT 'El cliente no existe';
    END
    ELSE
    BEGIN
        IF NOT EXISTS (
            SELECT 1
            FROM Orders
            WHERE CustomerID = @idCliente
        )
        BEGIN
            PRINT 'El cliente sí existe pero no tiene pedidos';
        END
        ELSE
        BEGIN
            SELECT o.OrderID AS 'Numero del Pedido',
                   o.OrderDate AS 'Fecha del pedido',
                   o.ShipCountry AS 'Pais de envio'
            FROM Orders AS o
            WHERE o.CustomerID = @idCliente;
        END
    END
END;
GO

EXEC verificar_clientes_y_pedidos 'PARIS';
GO
