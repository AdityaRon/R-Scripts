#Read the file
WF = read.csv("Wells Fargo.csv" , stringsAsFactors = FALSE)
View(WF)
names(WF)
#Combine the entire text
WF_text = paste(WF$FullText, collapse = ' ')
View(WF_text)
#Convert the text to vector source
library("tm")
library("wordcloud")
WF_vector = VectorSource(WF_text)
corpus = Corpus(WF_vector)
#Clean the data
corpus = tm_map(corpus, content_transformer(tolower))
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, stripWhitespace)
corpus = tm_map(corpus, removeWords,stopwords("english")
#create a tdm matrix
tdm = DocumentTermMatrix(corpus)
tdm_matrix = as.matrix(tdm)
#frequency
freq = colSums(tdm_matrix)
freq = sort(freq, decreasing = TRUE)
#word cloud
words = names(freq)
wordcloud(words[1:50], freq[1:100])

