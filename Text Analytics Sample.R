install.packages("tm")
library("tm")

#Loading the data

reviews = read.csv("reviews.csv", stringsAsFactors = FALSE )
view(reviews)

#Combining all the text together

reviews_text = paste(reviews$text, collapse = ' ')
View(reviews_text)

#Converting the text into vector source and setting up corpus

reviews_source = VectorSource(reviews_text)
Corpus = Corpus(reviews_source)

#Cleaning the data
Corpus = tm_map(Corpus, content_transformer(tolower))
Corpus = tm_map(Corpus, removePunctuation(on))
Corpus = tm_map(Corpus, stripWhitespace)
Corpus = tm_map(Corpus, removeWords, stopwords("english"))

#Creating a term document matrix

dtm = DocumentTermMatrix(Corpus)
dtm2 = as.matrix(dtm)

#Finding the Frequency
freq = colSums(dtm2)
freq = sort(freq, decreasing = TRUE)

install.packages("wordcloud")

library("wordcloud")

words = names(freq)

wordcloud(words[1:100], freq[1:100])
