library(twitteR)
library(ROAuth)
library(qdap)
library(tm)
library(wordcloud)

#melb<-searchTwitter('abbott', geocode='-37.807071,144.939773,50km', n=1500)
melb_df<-twListToDF(melb) #Convert tweets to data.frame
melb_text<-gsub("[^[:alnum:]///' ]", "", melb_df$text)
melb_sent<-polarity(melb_text)$all
melb_neg<-sum(melb_sent$polarity[melb_sent$polarity<0]) # Grab the scores for negative and sum for total
melb_negwords<-melb_sent$neg.words # Grab only the negative words
melb_negwords<-melb_negwords[!grepl("-",melb_negwords)] #Remove all the - characters which signify no negative words
melb_negwords<-unlist(melb_negwords) #turn list of lists into single list
melb_corp<-Corpus(VectorSource(melb_negwords)) # Create corpus with all negative words
wordcloud(melb_corp)