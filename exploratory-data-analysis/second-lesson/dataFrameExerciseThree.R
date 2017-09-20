age = c(45:41, 30:33)

class = rep(c("A", "B", "C"), times = 3)

grade = round(rnorm(9, 65, 5))

dataFrame = data.frame(age, class, grade, stringsAsFactors = FALSE)

print(dataFrame)
#order the df by the age column
dataFrame = dataFrame[order(dataFrame$age),]
print(dataFrame)

