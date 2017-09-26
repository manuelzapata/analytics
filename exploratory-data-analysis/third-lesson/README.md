# Ejercicio Limpieza de datos Clase No. 5

## ¿Cuáles son las dimensiones de la base de datos?

Hay 12519 filas (observaciones) y 114 columnas (variables)

```R
dim(originalDataset)
```

## Elimine las siguientes columnas: 10 a la 17, y de la 33 a la 75.

```R
dataset <- originalDataset[-10:-17]
dataset <- dataset[-33:-75]
```

## Verifique las clases de las variables

```R
sapply(dataset, class)
table(sapply(dataset, class))
```

```text
            ESTU_CONSECUTIVO                      PERIODO          ESTU_TIPO_DOCUMENTO 
                    "factor"                    "integer"                     "factor" 
            ESTU_PAIS_RESIDE                  ESTU_GENERO          ESTU_NACIMIENTO_DIA 
                    "factor"                     "factor"                    "integer" 
         ESTU_NACIMIENTO_MES         ESTU_NACIMIENTO_ANNO                    ESTU_EDAD 
                   "integer"                    "integer"                    "integer" 
       ESTU_COD_RESIDE_MCPIO            ESTU_RESIDE_MCPIO            ESTU_RESIDE_DEPTO 
                   "integer"                     "factor"                     "factor" 
            ESTU_ZONA_RESIDE             ESTU_AREA_RESIDE        IND_COD_ICFES_TERMINO 
                   "integer"                    "integer"                    "integer" 
              COLE_COD_ICFES    COLE_COD_DANE_INSTITUCION             COLE_NOMBRE_SEDE 
                   "integer"                    "numeric"                     "factor" 
             COLE_CALENDARIO                  COLE_GENERO              COLE_NATURALEZA 
                    "factor"                     "factor"                     "factor" 
               COLE_BILINGUE                 COLE_JORNADA                COLE_CARACTER 
                   "integer"                     "factor"                     "factor" 
          COLE_VALOR_PENSION            ESTU_VECES_ESTADO        ESTU_CARRDESEADA_TIPO 
                   "integer"                    "integer"                    "integer" 
        ESTU_IES_COD_DESEADA    ESTU_IES_COD_MPIO_DESEADA        ESTU_IES_DEPT_DESEADA 
                   "integer"                    "integer"                     "factor" 
     ESTU_IES_DESEADA_NOMBRE        ESTU_IES_MPIO_DESEADA            FAMI_NIVEL_SISBEN 
                    "factor"                     "factor"                    "integer" 
         FAMI_PERSONAS_HOGAR           FAMI_CUARTOS_HOGAR              FAMI_PISOSHOGAR 
                   "integer"                    "integer"                    "integer" 
          FAMI_TELEFONO_FIJO                 FAMI_CELULAR                FAMI_INTERNET 
                   "integer"                    "integer"                    "integer" 
    FAMI_SERVICIO_TELEVISION              FAMI_COMPUTADOR                FAMI_LAVADORA 
                   "integer"                    "integer"                    "integer" 
                 FAMI_NEVERA                   FAMI_HORNO                     FAMI_DVD 
                   "integer"                    "integer"                    "integer" 
             FAMI_MICROONDAS               FAMI_AUTOMOVIL FAMI_INGRESO_FMILIAR_MENSUAL 
                   "integer"                    "integer"                    "integer" 
                ESTU_TRABAJA           ESTU_HORAS_TRABAJA                PUNT_LENGUAJE 
                   "integer"                    "integer"                    "integer" 
            PUNT_MATEMATICAS              PUNT_C_SOCIALES               PUNT_FILOSOFIA 
                   "integer"                    "integer"                    "integer" 
               PUNT_BIOLOGIA                 PUNT_QUIMICA                  PUNT_FISICA 
                   "integer"                    "integer"                    "integer" 
                 PUNT_INGLES                DESEMP_INGLES         NOMBRE_COMP_FLEXIBLE 
                   "integer"                     "factor"                     "factor" 
          PUNT_COMP_FLEXIBLE         DESEMP_COMP_FLEXIBLE                  ESTU_PUESTO 
                   "integer"                     "factor"                    "integer" 
```

```text
 factor integer numeric 
     18      44       1 
```

## Construya la variable fecha de nacimiento.

```R
dataset$FECHA_NACIMIENTO <- paste(dataset$ESTU_NACIMIENTO_DIA, dataset$ESTU_NACIMIENTO_MES, dataset$ESTU_NACIMIENTO_ANNO, sep = "-")
dataset$FECHA_NACIMIENTO <- as.Date(dataset$FECHA_NACIMIENTO, format = "%d-%m-%Y")
```

## ¿Corresponde la edad suministrada a la edad del individuo calculada, tomando la fecha en que se realizó el examen (15 de abril de 2012) y la fecha de nacimiento?

Como se puede observar en los estadisticas de la variable DIF_EDAD, no todos los valores de edad coinciden.

```R
fechaExamen <- as.Date("2012-04-15", format = "%Y-%m-%d")
dataset$EDAD_CALCULADA <- round((difftime(fechaExamen, dataset$FECHA_NACIMIENTO, units = "weeks") / 52.25), 2)
dataset$DIF_EDAD <- as.numeric(dataset$EDAD_CALCULADA - dataset$ESTU_EDAD)
summary(dataset$DIF_EDAD)
```

```text
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.     NA's 
-11.7000   0.3700   0.6100   0.6376   0.8700  35.2400       83 
```
## Si la diferencia entre las edades esta entre -1 y 1 año, no hay problema. Si la diferencia no está en ese intervalo cree una variable que se llame problema edad y que tome dos valores: “Sí” y “No”. “Sí” si sí está en el intervalo, 0 en caso contrario. ¿Cuántas observaciones tienen ese problema?

Existen 1474 observaciones donde la edad no es consistente con la fecha de nacimiento.

```R
dataset$PROBLEMA_EDAD <- ifelse(dataset$DIF_EDAD < -1 | dataset$DIF_EDAD > 1, "Si", "No")
table(dataset$PROBLEMA_EDAD)
```

```text
   No    Si 
10962  1474 
```

## Elimine la opción NA de las variables que son factor

## ¿Cuántos valores perdidos hay en total?