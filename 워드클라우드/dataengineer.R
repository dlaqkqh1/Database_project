setwd('D:/jupyter/data/Database_project')
library(KoNLP) # 라이브러리 등록
library(wordcloud) # 라이브러리 등록
library(RColorBrewer) # 라이브러리 등록


data <- readLines("dataengineer.txt", encoding = 'UTF-8')

# gsub함수를 이용해서 단어를 찾아서 변경해줌
data <- gsub("hadoop", "하둡", data)

#useSejongDic() # 세종 한글사전 로딩
useSejongDic() # 세종 사전 불러오기

# extracNoun함수가 단어를 분리해줌
data <- sapply(data, extractNoun, USE.NAMES = F)
data_unlist <- unlist(data)
data_unlist <- Filter(function(x){nchar(x)>=2}, data_unlist)

# gsub함수를 이용해서 의미없다고 생각하는 단어를 제거
data_unlist <- gsub("엔지니어", "", data_unlist)
data_unlist <- gsub("관련", "", data_unlist)
data_unlist <- gsub("경우", "", data_unlist)
data_unlist <- gsub("하기", "", data_unlist)
data_unlist <- gsub("데이터", "", data_unlist)
data_unlist<- gsub('[~!@#$%&*()_+=?<>???]','',data_unlist)
data_unlist <- gsub('[ㄱ-ㅎ]','',data_unlist)
data_unlist<- gsub('(ㅜ|ㅠ)','',data_unlist)
data_unlist <- gsub("\\d+","",data_unlist)

# 최소 두 글자 이상인 단어만 가져옴
data_unlist <- Filter(function(x){nchar(x)>=2}, data_unlist)

# 단어의 빈도수를 저장
wordcount <- table(data_unlist)


color <- brewer.pal(12, "Set2")

# 빈도 수가 높은 50가지의 데이터만 추출
wordcount_top <-head(sort(wordcount, decreasing = T),50)

# 워드 클라우드 작성
wordcloud(names(wordcount_top), wordcount_top, scale=c(4,0.5),random.order = FALSE, random.color = TRUE, colors = color, family = "font")
