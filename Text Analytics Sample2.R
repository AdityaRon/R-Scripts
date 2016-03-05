#Text Analytics - Reading the data
energy = read.csv("energy_bids.csv", stringsAsFactors = FALSE)
summary(energy)
str(energy)
energy$email[1]
strwrap(energy$email[1])
#Cleaning the text
library(tm)
corpus = Corpus(VectorSource(energy$email))
corpus = tm_map(corpus, content_transformer(tolower))
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords("english"))
corpus = tm_map(corpus, stemDocument)
dtm = DocumentTermMatrix(corpus)
dtm
dtm = removeSparseTerms(dtm,0.97)
labledterms = as.data.frame(as.matrix(dtm))
labledterms$responsive = energy$responsive
str(labledterms)
library(caTools)
set.seed(144)
spl = sample.split(labledterms$responsive, SplitRatio = 0.7 )
train = subset(labledterms, spl== TRUE)
test= subset(labledterms, spl==FALSE)
library(rpart)
library(rpart.plot)
Modcart = rpart(responsive ~ ., data= train, method = "class")
prp(Modcart)
library(randomForest)
set.seed(144)
ModRF = randomForest(responsive ~ . , data =train)
table(test$responsive, predict(ModRF, test))
str(train)
str(energy)
str(labledterms)
pred = predict(Modcart, newdata = test)
pred1 = predict(ModRF, newdata=test)
pred1
pred[1:10,]
pred.prob = pred[,2]
table(test$responsive, pred.prob >= 0.5)
table(test$responsive)
215/(215+42)
library(ROCR)
predRocr = prediction(pred.prob, test$responsive)
perf = performance(predRocr , "tpr", "fpr")
plot(perf, colorize=TRUE)
performance(predRocr, "auc")@y.values
pred2 = predict(ModRF, newdata= test, type = "prob")
pred2
pred2.prob = pred2[,2]
library(ROCR)
predRocr1 = prediction(pred2.prob, test$xresponsive)
perf2 = performance(predRocr1,"tpr","fpr")
plot(perf2,colorize = TRUE)
performance(predRocr1, "auc")@y.values