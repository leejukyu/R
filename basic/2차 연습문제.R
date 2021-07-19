HR = read.csv('C:/R/R/basic/HR_comma_sep.csv')

# 1. last_evaluation의 평균을 구하시오
mean(HR$last_evaluation)

# 2. last_evaluation의 표준편차를 구하시오
sd(HR$last_evaluation)

# 3. sales에 대한 빈도표를 작성하시오
as.data.frame(table(HR$sales))

# 4. left, salary에 대한 교차표를 작성하시오
as.data.frame(xtabs(~ HR$left + HR$salary))