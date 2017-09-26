#Hay un error en la linea 139, donde el numero de elementos no coincide. Por eso se usa el parametro "fill"
originalDataset <- read.table("SB1120121.txt", sep = "|", fill = TRUE, header = TRUE)

#1. Obtener dimensiones de la base de datos.

dim(originalDataset)

#2. Elimine las siguientes columnas: 10 a la 17, y de la 33 a la 75.

dataset <- originalDataset[-10:-17]
dataset <- dataset[-33:-75]

#3. Verifique las clases de las variables
sapply(dataset, class)
table(sapply(dataset, class))

#4. Construya la variable fecha de nacimiento.
dataset$FECHA_NACIMIENTO <- paste(dataset$ESTU_NACIMIENTO_DIA, dataset$ESTU_NACIMIENTO_MES, dataset$ESTU_NACIMIENTO_ANNO, sep = "-")
dataset$FECHA_NACIMIENTO <- as.Date(dataset$FECHA_NACIMIENTO, format = "%d-%m-%Y")

#5. ¿Corresponde la edad suministrada a la edad del individuo calculada, 
# tomando la fecha en que se realizó el examen (15 de abril de 2012) y la fecha de nacimiento?

fechaExamen <- as.Date("2012-04-15", format = "%Y-%m-%d")
dataset$EDAD_CALCULADA <- round((difftime(fechaExamen, dataset$FECHA_NACIMIENTO, units = "weeks") / 52.25), 2)
dataset$DIF_EDAD <- as.numeric(dataset$EDAD_CALCULADA - dataset$ESTU_EDAD)
summary(dataset$DIF_EDAD)

#6. Si la diferencia entre las edades esta entre -1 y 1 año, no hay problema. 
# Si la diferencia no está en ese intervalo cree una variable que se llame problema edad 
# y que tome dos valores: “Sí” y “No”. “Sí” si sí está en el intervalo, 0 en caso contrario. 
# ¿Cuántas observaciones tienen ese problema?

dataset$PROBLEMA_EDAD <- ifelse(dataset$DIF_EDAD < -1 | dataset$DIF_EDAD > 1, "Si", "No")
table(dataset$PROBLEMA_EDAD)

#7. Elimine la opción NA de las variables que son factor

#Funcion para falicitar la eliminacion de NA
removerFactorNA <- function(dataset, nombreVariable){
  isNALevel <- levels(dataset[,nombreVariable]) != ""
  newLevels <- levels(dataset[,nombreVariable])[isNALevel]
  
  #recreate factor
  dataset[,nombreVariable] <- factor(dataset[,nombreVariable], levels = newLevels)
  return (dataset)
}
dataset <- removerFactorNA(dataset, "ESTU_PAIS_RESIDE")
dataset <- removerFactorNA(dataset, "ESTU_GENERO")
dataset <- removerFactorNA(dataset, "ESTU_RESIDE_MCPIO")
dataset <- removerFactorNA(dataset, "ESTU_RESIDE_DEPTO")
dataset <- removerFactorNA(dataset, "COLE_CALENDARIO")
dataset <- removerFactorNA(dataset, "COLE_GENERO")
dataset <- removerFactorNA(dataset, "COLE_NATURALEZA")
dataset <- removerFactorNA(dataset, "COLE_JORNADA")
dataset <- removerFactorNA(dataset, "COLE_CARACTER")
dataset <- removerFactorNA(dataset, "ESTU_IES_MPIO_DESEADA")
dataset <- removerFactorNA(dataset, "ESTU_IES_DEPT_DESEADA")
dataset <- removerFactorNA(dataset, "DESEMP_INGLES")

#8. ¿Cuántos valores perdidos hay en total?

table(is.na(dataset))
