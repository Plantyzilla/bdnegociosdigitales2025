# *Practica 3. Updates y Deletes*

1. Cambiar el salario del empleado Imogene Nolan. Se le asigna 8000.
```json
db.empleados.updateOne(
    {
        nombre: 'Imogene',
        apellidos: 'Nolan'
    },
    {
        $set: {salario: 8000}
    }
)
```

![Respuesta](../img/P3%20paso1.png)

2. Cambiar "Belgium" por "Bélgica" en los empleados (debe haber dos).
```json
db.empleados.updateMany(
    {
        pais: 'Belgium'
    },
    {
        $set: {pais: 'Bélgica'}
    }
)
```
![Respuesta](../img/P3%20paso2.png)


3. Reemplazar el empleado Omar Gentry por el siguiente documento:

json
{
"nombre": "Omar",
"apellidos": "Gentry",
"correo": "sin correo",
"direccion": "Sin calle",
"region": "Sin region",
"pais": "Sin pais",
"empresa": "Sin empresa",
"ventas": 0,
"salario": 0,
"departamentos": "Este empleado ha sido anulado"
}

```json
db.empleados.replaceOne(
{
    nombre: 'Omar'
},
{
"nombre": "Omar",
"apellidos": "Gentry",
"correo": "sin correo",
"direccion": "Sin calle",
"region": "Sin region",
"pais": "Sin pais",
"empresa": "Sin empresa",
"ventas": 0,
"salario": 0,
"departamentos": "Este empleado ha sido anulado"
}
)
```
![Respuesta](../img/P3%20paso3.png)

4. Con un find comprobar que el empleado ha sido modificado

```json
db.empleados.find({nombre: 'Omar'})
```
![Respuesta](../img/P3%20paso4.png)

5. Borrar todos los empleados que ganen mas de 8500. Nota: deben ser borrados 3 documentos
```json
db.empleados.deleteMany({salario: {$gt: 8500}})
```
![Respuesta](../img/P3%20paso5.png)

6. Visualizar con una expresión regular todos los empleados con apellidos que comiencen con "R"
```json
db.empleados.find({apellidos: {$regex: /^R/i}})
```
![Respuesta](../img/P3%20paso6.png)

7. Buscar todas las regiones que contenga un "V". Hacerlo con el operador $regex y que no distinga mayúsculas y minúsculas. Deben salir 2.
```json
db.empleados.find({region: {$regex: /V/i}})
```
![Respuesta](../img/P3%20paso7.png)

8. Visualizar los apellidos de los empleados ordenados por el propio apellido.
```json
db.empleados.find({},{apellidos:1}).sort({apellido: 1})
```
![Respuesta](../img/P3%20paso8.png)

9. Indicar el número de empleados que trabajan en Google.
```json
db.empleados.find({empresa: 'Google'}).size()
```
![Respuesta](../img/P3%20paso9.png)

10. Borrar la colección empleados y la base de datos
```json
db.empleados.drop()
db.dropDatabase()
```
![Respuesta](../img/P3%20paso10.png)