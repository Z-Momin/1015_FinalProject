library(readr)
library(stringr)
library(quanteda)
library(dplyr)
library(quanteda.corpora)
library(tm)

candidate_tweets <- read_csv("Desktop/candidate-tweets.csv")
candidate_tweets <- candidate_tweets[,1:3] 
candidate_tweets$candidate_number <- NA
candidate_tweets$candidate_number[candidate_tweets$screen_name == 'realDonaldTrump'] <- 1
candidate_tweets$candidate_number[candidate_tweets$screen_name == 'HillaryClinton'] <- 2
candidate_tweets$candidate_number[candidate_tweets$screen_name == 'tedcruz'] <- 3
candidate_tweets$candidate_number[candidate_tweets$screen_name == 'BernieSanders'] <- 4

candidate_tweets$retweet <- 0
candidate_tweets$retweet[grep('RT @',candidate_tweets$text)] <- 1
candidate_tweets$cleaned_text <- gsub("[^(?=#)(?=@)[:^punct:]]",'',candidate_tweets$text, perl=T) #remove all punctuations except @ and #
candidate_tweets$cleaned_text <- gsub('@\\w+','',candidate_tweets$cleaned_text) #remove all @
candidate_tweets$cleaned_text <- gsub('RT','',candidate_tweets$cleaned_text) #remove retweet label
candidate_tweets$cleaned_text <- gsub('http\\w+','',candidate_tweets$cleaned_text) #remove websites
candidate_tweets$cleaned_text <- str_squish(candidate_tweets$cleaned_text) #remove extra spaces
candidate_tweets$cleaned_text <- tolower(candidate_tweets$cleaned_text)
