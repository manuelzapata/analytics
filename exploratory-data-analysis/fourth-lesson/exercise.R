
#Cargar data sets limpios
load("sb20121.rdata")
load("sb20122.rdata")

str(sb20121)

#Unir los dos dataframes
sb2012 <- rbind(sb20121, sb20122)

#Cargar y ajustar dataset de colegios de Quibdo
quibdo <- read.csv("Sedes_quibdo.csv")
#Remover columnas
quibdo <- quibdo[,-c(1:3, 6:7, 11:12, 14:16)]
#Filtrar estados
levels(quibdo$Estado.Sede)
quibdo <- quibdo[quibdo$Estado.Sede != "CIERRE DEFINITIVO" & quibdo$Estado.Sede != "CIERRE TEMPORAL",]
quibdo <- droplevels(quibdo)
#Eliminar variable Estado.Sede
quibdo$Estado.Sede <- NULL

#Combinar ambos datasets - Left outer join
quibdo_estudiantes <- merge(quibdo, sb2012, by.x = "Codigo.Sede", by.y = "COLE_COD_DANE_INSTITUCION", 
                            all.x = TRUE, all.y = FALSE)

#Cuantos colegios no tienen estudiantes que hayan presentado el examen
table(is.na(quibdo_estudiantes$ESTU_CONSECUTIVO))

#Remover colegios sin estudiantes
quibdo_estudiantes <- quibdo_estudiantes[!is.na(quibdo_estudiantes$ESTU_CONSECUTIVO),]

#estadisticas variables cuantitativas
summary(quibdo_estudiantes)
install.packages("Hmisc")
library(Hmisc)
describe(quibdo_estudiantes)

#estadisticas variables cualitativas
table(quibdo_estudiantes$Zona)
prop.table(table(quibdo_estudiantes$Zona))

#moda
moda <- function(v) { 
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))] 
}
moda(quibdo_estudiantes$Nombre.Sede)

#Estadisticas agregadas por sede
#Quitar notacion cientifica en numeros
options(scipen = 999)
install.packages("plyr")
library(plyr)
quibdo_sedes<-ddply(quibdo_estudiantes, c("C.Sede"), summarise,
                    N    = length(PUNT_MATEMATICAS),
                    meanmath = round(mean(PUNT_MATEMATICAS, na.rm = T),2), 
                    meanleng = round(mean(PUNT_LENGUAJE, na.rm = T),2),
                    meaningles= round(mean(PUNT_INGLES, na.rm = T),2),
                    sdmath = round(sd(PUNT_MATEMATICAS, na.rm = T),2), 
                    sdleng = round(sd(PUNT_LENGUAJE, na.rm = T),2),
                    sdingles= round(sd(PUNT_INGLES, na.rm = T),2),
                    estu_edad=round(mean(ESTU_EDAD, na.rm = T),2))

estu_mujer=count(quibdo_estudiantes[quibdo_estudiantes$ESTU_GENERO=="F",], c("Codigo.Sede","ESTU_GENERO"))
colnames(estu_mujer)<-c("Codigo.Sede","Genero","N.mujer")
#Combinar quibdo sedes y estu_mujer
quibdo_sedes<-merge(quibdo_sedes,estu_mujer[,c(1,3)],by="Codigo.Sede",all.x=TRUE)
#Calcular el porcentaje de mujeres por institucion
quibdo_sedes$per_mujer<-round((quibdo_sedes$N.mujer/quibdo_sedes$N)*100,0)

#obtener un subconjunto de la base de datos de quibdo estudiantes que contenga solamente la informacion de las instituciones educativas y combinarla con la base de datos de quibdo_sedes
info_sedes<-unique(subset(quibdo_estudiantes, select=c(1,4,5,20:22,24)))
info_sedes<-info_sedes[info_sedes$COLE_CALENDARIO!="F",]
quibdo_sedes<-merge(quibdo_sedes,info_sedes,by="Codigo.Sede",all.x=TRUE)

head(quibdo_sedes)

#Graficas estadisticas descriptivas

#Histogramas
hist(quibdo_sedes$meanmath,main="Histograma promedio matematicas",col.main="green",font.main=2,
     xlab="Promedio matematicas",ylab="Frecuencia")
hist(quibdo_sedes$meanleng,main="Histograma promedio lenguaje",col.main="green",font.main=2,
     xlab="Promedio lenguaje",ylab="Frecuencia")
