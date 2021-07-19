IMDB = read.csv('C:/R/R/basic/IMDB-Movie-Data.csv')

# 1. 결측치 다루기
# 결측치 확인
# Metascore 변수 내에서 결측치 논리문 판단
is.na(IMDB$Metascore)[1:20]
# [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
# [10] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
# [19] FALSE FALSE
# Metascore 변수 내에 결측치 갯수
sum(is.na(IMDB$Metascore)) # 64
# IMDB 내 모든 변수별 결측치 갯수
colSums(is.na(IMDB))

# 결측치 제거
# 결측치가 하나라도 보함된 행 삭제
IMDB2 = na.omit(IMDB)
colSums(is.na(IMDB2))
# 특정 변수에 결측치가 존재하는 행만 삭제
# 12번째 열에 결측치가 있는 경우에만 삭제
IMDB3 = IMDB[complete.cases(IMDB[,12]),]
colSums(is.na(IMDB3))

# 결측치를 특정값으로 대체
# Rawdata를 새로운 변수에 복사
IMDB$Metascore2 = IMDB$Metascore
# 결측치 대체
IMDB$Metascore2[is.na(IMDB$Metascore2)]==58.99
# 결측치 생략하고 계산
mean(IMDB$Revenue..Millions.) # NA 생성
mean(IMDB$Revenue..Millions., na.rm=TRUE) # NA 생략하고 계산


# 결측치 처리를 위한 데이터의 분포 탐색
library(ggplot2)

ggplot(IMDB, aes(x=Revenue..Millions.)) + geom_histogram(fill='royalblue', alpha = 0.4) +
  ylab(' ') + xlab('Revenue_Millions') + theme_classic()

ggplot(IMDB, aes(x=" ", y=Revenue..Millions.)) + 
  geom_boxplot(fill='red', alpha = 0.4, outlier.color = 'red') +
  ylab(' ') + xlab('Revenue_Millions') + theme_classic()

summary(IMDB$Revenue..Millions.)
# Revenue_Millions는 한쪽으로 치우쳐져있다. 이럴경우 평균으로 대체하면 매우 위험
# 중위수로 대체하자(완벽은 아니지만 차선)


# 2. 이상치 다루기
# 이상치 뽑아내기
ggplot(IMDB,aes(x=as.factor(Year),y=Revenue..Millions.))+
  geom_boxplot(aes(fill=as.factor(Year)),outlier.colour = 'red',alpha=I(0.4))+ 
  xlab("년도") + ylab("수익") + guides(fill = FALSE) + 
  theme_bw() + theme(axis.text.x = element_text(angle = 90))
# 이상치 탐색에는 박스플롯이 제일 좋다
# 이상치 처리 방법 : 제거, log변환 등
# 제거
Q1 = quantile(IMDB$Revenue..Millions.,probs = c(0.25),na.rm = TRUE) 
Q3 = quantile(IMDB$Revenue..Millions.,probs = c(0.75),na.rm = TRUE) 
LC = Q1 - 1.5 * (Q3 - Q1) # 아래 울타리 
UC = Q3 + 1.5 * (Q3 - Q1) # 위 울타리 
IMDB2 = subset(IMDB, Revenue..Millions. > LC & Revenue..Millions. < UC)


# 3. 문자열 데이터 다루기
# 문자열 추출
substr(IMDB$Actors[1],1,5) # 첫번째 obs의 Actors 변수에서 1~5번째 문자열 추출
# 문자열 붙이기
paste(IMDB$Actors[1],"_","A") # 첫번째 obs의 Actors변수에서 _A 분이기기
paste(IMDB$Actors[1],"_","A",sep="") # 띄어쓰기 없이 붙이기기
paste(IMDB$Actors[1],"_","Example",sep="|") # |로 붙이기기
# 문자열 분리
strsplit(as.character(IMDB$Actors[1]),split=",")
# 문자열 대체
IMDB$Genre2 = gsub(","," ",IMDB$Genre) # ,를 띄어쓰기로 대체체


# 텍스트 마이닝
# (1) 코퍼스(말뭉치) 생성
library(tm)
CORPUS = Corpus(VectorSource(IMDB$Genre2)) # 코퍼스 생성
CORPUS_TM = tm_map(CORPUS, removePunctuation) # 특수문자 제거
CORPUS_TM = tm_map(CORPUS_TM, removeNumbers) # 숫자 제거
CORPUS_TM = tm_map(CORPUS_TM, tolower) # 알파벳 모두 소문자로 바꾸기
# (2) 문서행렬 생성
TDM = DocumentTermMatrix(CORPUS_TM) # 문서행렬 생성
inspect(TDM)
TDM = as.data.frame(as.matrix(TDM)) # 문서행렬을 데이터프레임 형태로 만들어주기
head(TDM)
# (3) 기존 데이터와 결합하기
IMDB_GENRE = cbind(IMDB,TDM) # 같은 행을 가지고 순서가 같은 데이터 열 합치기

# stopwords를 이용한 단어 제거
corpus = Corpus(VectorSource(IMDB$Description))
corpus_tm = tm_map(corpus, stripWhitespace)
corpus_tm = tm_map(corpus_tm, removePunctuation)
corpus_tm = tm_map(corpus_tm, removeNumbers)
corpus_tm = tm_map(corpus_tm, tolower)
DTM = DocumentTermMatrix(corpus_tm)
inspect(DTM)
courpus_tm = tm_map(corpus_tm, removeWords,
                    c(stopwords("english"), 'my', 'custom', 'words')) # 추가로 삭제하고 싶은 단어 삭제
# 중복등장 단어 처리 결정
# 1안 : 특정 단어가 문장에 포함되어 있냐 없냐로 표시
convert_count = function(x){
  y = ifelse(x>0,1,0)
  y = as.numeric(y)
  y
}
# 2안 : 특정 단어가 문장에 몇번 등장햇나를 표시
convert_count = function(x){
  y = ifelse(x>0,x,0)
  y = as.numeric(y)
  y
}
# 사용자 함수 적용
# 매트릭스 형태인 TDM에 convert_count를 하나씩 적용하여 값을 배출
descript_IMDB = apply(DTM, MARGIN=2, convert_count)
descript_IMDB=as.data.frame(descript_IMDB)

# 문자열 데이터 시각화
TDM = TermDocumentMatrix(corpus_tm)
# 워드클라우드 생성
m = as.matrix(TDM)
v = sort(rowSums(m), decreasing=TRUE) # 빈도수를 기준으로 내림차순 정렬
d = data.frame(word = names(v), freq=v)

library('SnowballC')
library("wordcloud")
library("RColorBrewer")
# min.freq : 최소 5번 이상 쓰인 단어만 띄우기
# max.words : 최대 200개만 띄우기
# random.order : 단어 위치 랜덤 여부
wordcloud(words = d$word, freq = d$freq, min.freq = 5,
          max.words = 200, random.order = FALSE, colors=brewer.pal(8,"Dark2"))
# 단어 빈도 그래프 그리기
ggplot(d[1:10,]) + geom_bar(aes(x=reorder(word,freq),y=freq), stat ='identity') +
         coord_flip() + xlab('word') + ylab('freq') + theme_bw()
