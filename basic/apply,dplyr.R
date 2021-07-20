HR = read.csv('C:/R/basic/HR_comma_sep.csv')

# apply : 행이나 열에 대한 계산을 도와주는 함수
# HR 데이터 셋의 1,2열 평균을 구하고자 한다
# for문을 사용할 경우
for (i in 1:2){
  print(paste(colnames(HR)[i], ":", mean(HR[,i])))
}
# [1] "satisfaction_level : 0.612833522234816"
# [1] "last_evaluation : 0.716101740116008"

# apply를 활용할 경우
# 계산 기준 1: 행별 2: 열별별
apply(HR[,1:2],2,mean)
# satisfaction_level    last_evaluation 
#     0.6128335          0.7161017 

# colMeans을 활용할 경우
colMeans(HR[,1:2])
# satisfaction_level    last_evaluation 
#      0.6128335          0.7161017

apply(HR[, 1:2],2,sd)
# satisfaction_level    last_evaluation 
#     0.2486307           0.1711691

# 명령어가 없는 경우 함수를 직접 만들어 apply에 적용시켜야함
# 결측치가 있을 경우
D = c(1,2,3,4,NA)
E = c(1,2,3,4,5)
DF = data.frame(
  D = D,
  E = E
)
apply(DF, 2, sd)
# D        E 
# NA   1.581139 
colSd = function(x){
  y = sd(x, na.rm = TRUE)
  return(y)
}
apply(DF,2,colSd)
#        D        E 
#  1.290994 1.581139


# apply계열 함수 소개
# 그룹간 평균을 구하고 싶은 경우
tapply(HR$satisfaction_level, HR$left, mean)

# 한번에 여러 변수들에 대해 동일 조건을 주고 싶은 경우
DF2 = DF[,1:2]
DF3 = lapply(DF2, function(x) gsub(1,"A",x))
DF3 = as.data.frame(DF3)


# dplyr : 복잡하고 연쇄적인 연산을 직관적으로 입력하고 수행
library(dplyr)
HR[,1:2] %>%
  rowMeans() %>%
  head()
# [1] 0.455 0.830 0.495 0.795 0.445 0.455

# 데이터 집계내기
HR %>%
  summarise(MEAN = mean(satisfaction_level), N = length(satisfaction_level))

# subset 후 ddply를 적용햇을때 %>% 활용법
library(plyr)
HR2_O = ddply(subset(HR, left == 1), c("sales"), summarise,
              MEAN = mean(satisfaction_level),
              N = length(satisfaction_level))
HR2_D = HR %>%
  subset(left == 1) %>%
  group_by(sales) %>%
  dplyr::summarise(MEAN = mean(satisfaction_level),
                   N = length(satisfaction_level))

# 새로운 변수를 추가하고 싶은 경우
HR3_D = HR2_D %>%
  mutate(percent = MEAN/N)

# dplyr와 ggplot2의 조합
library(ggplot2)
HR2_D %>%
  ggplot() + geom_bar(aes(x=sales,y=MEAN,fill=sales), stat='identity') +
  geom_text(aes(x=sales, y=MEAN + 0.05, label=round(MEAN,2))) +
              theme_bw() + xlab('부서') + ylab('평균 만족도') + guides(fill=FALSE) +
              theme(axis.text.x = element_text(angle = 45, size = 8.5, color = 'black',
                                              face = 'plain', vjust = 1, hjust = 1))
