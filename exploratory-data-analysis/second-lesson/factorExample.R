diabetes <- c("Type1","Type2","Type1","Type1")

#create a factor
diabetesFactor = factor(diabetes)
print(diabetesFactor)

#create an ordinal factor
patientStatus = factor(c("Poor", "Improved", "Excellent"), ordered = TRUE)
print(patientStatus)

#Define the order for an ordinal factor.
yesNoFactor = factor(c("yes","yes","no","yes","no"), levels = c("yes", "no"))
print(yesNoFactor)