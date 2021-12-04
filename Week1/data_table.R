## DATA TABLE ##
## inherets from DF
## written in C -- much faster than DF for subsetting, grouping, updating

library(data.table)
df <- data.frame(x = rnorm(9), y = rep(c('a', 'b', 'c'), each = 3), z = rnorm(9))
head(df, 3)

dt <- data.table(x = rnorm(9), y = rep(c('a', 'b', 'c'), each = 3), z = rnorm(9))
head(df, 3)

tables() ## see all DTs in memory

## subsetting
dt[2, ]
dt[dt$y == 'a']
dt[c(2, 3)]

dt[, c(2, 3)]

dt[, list(mean(x), sum(z))]
dt[, table(y)]


## adding new columns
dt[, w := z^2]
dt

## NOTE: DTs do NOT make copies; closer to references/pointers, so changes made to dt will affect dt2
## need to explicitly use copy() function to copy data over
dt2 <- dt
dt[, y := 2]
head(dt, 3)
head(dt2, 3)

## multiple operations
dt[, m := {tmp <- (x + z); log(tmp + 5)}] ## assign x + z to tmp; then take log(tmp + 5), which is assigned to m

## plyr-like operations
dt[, a := x > 0] ## makes new column 'a' with T/F
dt[, b := mean(x + w), by = a] ## makes new column 'b' whose value is determined by 'a'

## special variables
## .N = "count"
set.seed(123)
dt <- data.table(x = sample(letters[1:3], 1E5, TRUE))
dt[, .N, by = x]

## keys
dt <- data.table(x = rep(c('a', 'b', 'c'), each = 100), y = rnorm(300))
setkey(dt, x)
dt['a']

## joins
dt1 <- data.table(x = c('a', 'a', 'b', 'dt1'), y = 1:4)
dt2 <- data.table(x = c('a', 'b', 'dt2'), z = 5:7)
setkey(dt1, x)
setkey(dt2, x)
merge(dt1, dt2)

