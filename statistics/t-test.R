HR = read.csv('C:/R/basic/HR_comma_sep.csv')
# 등분산 검정
# H0 : 두 집단의 분산이 동일하다
library(car)
HR$left = as.factor(HR$left)
leveneTest(satisfaction_level ~ left, data = HR)

"""
Levene's Test for Homogeneity of Variance (center = median)
Df F value    Pr(>F)    
group     1   122.4 < 2.2e-16 ***
  14997                      
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# H0 기각
"""

# t-test
# 등분산이 동일한 경우
t.test(satisfaction_level ~ left, data = HR, var.equal=TRUE)
# 등분산이 동일하지 않은 경우
t.test(satisfaction_level ~ left, data=HR, var.equal=FALSE)
# H0 : 평균이 같다 기각 -> 이직 여부에 따라 직무 만족도의 차이가 존재 한다
# 이직을 하지 않은 집단의 직무 만족도가 더 높다
'''
	Welch Two Sample t-test

data:  satisfaction_level by left
t = 46.636, df = 5167, p-value < 2.2e-16
alternative hypothesis: true difference in means between group 0 and group 1 is not equal to 0
95 percent confidence interval:
 0.2171815 0.2362417
sample estimates:
mean in group 0 mean in group 1 
      0.6668096       0.4400980 
'''