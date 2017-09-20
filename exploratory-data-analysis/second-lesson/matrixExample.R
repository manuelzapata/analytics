#create a matrix
y <- matrix(1:20, nrow = 5, ncol = 4)
print(y)

#assign names to the rows
row.names(y) <- c("R1", "R2", "R3", "R4", "R5")

#assign names to the columns
colnames(y) <- c("C1", "C2", "C3", "C4")

#Assign row and column names using the matrix function
myMatrix = matrix(1:10, nrow=2, ncol = 5, dimnames = list(c("R1", "R2"), c("C1", "C2", "C3", "C4", "C5")))

#get a row.
print(myMatrix[2,])

#get a single value
print(myMatrix[1,5])

#get a column
print(myMatrix[,3])
