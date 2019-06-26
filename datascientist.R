setwd('D:/jupyter/data/Database_project')
library(KoNLP) # 라이브러리 등록
library(wordcloud) # 라이브러리 등록
library(RColorBrewer) # 라이브러리 등록


data <- readLines("datascientist.txt", encoding = 'UTF-8')

data <- gsub("hadoop", "하둡", data)

#useSejongDic() # 세종 한글사전 로딩
useSejongDic() # 세종 사전 불러오기

mergeUserDic(data.frame(c("R언어"), c("ncn")))

data <- sapply(data, extractNoun, USE.NAMES = F)
data_unlist <- unlist(data)
data_unlist <- Filter(function(x){nchar(x)>=2}, data_unlist)


data_unlist <- gsub("데이터", "", data_unlist)
data_unlist<- gsub('[~!@#$%&*()_+=?<>???]','',data_unlist)
data_unlist <- gsub('[ㄱ-ㅎ]','',data_unlist)
data_unlist<- gsub('(ㅜ|ㅠ)','',data_unlist)
data_unlist <- gsub("\\d+","",data_unlist)

data_unlist <- Filter(function(x){nchar(x)>=2}, data_unlist)

wordcount <- table(data_unlist)


color <- brewer.pal(12, "Set2")


wordcount_top <-head(sort(wordcount, decreasing = T),50)

wordcloud(names(wordcount_top), wordcount_top, scale=c(5,0.5),random.order = FALSE, random.color = TRUE, colors = color, family = "font")
