# Practica 1: Base de Datos, colecciones e inserts

1. Conectarnos con mongosh a MongoDB

![Respuesta](../img/Paso%201%20Conectamos%20con%20mongosh%20a%20MongoDB.png)

2. Crear una base de datos llamada curso

![Respuesta](../img/Paso%202%20Crear%20base%20de%20datos%20llamada%20curso.png)

3. Comprobar que la base de datos no existe

![Respuesta](../img/Paso%203%20Conprobar%20que%20la%20base%20de%20datos%20no%20existe.png)

4. Crear una coleccion que se llame facturas y mostrarla

``` json
 db.createCollection('facturas')
 show collections
```
![Respuesta](../img/Paso%204%20Crear%20una%20collecion%20que%20se%20llame%20faturas%20y%20mostrarla.png)

5. Insertar un documento con los siguientes datos:

| Codigo   | Valor   |
|-------------|-------------|
| Cod_Factura | 10 |
| Ciente | Frutas Ramirez |
| Total | 223 |

| Codigo   | Valor   |
|-------------|-------------|
| Cod_Factura | 20 |
| Ciente | Ferreteria Juan |
| Total | 140 |

![Respuesta](../img/Paso%205%20Insertar%20un%20documento%20con%20los%20datos%20que%20pide%20la%20practica.png)

6. Crear una nueva colección pero usando directamente el insertOne.
   insertar un documento en la colección productos con los siguientes datos:

| Codigo   | Valor   |
|-------------|-------------|
| Cod_producto | 1 |
| Nombre | Tornillo x 1" |
| Precio | 2 |

![Respuesta](../img/Paso%206.png)


7. Crear un nuevo documento de producto que contenga un array. Con los siguientes datos:

| Codigo   | Valor   |
|-------------|-------------|
| Cod_producto | 2 |
| Nombre | Martillo |
| Precio | 20 |
| Unidades | 50 |
| Fabricantes | fab1, fab2, fab3,fab4 |

![Respuesta](../img/Paso%207.png)


8. Borrar la colección Facturas y comprobar que se borro

![Respuesta](../img/Paso%208.png)

9. Insertar un documento en una colección denominada **fabricantes**
   para probar los subdocumentos y la clave _id personalizada

| Codigo   | Valor   |
|-------------|-------------|
| id | 1 |
| Nombre | fab1 |
| Localidad | ciudad: buenos aires, pais: argentina, Calle: Calle pez 27,cod_postal:2900 |

![Respuesta](../img/Paso%209.png)

10. Realizar una inserción de varios documentos en a colección
    productos

| Codigo   | Valor   |
|-------------|-------------|
| Cod_producto | 3 |
| Nombre | Alicates |
| Precio | 10 |
| Unidades | 25 |
| Fabricantes | fab1, fab2, fab5 |

| Codigo   | Valor   |
|-------------|-------------|
| Cod_producto | 4 |
| Nombre | Arandela |
| Precio | 1 |
| Unidades | 500 |
| Fabricantes | fab2, fab3, fab4 |

![Respuesta](../img/Paso%2010.png)