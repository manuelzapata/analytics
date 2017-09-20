
name <- c("Alex", "Lilly", "Mark", "Oliver", "Martha", "Lucas", "Caroline")

age <- c(25, 31, 23, 52, 76, 49, 26)
height <- c(177, 163, 190, 179, 163, 183, 164)
weight <- c(57, 69, 83, 75, 70, 83, 53)
sex <- factor(c("F", "F", "M", "M", "F", "M", "F"))

people <- data.frame(row.names = name, age, height, weight, sex, stringsAsFactors = FALSE)

working <- c("Yes","No","No","Yes","Yes","No","Yes")

dataFrameTwo = data.frame(row.names = name, working, stringsAsFactors = FALSE)

#Combine the two dataframes in a single one.
combinedDataFrames = cbind(people, dataFrameTwo)
print(combinedDataFrames)

#Dimension of the df
print(dim(combinedDataFrames))

#number of rows
nrow(combinedDataFrames)

#number of columns
ncol(combinedDataFrames)

#get the type for each variable/column
sapply(combinedDataFrames, class)
