## RESHAPING DATA ##

library(reshape2)
head(mtcars)

## melting dfs
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c('carname', 'gear', 'cyl'), measure.vars=c('mpg', 'hp'))
head(carMelt, 3)
tail(carMelt, 3)


## casting dfs
cylData <- dcast(carMelt, cyl ~ variable)
cylData

cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData


## averaging values
head(InsectSprays)

## sum the counts based on spray
tapply(InsectSprays$count, InsectSprays$spray, sum)

## summing w/ split + lapply
spIns <- split(InsectSprays$count, InsectSprays$spray)
spIns
sprCount <- lapply(spIns, sum)
sprCount
unlist(sprCount) ## convert back to a vector

## summing w/ split + sapply
sapply(spIns, sum)

## summing w/ plyr
ddply(InsectSprays, .(spray), summarize, sum = sum(count))


## creating a new variable
## for all corresponding 'spray' values, sum is the same
spraySums <- ddply(InsectSprays, .(spray), summarize, sum = ave(count, FUN = sum))
dim(spraySums)
head(spraySums)



