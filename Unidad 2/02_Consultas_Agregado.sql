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