bankData <- read.csv2("bank-full.csv")
#create frame handling NA values
bankDataTwo <- read.csv2("bank-full.csv", stringsAsFactors = FALSE, na.strings = c("NA", ""))

rowCount = nrow(bankData)
cat("Row count", rowCount)

columnCount = ncol(bankData)
cat("Col count", columnCount)

#Tip Install xlsx package in case we need to read an excel file.
#install.packages("xlsx")

#Read first rows
head(bankData, n = 10)

#Read the end of the file
tail(bankData, n = 5)

#Display 10 first rows and first 3 columns
bankData[1:10, 1:3]

#Change column names
names(bankData)[1] <- "age"
names(bankData)[14] <- "childcount"

str(bankData)
sapply(bankData, class)

#Create table with variable types
table(sapply(bankData, class))


#Change data types
bankData$job <- as.character(bankData$job)
#bankData$balance <- as.integer(bankData$balance)

nacimiento <- "1985-08-14"
class(nacimiento)
nacimiento <- as.Date(nacimiento, format = "%Y-%m-%d")
#get the difference in days
Sys.Date() - nacimiento

#difference in hours
difftime(Sys.Date(), nacimiento, units = "hours")


#lubridate package with utilies date manipulation
install.packages("lubridate")
library("lubridate")
#Create a single date attribute
bankData$fecha <- paste(bankData$year, bankData$month, bankData$day, sep = "-")
bankData$fecha <- as.Date(bankData$fecha, format = "%Y-%b-%d")
bankData$day <- day(bankData$fecha)
bankData$month <- month(bankData$fecha)
bankData$year <- year(bankData$fecha)

#find duplicated records
duplicated(bankData)
table(duplicated(bankData))

#remove duplicated rows. ! means the frame minus those duplicated records
bankData <- bankData[!duplicated(bankData),]

#check if there is missing data
is.na(bankData)
table(is.na(bankData))
#get total count per row
colSums(is.na(bankData))

#handle missing values in columns handled as factors
isNALevel = levels(bankData$job) != ""
newLevels = levels(bankData$job)[isNALevel]

#recreate factor
bankData$job = factor(bankData$job, levels = newLevels)

#Fix digitation errors

table(bankData$marital)
levels(bankData$marital)

library(stringr)

bankData$marital <- str_trim(bankData$marital)

table(bankData$housing)
bankData$housing <- tolower(bankData$housing)

table(bankData$default)
#Fix cases
bankData$default <- toupper(bankData$default)
bankData$default[bankData$default == "N"] <- "NO"

#pivot table to help us detect data inconsistencies
table(bankData$child, bankData$childcount, dnn = c("Has children?", "Number of children"))

bankData$childcount[bankData$child == "no" & bankData$childcount > 0] <- NA
table(bankData$child, bankData$childcount, dnn = c("Has children?", "Number of children"), useNA = "always")

#Fix values outside of the range
bankData$age[bankData$age < 18 | bankData$age > 95] <- NA
bankData$childcount[bankData$childcount > 4] <- NA

#New variables
bankData$dyf <- ifelse(bankData$default == "YES" & bankData$housing == "yes", "yes", "no")
table(bankData$dyf)

bankData$youngStudents <- ifelse(bankData$age < 25 & bankData$job == "student", "yes", "no")
table(bankData$youngStudents)

table(bankData$job[bankData$age < 25])

bankData$senior <- ifelse(bankData$age > 60 & bankData$job == "retired", "yes", "no")
table(bankData$senior)
