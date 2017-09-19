##Ejemplo de un script R. Análisis estadístico simple de las edades y pesos de unas personas
#Creación de un vector para almacenar las edades
age <- c(1,3,5,2,11,9,3,9,12,3)
#Creación de un vector para almacenar los pesos
weight <- c(4.4,5.3,7.2,5.2,8.5,7.3,6.0,10.4,10.2,6.1)
#Cálculo del promedio del peso
mean(weight)
#Cálculo de la desviación estándar del peso
sd(weight)
#Gráfico para presentar la relación entre las edades y el peso
plot(age,weight)
print("Ejecución exitosa del script")

