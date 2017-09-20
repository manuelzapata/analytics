
#StudentID as the name of the row.
grades <- read.csv("studentgrades.csv", row.names = "StudentID", stringsAsFactors = FALSE)
print(grades)

#Structure of the data frame.
str(grades)

#Download a remote file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "uscommunities.csv")