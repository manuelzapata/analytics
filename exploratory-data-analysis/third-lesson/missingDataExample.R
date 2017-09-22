
#Iris --> default frame in R, RStudio?
data(iris)
str(iris)

#Insert NA values
iris$Sepal.Length[1:10] <- NA
iris$Sepal.Width[40:50] <- NA
iris$Petal.Width[70:90] <- NA
summary(iris)

#Replace NA values with the mean
iris$Petal.Width[is.na(iris$Petal.Width)] <- mean(iris$Petal.Width, na.rm = TRUE)
summary(iris$Petal.Width)

