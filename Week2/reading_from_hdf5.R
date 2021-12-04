## READING FROM HDF5 ##

source('http://bioconductor.org/biocLite.R')
biocLite('rhdf5')

library(rhdf5)
created <- h5createFile('example.h5')
created

## create groups
created <- h5createGroup('example.h5', 'foo')
created <- h5createGroup('example.h5', 'baa')
created <- h5createGroup('example.h5', 'foo/foobaa')

h5ls('example.h5')

## write to groups
a <- matrix(1:10, nr = 5, nc = 2)
h5write(a, 'example.h5', 'foo/a')

b <- array(seq(0.1, 2.0, by = 0.1), dim = c(5, 2, 2))
attr(b, 'scale') <- 'liter'
h5write(b, 'example.h5', 'foo/foobaa/b')

h5ls('example.h5')

## directly write a dataset
df <- data.frame(1L:5L, seq(0, 1, length.out = 5), c('ab', 'cde', 'fghi', 'a', 's'), stringsAsFactors = FALSE)
h5write(df, 'example.h5', 'df')

h5ls('example.h5')

## reading data
readA <- h5read('example.h5', 'foo/a')
readB <- h5read('example.h5', 'foo/foobaa/b')
readDF <- h5read('example.h5', 'df')

## read / write chunks
h5write(c(12, 13, 14), 'example.h5', 'foo/a', index = list(1:3, 1)) ## add 12, 13, 14 to first 3 rows of 1st column
h5read('example.h5', 'foo/a')

