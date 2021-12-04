## READING FROM MYSQL ##

install.packages('RMySQL')

## connect to db
ucscDB <- dbConnect(MySQL(), user = 'genome', host = 'genome-mysql.ucsc.edu')

## SQL query: obtain list of databases
result <- dbGetQuery(ucscDB, 'show databases;')

## IMPORTANT: disconnect after gathering data
dbDisconnect(ucscDB)


hg19 <- dbConnect(MySQL(), user = 'genome', db = 'hg19', host = 'genome-mysql.cse.ucsc.edu')
allTables <- dbListTables(hg19)
length(allTables)

## get all fields from db hg19 table affyU133Plus2
dbListFields(hg19, 'affyU133Plus2')

## SQL query: get number of records
dbGetQuery(hg19, 'SELECT COUNT(*) FROM affyU133Plus')

## SQL query: get specific subset
query <- dbGgetQuery(hg19, 'SELECT * FROM affyU133Plus WHERE misMatches BETWEEN 1 AND 3')

## fetch results of query
affyMis <- fetch(query)

quantile(affyMis$misMatches)

## fetch just top 10 records
affyMisSmall <- fetch(query, n = 10)

## IMPORTANT: need to clear query from MySQL server
dbClearResult(query)

dim(affyMisSmall)

dbDisconnect(hg19)