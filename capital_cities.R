perth<-c(-31.953073,115.857693)
adelaide<-c(-34.921408,138.599288)
melbourne<-c(-37.807071,144.939773)
geelong<-c(-38.143198,144.350524)
sydney<-c(-33.878397,151.206787)
brisbane<-c(-27.459539,153.025389)
darwin<-c(-12.45468,130.839508)
hobart<-c(-42.878983,147.327819)
launceston<-c(-41.436549,147.145171)

melb<-searchTwitter('abbott', geocode='-37.807071,144.939773,50km', n=1500)
melb_df<-twListToDF(melb) #Convert tweets to data.frame
melb_text<-gsub("[^[:alnum:]///' ]", "", melb_df$text)
melb_sent<-polarity()



df2<-gsub("[^[:alnum:]///' ]", "", df) # remove rubbish and unwanted stuff
polarity(data)$all

textMelb=laply(melb, function(t) t$getText())
resultMelb=score.sentiment(textMelb, positive.words, negative.words)

# get recent public tweets
public_tweets = publicTimeline()

# get trending topics of the day
# (returns top 20 trending topics per hour for given data)
today_trends = getTrends(period = "daily", date=Sys.Date())

# get trending topics from yesterday
yest_trends = getTrends(period = "daily", date=Sys.Date() - 1)

# get trending topics of the week
# (returns top 30 trending topics for each day)
week_trends = getTrends(period = "weekly")

# search tweets containing "data mining"
dm1_tweets = searchTwitter("data mining")

# search tweets between two dates (you will have to change the dates!)
dm2_tweets = searchTwitter("data mining", since='2012-05-12', until='2012-05-17')

# search tweets around a given radius of 5 miles of latitude/longitude
dm3_tweets = searchTwitter("data mining", geocode="37.857253,-122.270558,5mi")