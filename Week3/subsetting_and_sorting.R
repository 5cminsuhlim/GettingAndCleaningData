## SUBSETTING AND SORTING ##

set.seed(13435)
x <- data.frame('var1' = sample(1:5), 'var2' = sample(6:10), 'var3' = sample(11:15))
x <- x[sample(1:5), ]
x$var2[c(1, 3)] <- NA
x

## subset column 1
x[, 1]

## subset by column 'var1'
x[, 'var1']

## subset rows 1~2 for column 'var2'
x[1:2, 'var2']

## subset rows where var1 <= 3 and var3 > 11
x[(x$var1 <= 3 & x$var3 > 11), ]

## subset rows where var1 <= 3 or var3 > 15
x[(x$var1 <= 3 | x$var3 > 15), ]

## return rows where var2 > 8
x[which(x$var2 > 8), ]

## sort ascending
sort(x$var1)

## sort decreasing
sort(x$var1, decreasing = TRUE)

## put all NA values at the end
sort(x$var2, na.last = TRUE)

## sort rows based on the value of var1 ascending
x[order(x$var1), ]

## sort rows based on values of var1, then var3 ascending
x[order(x$var1, x$var3), ]


## plyr package
library(plyr)

## sort rows based on value of var1 ascending
## same thing as x[order(x$var1), ]
arrange(x, var1)

## sort rows based on value of var1 descending
arrange(x, desc(var1))


## adding rows / columns
## creates new column 'var4'
x$var4 <- rnorm(5)

## create new df with new column
y <- cbind(x, rnorm(5))

