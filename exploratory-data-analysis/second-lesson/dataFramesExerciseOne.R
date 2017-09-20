
name <- c("Alex", "Lilly", "Mark", "Oliver", "Martha", "Lucas", "Caroline")
age <- c(25, 31, 23, 52, 76, 49, 26)
height <- c(177, 163, 190, 179, 163, 183, 164)
weight <- c(57, 69, 83, 75, 70, 83, 53)
sex <- factor(c("F", "F", "M", "M", "F", "M", "F"))

people <- data.frame(row.names = name, age, height, weight, sex, stringsAsFactors = FALSE)
print(people)

#change order of the level for the factor "sex". This will endup changing the F to M and viceversa
levels(people$sex) <- c("M", "F")

print(people)