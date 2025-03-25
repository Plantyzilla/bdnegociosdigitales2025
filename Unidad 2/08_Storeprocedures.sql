-- Store Procedure

-- Crear un store procedure para seleccionar todos los clientes

create or alter procedure spu_mostrar_clientes
AS
begin
   select * from Customers;
end;
GO

-- Ejecutar un store en transact

exec spu_mostrar_clientes


-- Crear un sp que muestre los clientes por pais
-- Parametros de entrada

Create or alter proc spu_customersporpais
-- Parametros
@pais nvarchar(15),
@pais2 nvarchar(15)
            -- Parametro de entrada 
AS
begin

    select * from customers
	where country in (@pais, @pais2);
end;
-- Fin del store



-- Ejecuta un store procedure
DEclare @p1 nvarchar(15) = 'mexico';
DEclare @p2 nvarchar(15) = 'germany';

exec spu_customersporpais @p1, @p2;
go

-- Generar un reporte que permita visualizar los datos de compra de un
-- determinado cliente, en un rango de fechas, mostrando, 
-- el monto total de compras por producto, mediante un sp.

use northwind;
GO

create or alter proc spu_informe_ventas_clientes
-- Parametros
@nombre nvarchar(40) = 'Berglunds snabbköp', -- Parametro de entrada con valor por default 
@fechaInicial DateTime, 
@fechaFinal Datetime
AS
begin
select [Nombre Producto],[Nombre del Cliente],  sum(importe) AS [Monto Total]
from vistaordenescompra
where [Nombre del Cliente] = @nombre 
and [Fecha de Orden] between @fechaInicial and @fechaFinal
group by [Nombre Producto], [Nombre del Cliente]
end;
GO


-- Ejecución de un store con parametros de entrada
exec spu_informe_ventas_clientes 
								'Berglunds snabbköp', 
								'1996-07-04', '1997-01-01'; 

-- Ejecución de un store procedure con parametros en diferente posición
exec spu_informe_ventas_clientes @fechaFinal = '1997-01-01', 
                                 @nombre = 'Berglunds snabbköp', 
								 @fechaInicial = '1996-07-04';

-- Ejecución de un store procedure con parametros de entrada con un 
-- campo que tiene un valor por default

exec spu_informe_ventas_clientes @fechaInicial ='1996-07-04', 
                                 @FechaFinal='1997-01-01' 
Go
-- Store procedure con parametros de salida

create or alter proc spu_obtener_numero_clientes
@customerid nchar(5), -- Parametro de entrada
@totalCustomers int output -- Parametro de salida
AS 
begin
    select @totalCustomers=count(*) from customers
	where CustomerID = @customerid;
end;
GO

declare @numero int;
exec spu_obtener_numero_clientes @customerid ='ANATR',
                                @totalCustomers = @numero output;
print @numero;
go

-- crear un store procedure que permita saber si un alumno aprobo o reprobo

create or alter proc spu_comparar_calificacion
@calif decimal(10,2) -- Parametro de entrada
AS
begin 
     if @calif>=0 and @calif<=10
	 begin
			if @calif>=8 
			print 'La calificación es aprobatoria'
			else
			print 'La calificación es reprobatoria'
	 end
	 else 
	    print 'Calificación no valida'
end;
go


exec spu_comparar_calificacion @calif = 5;
go
-- Crear un sp que permita verificar si un cliente existe antes de 
-- devolver su información

create or alter procedure spu_obtener_cliente_siexiste
@numeroCliente nchar(5)
AS
begin
     if exists (select 1 from Customers where CustomerID = @numeroCliente)
		select * from Customers where CustomerID = @numeroCliente;
	 else
	    print 'El cliente no existe'
end;
go

exec spu_obtener_cliente_siexiste @numeroCliente = 'Arout'

-- Crear un store procedure que permita insertar un cliente, 
-- pero se debe verificar primero que no exista



create or alter procedure spu_agregar_cliente 

   @id nchar(5), 
   @nombre nvarchar(40), 
   @city nvarchar(15) = 'San Miguel'
as
begin
     if exists (select 1 from Customers where CustomerID = @id)
	 begin
	     print ('El cliente ya existe')
	     return 1
	 end

	 insert into customers(customerid, companyname)
	 values(@id, @nombre);
	 print('Cliente insertado exitosamente');
	 return 0;

end;
go


exec spu_agregar_cliente 'AlFKI', 'Patito de Hule'
exec spu_agregar_cliente 'AlFKC', 'Patito de Hule'
go

create or alter procedure spu_agregar_cliente_try_catch
 @id nchar(5), 
 @nombre nvarchar(40), 
 @city nvarchar(15) = 'San Miguel'
 AS
 begin 
	begin try
	  insert into customers(customerid, companyname)
	  values(@id, @nombre);
	  print('Cliente insertado exitosamente');
	end try
	begin catch
		  print ('El cliente ya existe')
	end catch
 end;
 Go
 exec spu_agregar_cliente 'AlFKD', 'Muñeca Vieja'

 -- Manejo de ciclos en store procedures

 -- Imprimir el numero de veces que indique el usuario

 create or alter procedure spu_imprimir
 @numero int
 AS
 begin 

    if @numero<=0
	begin
	  print('El numero no puede ser 0 o negativo')
	  return
    end 

	declare @i int
	SET @i = 1
	while(@i<=@numero)
	begin 
	  print concat('Numero ' , @i)
	  set @i = @i + 1
	end

 end;
 GO
 exec spu_imprimir 0