# 1. 데이터 불러오기 및 Strings 확인
# 데이터 불러오기
HR = read.csv('C:/R/R/basic/HR_comma_sep.csv')

# 데이터 파악하기
# 데이터 윗부분 띄우기
head(HR, n=3)
# 데이터의 shape, strings파악
str(HR)
# 데이터 요약해서 보기
summary(HR)

# 데이터 strings 변경
summary(HR$left) # 명목형이라 factor형태로 와야하지만 int로 인식
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0.0000  0.0000  0.0000  0.2381  0.0000  1.0000
HR$work_accident = as.factor(HR$Work_accident)
HR$left = as.factor(HR$left)
HR$promotion_last_5years=as.factor(HR$promotion_last_5years)
HR$salary = as.factor(HR$salary)
summary(HR$left) # factor로 변경된걸 확인
#     0     1 
# 11428  3571 


# 2. 조건에 맞는 데이터 가공하기
# 조건에 맞는 값 할당하기 ifelse(조건, TRUE, FALSE)
# satisfaction_level이 0.8보다 크다면 'High', 0.5~0.8이면 'Mid', 나머지는 'Low'
HR$satisfaction_level_group = ifelse(HR$satisfaction_level > 0.8,'High',
                                     ifelse(HR$satisfaction_level > 0.5, 'Mid','Low'))
HR$satisfaction_level_group = as.factor(HR$satisfaction_level_group)
summary(HR$satisfaction_level_group)
# High  Low  Mid 
# 4002 4812 6185 

# 조건에 맞는 데이터 추출하기 subset(데이터, 추출조건)
# salary가 high인 직원들만 추출해서 새로운 데이터 셋 생성
HR_High = subset(HR, salary == 'high')
summary(HR_High$salary)
# high    low medium 
# 1237      0      0 
# salary가 high이면서, sales가 IT인 직원들만 추출하여 HR_High_IT생성(교집합)
HR_High_IT = subset(HR, salary == 'high' & sales == 'IT')
print(xtabs(~ HR_High_IT$sales + HR_High_IT$salary))
#                 HR_High_IT$salary
# HR_High_IT$sales high low medium
#              IT   83   0      0


# 3. 조건에 맞는 집계 데이터 만들기
# 엑셀의 피벗테이블 -> R의 plyr
# 패키지 설치 먼저
install.packages("plyr")
library(plyr)

# ddply를 활용한 집계 데이터 만들기
# (1) 분석할 데이터 설정
# (2) 집계 기준 변수 설정
# (3) 집계 값을 저장할 칼럼명 및 계산 함수 설정
ss = ddply(HR, # 분석할 Data set 설정
           c('sales', 'salary'), summarise, # 집계 기준 변수 설정
           M_SF = mean(satisfaction_level), # 컬럼명 및 계산 함수 설정
           COUNT = length(sales),
           M_WH = round(mean(average_montly_hours),2))
#          sales salary      M_SF COUNT   M_WH
# 1   accounting   high 0.6140541    74 205.91
# 2   accounting    low 0.5741620   358 199.90
# 3   accounting medium 0.5836418   335 201.47
# 4           hr   high 0.6731111    45 209.07


# 4. ggplot2 기본 시각화
library(ggplot2)
library(ggthemes)

HR$salary = factor(HR$salary, levels = c('low','medium','high'))
ggplot(HR) # plot창에 회색 바탕면만 생김
ggplot(HR, aes(x = salary)) # aes : 변수가 들어갈 곳

# 막대그래프
ggplot(HR, aes(x = salary)) + geom_bar() # 막대 그래프 그림
ggplot(HR, aes(x = salary)) + geom_bar(aes(fill = salary)) # 변수마다 다른 색 넣어줌
ggplot(HR, aes(x = salary)) + geom_bar(aes(fill=left)) # left값에 따라 색 채우기

# 히스토그램
ggplot(HR, aes(x=satisfaction_level)) + geom_histogram() # 기본
ggplot(HR, aes(x=satisfaction_level)) + geom_histogram(binwidth = 0.01, col = 'red', fill = 'royalblue') # col: 테두리 색, fill: 채워지는 색

# 밀도그래프 : 연속형 변수 하나를 집계
ggplot(HR, aes(x = satisfaction_level)) + geom_density() # 기본
ggplot(HR, aes(x = satisfaction_level)) + geom_density(col = 'red', fill = 'royalblue')

# 박스플롯 : 이산형 변수와 연속형 변수의 분포 차이를 표현
ggplot(HR, aes(x=left, y=satisfaction_level)) + geom_boxplot(aes(fill=left)) + 
  xlab('이직여부') + ylab('만족도') + ggtitle('Boxplot') +
  labs(fill='이직여부')


ggplot(HR, aes(x=left, y=satisfaction_level)) +
  geom_boxplot(aes(fill = salary), alpha = I(0.4), outlier.color = 'red') +
  xlab('이직여부') + ylab('만족도') + ggtitle('Boxplot') +
  labs(fill = '임금수준준') # alpha : 색 명도 조절 0~1

# 산점도 : 두 연속형 변수의 상관관계를 표현
ggplot(HR, aes(x=average_montly_hours, y=satisfaction_level)) + geom_point()
# 간단한 색칠로 인사이트 발굴
ggplot(HR, aes(x=average_montly_hours, y=satisfaction_level)) + 
  geom_point(aes(col=left)) + labs(col = '이직여부') + xlab('평균 근무시간') + ylab('만족도')
