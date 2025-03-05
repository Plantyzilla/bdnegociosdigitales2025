use BDEJEMPLO2;
--Examen
--1.-
select * from Clientes
select * from Representantes

select rep.Num_Empl, rep.Nombre, c.Limite_Credito
from Clientes as c
inner join Representantes as rep
on rep.Num_Empl = c.Rep_Cli
where c.Limite_Credito > 5000

--2.-
select * from Pedidos
select * from Clientes

select pe.Num_Pedido, pe.Cantidad, pe.Importe, cl.Num_Cli, cl.Empresa
from Pedidos as pe
inner join Clientes as cl
on cl.Num_Cli = pe.Cliente
where pe.Cantidad >= 100 or pe.Importe >= 5000

--3.-
select * from Oficinas
select * from Representantes

select ofi.Region, ofi.Ciudad, rep.Nombre
from Oficinas as ofi
inner join Representantes as rep 
on ofi.Oficina = rep.Oficina_Rep
where ofi.Region = ('Este') or ofi.Region = ('Oeste')

--4.-
select * from Clientes
select * from Representantes
select * from Oficinas

select cl.Num_Cli, ofi.Ciudad, cl.Empresa, rep.Nombre
from Clientes as cl
inner join Representantes as rep
on rep.Num_Empl = cl.Rep_Cli
inner join Oficinas as ofi
on ofi.Oficina = rep.Oficina_Rep
where ofi.Ciudad in ('Navarra', 'Castellón', 'Daimiel')

--5.-
select * from Clientes
select * from Representantes

select cli.Limite_Credito, rep.Nombre, cli.Num_Cli 
from Clientes as cli
inner join Representantes as rep
on cli.Rep_Cli = rep.Num_Empl
where cli.Limite_Credito > 60000