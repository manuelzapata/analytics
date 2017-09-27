
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

#install.packages("xlsx")
#install.packages("rJava")
#library(rJava)
#library(xlsx)

