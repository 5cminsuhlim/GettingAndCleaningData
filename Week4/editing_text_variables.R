## EDITING TEXT VARIABLES ##

if(!file.exists('./GettingAndCleaningData/Week4/data')){
        dir.create('./GettingAndCleaningData/Week4/data')
}

fileURL <- 'https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD'
download.file(fileURL, destfile = './GettingAndCleaningData/Week3/data/cameras.csv', method = 'curl')
cameraData <- read.csv('./GettingAndCleaningData/Week3/data/cameras.csv')
names(cameraData)
tolower(names(cameraData))


## fixing character vectors w/ strsplit
splitNames <- strsplit(names(cameraData), '\\.') ## split at period
splitNames[[6]] 
splitNames[[6]][1]

firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)


if(!file.exists('./GettingAndCleaningData/Week3/data')){
        dir.create('./GettingAndCleaningData/Week3/data')
}

fileURL1 <- 'https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv'
fileURL2 <- 'https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv'
download.file(fileURL1, destfile = './GettingAndCleaningData/Week3/data/reviews.csv', method = 'curl')
download.file(fileURL1, destfile = './GettingAndCleaningData/Week3/data/solutions.csv', method = 'curl')

reviews <- read.csv('./GettingAndCleaningData/Week3/data/reviews.csv')
solutions <- read.csv('./GettingAndCleaningData/Week3/data/solutions.csv')

head(reviews, 2)
head(solutions, 2)

names(reviews)
names(solutions)


## fixing character vectors w/ sub, gsub
sub('_', '', names(reviews)) ## replace first instance of _ with ''

testName <- "this_is_a_test"
sub('_', '', testName)
gsub('_', '', testName) ## replace all instances of _ with ''


## finding values w/ grep, grepl
grep('Alameda', cameraData$intersection) ## returns the indices where 'Alameda' is found
table(grepl('Alameda', cameraData$intersection)) ## returns T/F vector based on whether 'Alameda' is found or not

cameraData2 <- cameraData[!grepl('Alameda', cameraData$intersection),]

grep('Alameda', cameraData$intersection) ## returns the actual values where 'Alameda' appears
length(grep('JeffStreet', cameraData$intersection)) ## check if element exists; if 0, DNE


## other useful string functions
library(stringr)
substr('Jeffrey Leek', 1, 7) ## substring letters 1~7 inclusive
paste("Jeffrey", "Leek") ## combines two strings together w/ a space in between
paste0("Jeffrey", "Leek") ## combines two strings together w/ NO spaces in between
str_trim("Jeff       ") ## removes excess whitespace at beginning/end of string