hist(quibdo_sedes$meanleng,main="Histograma promedio ingles",col.main="green",font.main=2,
     xlab="Promedio ingles",ylab="Frecuencia")
hist(quibdo_sedes$estu_edad,main="Histograma edad",col.main="blue",font.main=2,
     xlab="edad",ylab="Frecuencia")


#Cajas de bigotes

boxplot(quibdo_sedes$meanmath,
        main='Caja de bigotes Promedio matematicas',
        ylab='Promedio matematicas')


boxplot(quibdo_sedes$meanleng,
        main='Caja de bigotes Promedio lenguaje',
        ylab='Promedio lenguaje')

boxplot(quibdo_sedes$meaningles,
        main='Caja de bigotes Promedio ingles',
        ylab='Promedio ingles')

boxplot(quibdo_sedes$estu_edad,
        main='Caja de bigotes Edad',
        ylab='Edad',
        ylim=c(10,40))

boxplot(quibdo_sedes$N,
        main='Caja de bigotes Numero de estudiantes',
        ylab='Num Estudiantes')


#Barplot

barplot(quibdo_sedes$N,
        main="Grafico de barras num. estudiantes",
        ylab = "Num. de estudiantes",
        xlab = "Institucion educativa")

barplot(quibdo_sedes$meanmath,
        main="Grafico de barras matematicas",
        ylab = "Puntaje promedio",
        xlab = "Institucion educativa")

barplot(quibdo_sedes$meanleng,
        main="Grafico de barras lenguaje",
        ylab = "Puntaje promedio",
        xlab = "Institucion educativa")

barplot(quibdo_sedes$meaningles,
        main="Grafico de barras ingles",
        ylab = "Puntaje promedio",
        xlab = "Institucion educativa")

#Valores atipicos (outliers)
outlierKD <- function(dt, var) {
  var_name <- eval(substitute(var),eval(dt))
  na1 <- sum(is.na(var_name))
  m1 <- mean(var_name, na.rm = T)
  outlier <- boxplot.stats(var_name)$out
  mo <- mean(outlier)
  var_name <- ifelse(var_name %in% outlier, NA, var_name)
  na2 <- sum(is.na(var_name))
  cat("Outliers identified:", na2 - na1, "n")
  cat("Proportion (%) of outliers:", round((na2 - na1) / sum(!is.na(var_name))*100, 1), "n")
  cat("Mean of the outliers:", round(mo, 2), "n")
  m2 <- mean(var_name, na.rm = T)
  cat("Mean without removing outliers:", round(m1, 2), "n")
  cat("Mean if we remove outliers:", round(m2, 2), "n")
}

outlierKD(quibdo_sedes, estu_edad)

#Identificar valores atipicos
qnt <- quantile(quibdo_sedes$estu_edad, probs=c(.25, .75), na.rm = T)
#Rango intercuantil
H <- 1.5 * IQR(quibdo_sedes$estu_edad, na.rm = T)
quibdo_sedes$atipicosedad <- ifelse(quibdo_sedes$estu_edad> qnt[2]+H | quibdo_sedes$estu_edad<qnt[1]-H ,1,0)


#Numero de valores atípicos del campo edad
table(quibdo_sedes$atipicosedad)
#Estudiemos las características de los individuos con edades atípicos
summary(quibdo_sedes$estu_edad[quibdo_sedes$atipicosedad==1])
#table(quibdo_sedes$estu_edad[quibdo_sedes$atipicosedad==1], quibdo_sedes$Zona[quibdo_sedes$atipicosedad==1])
#table(quibdo_sedes$estu_edad[quibdo_sedes$atipicosedad==1], quibdo_sedes$COLE_CALENDARIO[quibdo_sedes$atipicosedad==1])

#Correlacion entre variables numericas
cor(quibdo_sedes[,c(2:5,9)])

tabla <- table(quibdo_sedes$COLE_NATURALEZA, quibdo_sedes$COLE_CARACTER)
addmargins(tabla)

#Top 10 en lenguaje
top10Lenguaje <- quibdo_sedes[ order(-quibdo_sedes[,4]), ]
top10Lenguaje <- top10Lenguaje[c(1:10),]
top10Lenguaje <- droplevels(top10Lenguaje)
top10Lenguaje[,"Nombre.Sede"]
