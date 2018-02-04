# Understand list. 
load(file='D://R/training.RData')
foo <- list( str='R', vec=c(1,2,3), bool=TRUE, dat=training)
str(foo)
lapply(foo, class)

foo$vec
head(foo$dat[,1])
foo$dat[9,]
foo$dat[[9]]
foo$dat[9]




class(rfit$y)
rfit$y

head(rfit$terms)

# $ importance     : num [1:17, 1] 45.7 44 44.5 38.2 56.6 ...
#  ..- attr(*, "dimnames")=List of 2
#  .. ..$ : chr [1:17] "x1" "x2" "x3" "x4" ...
#  .. ..$ : chr "IncNodePurity"

rfit$importance
rfit$importance[9,]
rfit$importance[[9]]

impo<-rfit$importance[,]
impo[order(impo,decreasing=T)]
str(impo)
names(impo)

#attributes the keys to understand list structure
attributes(impo)
attributes(rfit$importance)
rfit$importance[1]
rfit$importance[[1]]

impo<-data.frame(rfit$importance)
names(impo[1])<-'VAR'
names(impo)
impo$VAR<-row.names(impo)
str(impo)
impo[,2]

k<-rnorm(1000)
?cut
y<-cut(k,100)
table(y)
x <- rnorm(20)
str(x)
table(out)

out <- cut(x, quantile(x, seq(0, 1, len = 11)), include.lowest = TRUE)

seq(0,1,len=11)
quantile(x,seq(0,1,len=11))

#interesting example on lapply
#there probably is no vectorization for list because of 
x<-1:4
lapply(x, runif)
str(lapply)

