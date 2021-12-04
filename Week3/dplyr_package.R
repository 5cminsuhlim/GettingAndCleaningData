## dplyr PACKAGE ##

## working with dfs
## each observation is represented by 1 row
## each column represents a variable, measure, or characteristic
## optimized version of "plyr" package
## VERY fast b/c coded in C++
## returns a df


library(dplyr)

chicago <- readRDS('chicago.rds')
dim(chicago)
str(chicago)
names(chicago)


## SELECT : returns a subset of the columns of df
## selects all columns in chicago df between city and dptp
head(select(chicago, city:dptp))

## standard R equivalent
i <- match('city', names(chicago))
j <- match('dptp', names(chicago))
head(chicago[, i:j])

## selects all columns in chicago df except those between city and dptp
head(select(chicago, -(city:dptp)))

## standard R equivalent
i <- match('city', names(chicago))
j <- match('dptp', names(chicago))
head(chicago[, -(i:j)])


## FILTER : extracts a subset of rows from df based on logical conditions
chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f)

chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f)


## ARRANGE : reorders rows of df
chicago <- arrange(chicago, date)

chicago <- arrange(chicago, desc(date))


## RENAME : renames variables in df
## new name = old name
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)


## MUTATE : adds new variables / columns or transform existing variables
chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = TRUE))
head(select(chicago, pm25, pm25detrend))


## SUMMARIZE : generates summary statistics of diff. variables in the df
chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), labels = c('cold', 'hot')))
hotcold <- group_by(chicago, tempcat)
summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

