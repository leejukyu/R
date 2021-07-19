# 변수에 대한 요약 값 살펴보기
# Factor 형태일 때는 각 level에 해당하는 집계를 나타내며
# Numeric 형태일 때는 최솟값, 최댓값, 평균 및 분위수를 나타낸다
HR = read.csv('C:/R/R/basic/HR_comma_sep.csv')
HR$salary = as.factor(HR$salary)
summary(HR$salary)
# high    low medium 
# 1237   7316   6446
summary(HR$satisfaction_level)
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.0900  0.4400  0.6400  0.6128  0.8200  1.0000 

# 분위수 계산
# 10%, 30%, 60%, 90%에 해당하는 분위수 뽑아내기
quantile(HR$satisfaction_level, probs = c(0.1,0.3,0.6,0.9))
#  10%  30%  60%  90% 
# 0.21 0.49 0.72 0.92 

# 합, 평균, 표준편차 구하기
sum(HR$satisfaction_level) # [1] 9191.89
mean(HR$satisfaction_level) # [1] 0.6128335
sd(HR$satisfaction_level) # [1] 0.2486307

# 다중 변수의 합, 평균 구하기
# obs(행)벼로 합, 평균 구할 시에는 rowSums, rowMeans
colMeans(HR[1:5])
# satisfaction_level  last_evaluation 
# 0.6128335                0.7161017 
# number_project average_montly_hours 
# 3.8030535               201.0503367 
# time_spend_company 
# 3.4982332 
colSums(HR[1:5])
# satisfaction_level last_evaluation 
# 9191.89                   10740.81 
# number_project average_montly_hours 
# 57042.00                3015554.00 
# time_spend_company 
# 52470.00 

# 빈도 테이블 작성
# 1차원 빈도 테이블
TABLE = as.data.frame(table(HR$sales))
# 2차원 테이블
table2 = as.data.frame(xtabs(~ HR$salary + HR$sales))
table2