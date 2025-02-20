select pr.Descripcion,pr.Precio,pr.Id_fab, p.Fab, pr.Id_producto, p.Producto
from pedidos as p 
inner join productos  as pr
on p.Fab = pr.Id_fab
and p.Producto = pr.Id_producto