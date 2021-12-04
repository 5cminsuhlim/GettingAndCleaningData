## FILE HANDLING ##
if(!files.exist('data')){
        dir.create('data')
}


## DOWNLOADING FILES
fileURL <- 'https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2020-financial-year-provisional/Download-data/annual-enterprise-survey-2020-financial-year-provisional-csv.csv'
download.file(fileURL, destfile='./GettingAndCleaningData/Week1/data/random.csv')
list.files('./GettingAndCleaningData/Week1/data')

dateDownloaded <- date() ##need to keep track of date downloaded b/c files can get updated


## READING LOCAL FLAT FILES
## if reading in csv file
randomData <- read.csv('./GettingAndCleaningData/Week1/data/random.csv')

## if reading in Excel file
randomData <- read.xlsl('./GettingAndCleaningData/Week1/data/random.xlsx', sheetIndex = 1)

## if reading in XML / HTML file
## start tag <section>
## end tag </section>
## empty tag <line-break />
library(XML)
doc <- xmlTreeParse(fileURL, useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

rootNode[[1]] ## access first element
xpathSApply(rootNode, tagName, xmlValue) ## get all values corresponding w/ tagname

doc <- htmlTreeParse(fileURL, userInternal = TRUE)

## if reading in JSON file
library(jsonlite)
jsonData <- fromJSON('https://api.github.com/users/5cminsuhlim/repos')
names(jsonData)
names(jsonData$owner)
jsonData$owner$login

## converting data to json format
myjson <- toJSON(iris, pretty = TRUE)
cat(myjson)

iris2 <- fromJSON(myjson)
head(iris2)
