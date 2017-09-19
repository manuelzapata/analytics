#Entendiendo la definición de sentencias
x <- 12
y <- 5
x+y

#help(package="base")
#help("median")
#demo()

miPrimeraFuncion <- function(numero)
{
  numero * numero
}

#install.packages("XML")

#import package
#library(XML)
sink("myOutput.txt")
pdf("myGraphs.pdf")
source("example-Rscript.R")
unlink("myGraphs.pdf")
dev.off()