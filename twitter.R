library("ROAuth")
library("twitteR")
library("wordcloud")
library("tm")
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "TPiP1y67fxUEukHrtuRVN2vB3"
consumerSecret <- "TnbXTx8qNetUYtoTSiBY8yoy00NUU4PkwgqQl5rwSbidtFDHPv"
twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)
twitCred$handshake()

#the cainfo parameter is necessary on Windows
r_stats<- searchTwitter("#abbott", n=1500)
#save text
r_stats_text <- sapply(r_stats, function(x) x$getText())
#create corpus
r_stats_text_corpus <- Corpus(VectorSource(r_stats_text))
#clean up
r_stats_text_corpus <- tm_map(r_stats_text_corpus, tolower) 
r_stats_text_corpus <- tm_map(r_stats_text_corpus, removePunctuation)
r_stats_text_corpus <- tm_map(r_stats_text_corpus, function(x)removeWords(x,stopwords()))
wordcloud(r_stats_text_corpus)
