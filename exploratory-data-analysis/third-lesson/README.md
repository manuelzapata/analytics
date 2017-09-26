# Ejercicio Limpieza de datos Clase No. 5

1. ¿Cuáles son las dimensiones de la base de datos?

   Hay 12519 filas (observaciones) y 114 columnas (variables)

   ```R
   dim(originalDataset)
   ```

2. Elimine las siguientes columnas: 10 a la 17, y de la 33 a la 75.

   ```R
   dataset <- originalDataset[-10:-17]
   dataset <- dataset[-33:-75]
   ```

3. Verifique las clases de las variables

   ```R
   sapply(dataset, class)
   table(sapply(dataset, class))
   ```