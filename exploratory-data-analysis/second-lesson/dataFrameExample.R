
patientIDs = c(1:4)
ages = c(25, 34, 28, 52)
diabetes = factor(c("Type1","Type2","Type1","Type1"))
statuses = factor(c("Poor", "Improved", "Excellent", "Poor"))

#By default, the column names will be the same as the variable names
patientData = data.frame(patientIDs, ages, diabetes, statuses)
#colnames(dataFrame) <- c("patientID", "age", "diabetes", "status")

print(patientData)

#get columns 1 and 2
print(patientData[1:2])

#get columns by name
print(patientData[c("diabetes", "statuses")])

#get column named "age"
print(patientData$age)

#cross tabulation. This is similar to a pivot table in Excel.
table(patientData$diabetes, patientData$statuses)
