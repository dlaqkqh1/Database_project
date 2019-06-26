setwd('D:/jupyter/data/Database_project')
library(KoNLP) # ���̺귯�� ���
library(wordcloud) # ���̺귯�� ���
library(RColorBrewer) # ���̺귯�� ���


data <- readLines("datadeveloper.txt", encoding = 'UTF-8')

data <- gsub("hadoop", "�ϵ�", data)

#useSejongDic() # ���� �ѱۻ��� �ε�
buildDictionary(ext_dic = "woorimalsam") # ���� �ε�

mergeUserDic(data.frame(c("�ϵ�"), "ncn"))

data <- sapply(data, extractNoun, USE.NAMES = F)
data_unlist <- unlist(data)
data_unlist <- Filter(function(x){nchar(x)>=2}, data_unlist)

data_unlist <- gsub("������", "", data_unlist)
data_unlist<- gsub('[~!@#$%&*()_+=?<>???]','',data_unlist)
data_unlist <- gsub('[��-��]','',data_unlist)
data_unlist<- gsub('(��|��)','',data_unlist)
data_unlist <- gsub("\\d+","",data_unlist)

data_unlist <- Filter(function(x){nchar(x)>=2}, data_unlist)

wordcount <- table(data_unlist)


color <- brewer.pal(12, "Set2")


wordcount_top <-head(sort(wordcount, decreasing = T),50)

wordcloud(names(wordcount_top), wordcount_top, scale=c(5,0.5),random.order = FALSE, random.color = TRUE, colors = color, family = "font")