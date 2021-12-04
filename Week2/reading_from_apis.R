## READING FROM APIS ##
## generally, look at API documentation

## accessing Twitter
myapp <- oauth_app('twitter', key = 'key', secret = 'secret')
sig <- sign_oauth1.0(myapp, token = 'token', token_secret = 'token_secret')
homeTL <- GET('https://api.twitter.com/1.1/statuses/home_timeline.json', sig)

## converting json object
json1 <- content(homeTL)
json2 <- jsonlite::fromJSON(toJSON(json1))
json2[1, 1:4]

