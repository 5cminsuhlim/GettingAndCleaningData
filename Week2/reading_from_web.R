## READING FROM WEB ##

## very similar syntax to python webscraping w/ SQL
conn <- url('https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en')
htmlCode <- readLines(conn)
close(conn)

## parsing w/ XML
library(XML)
url <- 'https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en'
html <- htmlTreeParse(url, useInternalNodes = TRUE)

xpathSApply(html, '//title', xmlValue) ## gets title of the page

xpathSApply(html, "//td[@id='col-citedby']", xmlValue) ## gets number of times papers were cited by

## parsing w/ HTTR package
library(httr)
html2 <- GET(url)
content2 <- content(html2, as = 'text')
parsedHTML <- htmlParse(content2, asText = TRUE)
xpathSApply(parsedHTML, '//title', xmlValue)

## accessing websites w/ passwords
pg1 <- GET('http://httpbin.org/basic-auth/user/passwd', authenticate('user', 'password'))
pg1
names(pg1)

## using handles
google <- handle("https://www.google.com/")
pg1 <- GET(handle=google, path='/')
pg2 <- GET(handle=google, path='search')