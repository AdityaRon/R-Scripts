movies = read.table("u.item.txt", header = FALSE, sep ="|",quote="\"")
str(movies)
colnames(movies) = c("Id","Title","Releasedate","Videoreleasedate","IMDB","Unknown","Action","Adventure","Animation","Childrens","Comedy","Crime","Documentary","Drama","Fantasy","Filmnoir","Horror","Musical","Mystery","Romance","Scifi","Thriller","War","Western")
str(movies)
movies$Id = NULL
movies$Releasedate = NULL
movies$Videoreleasedate= NULL
movies$IMDB = NULL
movies = unique(movies)
str(movies)
distance = dist(movies[2:20], method = "euclidean")
clustermovies = hclust(distance,method="ward.D")
plot(clustermovies)
clustergroups = cutree(clustermovies, k=10)
tapply(movies$Action, clustergroups, mean)

##Clustering Using K-means
flowers = read.csv("flowers.csv",)
