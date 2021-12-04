## MERGING DATA ##

## conceptually similar to SQL merging

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

## all = true : if a value only appears in one dataset, make another row for it with NA for missing values
mergedData <- merge(reviews, solutions, by.x = 'solution_id', by.y = 'id', all = TRUE)
head(mergedData)

intersect(names(solutions), names(reviews))

## if merge variables aren't specified, merges all common column names
mergedData2 <- merge(reviews, solutions, all = TRUE)


## plyr join
## NOTE: can only join based on common names between the datasets
df1 <- data.frame(id = sample(1:10), x = rnorm(10))
df2 <- data.frame(id = sample(1:10), x = rnorm(10))
arrange(join(df1, df2), id)

## merge multiple datasets based on common variable
df3 <- data.frame(id = sample(1:10), x = rnorm(10))
dfList <- list(df1, df2, df3)
join_all(dfList)


