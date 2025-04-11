use Northwind;
--1. Mostrar el total de ventas por
--categoria de producto ordenado de mayor a menor
--y poner el nombre de la categoria
select * from Products;
select * from Categories;
go

select c.CategoryName as 'Nombre de la categoria',
sum(p.UnitPrice) as 'Venta total'
from Products as p
inner join Categories as c
on c.CategoryID = p.CategoryID
group by c.CategoryName
order by sum(p.UnitPrice) desc;
go

--2. Mostrar todos los pedidos realisados
--del 01 de enero 1997 al 31 de marzo de 1997
--mostrando el nombre del cliente y la orden de la compra
select * from Customers;
select * from Orders;
go

select o.OrderDate as 'Fecha del pedido',
c.CompanyName as 'Nombre del cliente',
o.ShipName as 'Orden'
from Orders as o
inner join Customers as c
on o.CustomerID = c.CustomerID
where o.OrderDate between '1997-01-01' and '1997-03-31';
go

--3. Seleccionar el nombre y pais de los clientes que son de estados unidos
--alemania o brazil
select * from Orders;
select * from Customers;
go

select o.ShipCountry as 'País',
c.CompanyName as 'Clientes'
from Orders as o
inner join Customers as c
on o.CustomerID = c.CustomerID
where o.ShipCountry in ('Usa', 'Brazil', 'Germany');
go
--4. Mostrar el ID del empleado el nombre del cliente como full name
--el total de pedidos que han realisado de los empleados que solo han gesteonado mas de 100
--pedidos
select * from Employees;
select * from Customers;
select * from Orders;
go

select e.EmployeeID as 'ID del Empleado',
e.FirstName + ' ' + e.LastName as 'Nombre Completo',
count(o.OrderID) as 'Total de Pedidos'
from Orders as o
inner join Employees as e 
on o.EmployeeID = e.EmployeeID
group by e.EmployeeID, e.FirstName, e.LastName
having count(o.OrderID) > 100;
go
--5. Mostar los primeros 10 productos con descuento aplicado 
--mostra el nombre del peroducto precio unitario, el descunto la cantidad, precio final
select * from Products;
select * from [Order Details];
go

select top 10 p.ProductName, 
p.UnitPrice, 
od.Discount, 
p.UnitsInStock, 
sum((p.UnitPrice * od.Quantity) - (1 - od.Discount)) as 'Precio final' 
from Products as p 
join [Order Details] as od 
on p.ProductID = od.ProductID
group by p.ProductName, p.UnitPrice, od.Discount, p.UnitsInStock
go

--6. Crear una vista que muestre los pedidos con informacion del cliente, empleado y total del pedido incluyendo el descuento
--Mostrar el numero del orden, nombre del cliente, full name del empleado, la fecha de la orden y el total del pedido
--Nombre de la vista Pedidos_detalle
select * from Orders;
select * from Customers;
select * from Employees;
select * from [Order Details];
go

create or alter view Pedidos_detalle 
as
select 
o.OrderID as 'Número de Orden',
c.CompanyName as 'Cliente',
e.FirstName + ' ' + e.LastName as 'Empleado',
o.OrderDate as 'Fecha de Orden',
sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as 'Total del Pedido'
from Orders as o
inner join Customers as c 
on o.CustomerID = c.CustomerID
inner join Employees as e 
on o.EmployeeID = e.EmployeeID
inner join [Order Details] as od 
on o.OrderID = od.OrderID
group by o.OrderID, 
c.CompanyName, 
e.FirstName, 
e.LastName, 
o.OrderDate;
go

select * from Pedidos_detalle;
go
--7. Realisar un store procedure que resiva un id del cliente una fecha del orden y una fecha requerida y registre un nuevo pedido en la tabla orders
--utilisar un try cache para capturar errores ademas utilisar un if para validar que la tabla cliente exista
--Nombre del store: spu_insertar_pedido

create or alter procedure spu_insertar_pedido
@idCliente nchar(5),
@fechaOrden date,
@fechaRequerida date
as
begin
    begin try
        if exists (select 1 from Customers where CustomerID = @idCliente)
        BEGIN
            insert into Orders (CustomerID, 
			OrderDate, RequiredDate)
            values (@idCliente, 
			@fechaOrden, 
			@fechaRequerida);

            print 'Pedido insertado correctamente.';
        end
        else
        begin
            print 'El cliente no existe. No se puede insertar el pedido.';
        end
    end try
    begin catch
        print 'Ocurrió un error al intentar insertar el pedido.';
    end catch
end;
go

exec spu_insertar_pedido 'ALFKI', '1997-08-01', '1997-08-15';
go
