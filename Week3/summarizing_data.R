## SUMMARIZING DATA ##

if(!file.exists('./GettingAndCleaningData/Week3/data')){
        dir.create('./GettingAndCleaningData/Week3/data')
}

fileURL <- 'https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD'
download.file(fileURL, destfile = './GettingAndCleaningData/Week3/data/restaurants.csv', method = 'curl')
restData <- read.csv('./GettingAndCleaningData/Week3/data/restaurants.csv')

head(restData, 3)

tail(restData, 3)

summary(restData)

str(restData)

quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))

## useNA = 'ifany' : if there are any NA values in the table, make an additional column for NA count
table(restData$zipCode, useNA = 'ifany')

## useful for finding relationships b/w variables
table(restData$councilDistrict, restData$zipCode)

## return 1 if missing; 0 if not missing
sum(is.na(restData$councilDistrict))

## checks for any instances of NA
any(is.na(restData$councilDistrict))

## checks if every single value meets the condition
all(restData$zipCode > 0)

colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)

table(restData$zipCode %in% c('21212'))
table(restData$zipCode %in% c('21212', '21213'))

## get all rows where the zipCode is either 21212 or 21213
restData[restData$zipCode %in% c('21212', '21213'), ]


data("UCBAdmissions")
df <- as.data.frame(UCBAdmissions)
summary(df)

## cross tabs
xt <- xtabs(Freq ~ Gender + Admit, data = df)
xt


## flat tables (summarize a bunch of cross tabs)
## compare breaks to all other variables in dataset
data("warpbreaks")
warpbreaks$replicate <- rep(1:9, len = 54)
xt <- xtabs(breaks ~., data = warpbreaks)
xt
ftable(xt)


## check data size
fakeData <- rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units = 'Mb')
