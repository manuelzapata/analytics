dataFrame <- read.table("usedcars.csv")
#Fetch the first records.
head(dataFrame)

#Read as a CSV
#read.csv2 uses semicolon as a separator.
dataFrame <- read.csv("usedcars.csv")

#Get the last records
tail(dataFrame)
