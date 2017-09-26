#Hay un error en la linea 139, donde el numero de elementos no coincide. Por eso se usa el parametro "fill"
dataset <- read.table("SB1120121.txt", sep = "|", fill = TRUE, header = TRUE)

#1. Obtener dimensiones de la base de datos.

dim(dataset)

#2. Elimine las siguientes columnas: 10 a la 17, y de la 33 a la 75.

dataset2 <- dataset[-10:-17]
