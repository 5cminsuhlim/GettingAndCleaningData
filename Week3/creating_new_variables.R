## CREATING NEW VARIABLES ##

if(!file.exists('./GettingAndCleaningData/Week3/data')){
        dir.create('./GettingAndCleaningData/Week3/data')
}

fileURL <- 'https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD'
download.file(fileURL, destfile = './GettingAndCleaningData/Week3/data/restaurants.csv', method = 'curl')
restData <- read.csv('./GettingAndCleaningData/Week3/data/restaurants.csv')


## creating sequences
## generate values starting at 1 with increments of 2 up to 10
s1 <- seq(1, 10, by = 2); s1

## generate 3 values starting at 1 and ending at 10
s2 <- seq(1, 10, length = 3); s2

## loop over the number of values in x
x <- c(1, 3, 5, 8, 25, 100); seq_along(x)


## subset only useful info
restData$nearMe <- restData$neighborhood %in% c('Roland Park', 'Homeland')
table(restData$nearMe)


## creating binary variables
restData$zipWrong <- ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)


## creating categorical variables
## cut zipCode data by quantiles of zipCode
restData$zipGroups <- cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)


## easier cutting
library(Hmisc)

## cut zipCode data into 4 different groups according to quantile
restData$zipGroups <- cut2(restData$zipCode, g = 4)
table(restData$zipGroups)

## NOTE: cutting produces factor variables ##


## creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

## factor levels
yesno <- sample(c('yes', 'no'), size=10, replace=TRUE)

## factor automatically makes levels based on alphabetical order
yesnofac <- factor(yesno, levels=c('yes','no'))

## relevel to make 'yes' first level
relevel(yesnofac, ref='yes')

## change factor variable to numeric variable
as.numeric(yesnofac)


## mutate
library(Hmisc); library(plyr)

## creates new df that has data from old df but with zipGroups added
restData2 <- mutate(restData, zipGroups(cut2(zipCode, g=4)))
table(restData2$zipGroups)


## OTHER COMMON TRANSFORMATIONS ##
abs(x)
sqrt(x)
ceiling(x)
floor(x)
round(x, digits = n)
signif(x, digits = n)
cos(x); sin(x) ##etc
log(x); log2(x); log10(x) ##etc
exp(x)