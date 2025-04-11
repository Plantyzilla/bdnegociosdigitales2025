#  Practica de Transact, funciones y cadenas
## Por: Yael Tolentino Osornio
## Ejercicios:

```sql
use Northwind;
--Funciones de cadena

--Las funciones de cadena permiten manipular tipos de datos 
--como varchart, nvarchart, chart, nchart

--Funcion Len -> devuleve la longitud de una cadena

--Declaracion de una variable

declare @numero int;
set @numero = 10;
print @Texto + @numero
go
--Obtener el tamaño de la cadena almacenada en la variable Texto

declare @Texto varchar(50) = 'Hola, mundo!';

--Funcion left -> Extrae un numero espefico desde el inicio de la cadenas
select left(@Texto, 4) as Inicio

--Obtener el tamaño de la cadena almacenada en la variable Texto
select len(@Texto) as [Longitud]

--Left -> Extrae un determinado numero de caracteres desde el incio de la cadena
select companyname, len(CompanyName) from Customers
go

--substring -> Extrae una parte de la cadena

declare @Texto2 varchar(50) = 'Hola, mundo!';

--substring
select SUBSTRING(@Texto2, 7,5)
go

--replace -> Remplaza una subcadena por otra
declare @Texto2 varchar(50) = 'Hola, mundo!';
select REPLACE(@Texto2, 'Mundo', 'Amigo');
go

--CharIndex
declare @Texto2 varchar(50) = 'Hola, mundo!';
select CHARINDEX('Mundo', @Texto2)
go

declare @Texto2 varchar(50) = 'Hola, mundo!';
select upper(@Texto2) as Mayusculas;
go

declare @Texto2 varchar(50) = 'Hola, mundo!';

select concat(
			  left(@texto2, 5),
			  upper(SUBSTRING(@Texto2, 7,5)),
			  RIGHT(@texto2, 1)
		      ) as [Texto nuevo];

Update Customers
set CompanyName = Upper(CompanyName)
where country in ('Mexico', 'Germany')
go

select * from Customers
go
create or alter proc spu_informe_ventas_clientes
--Parametros
@nombre nvarchar(40) = 'Berglunds snabbköp', --Parametro de entrada con valor por default
@fechaInicial DateTime,
@fechaFinal DateTime
as
begin 
select [Nombre del Producto], [Nombre del Cliente], sum(Importe) as [Monto total]
from vistaOrdenesCompra
where [Nombre del Cliente] = @nombre
and [Fecha de Orden] between @fechaInicial and @fechaFinal
group by [Nombre del Producto], [Nombre del Cliente];
end;
go

--Ejecusion de un store por parametros de entrada
exec spu_informe_ventas_clientes 
								'Berglunds snabbköp',
								'1996-07-04', '1997-01-01';
go

--Ejecusion de un store prosedure con parametros en diferente posición
exec spu_informe_ventas_clientes @fechaFinal = '1997-01-01',
								 @nombre = 'Berglunds snabbköp',
								 @fechaInicial = '1996-07-04';
go

--Ejecusion de un store prosedure con parametros de entrada
--con un campo que tiene un valor por default
exec spu_informe_ventas_clientes @FechaInicial = '1996-07-04',
								 @FechaFinal = '1997-01-01';
go
										 
--Store procedure con parametros de salida
create or alter proc spu_obtener_numero_clientes
@customerid nchar(5), -- Parametro de entrada
@totalCustomers int output -- Parametro de salida
as
begin
	select @totalCustomers= count(*) from Customers
	where CustomerID = @customerid;
end;
go

declare @numero int;
exec spu_obtener_numero_clientes @customerid = 'ANATR',
								 @totalCustomers= @numero output;
print @numero;
go

-- crear un store procedure que permita saber si un alumno aprovo o reprobo

create or alter proc spu_comparar_calificasion
@calif decimal(10,2)-- Parametro de entrada
as
begin
	 if @calif>=0 and @calif<=10
	 begin
			if @calif>=8
			print 'La calificasion es aprovatoria'
			else
			print 'La calificasion es reprovatoria'
	 end
	 else
	     print 'Calificasion no valida'
end;
go

exec spu_comparar_calificasion @calif = 11;
go

--Crear un sp que permita verificar si un cliente existe antes de 
--devolver su informacion

create or alter proc spu_obtener_cliente_si_existe
@numeroCliente nchar(5)
as
begin
		if exists (select 1 from Customers where CustomerID = @numeroCliente)
		select * from Customers where CustomerID = @numeroCliente;
	else
		print 'El cliente no existe'
end;
go

exec spu_obtener_cliente_si_existe @numeroCliente= 'Alondra';
go
```