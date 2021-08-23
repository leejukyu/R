HR = read.csv('C:/R/basic/HR_comma_sep.csv')
HR$salary = factor(HR$salary, levels=c('low','medium','high'))
Logistic = glm(left ~ satisfaction_level + salary + time_spend_company,
               data = HR, family = binomial())
# 로지스틱 회귀분석은 일반화 선형 모형이기 때문에 glm으로 진행
# family=binomial은 종속변수 분포 모형 옵션, left는 이직여부 -> 이항분포,
summary(Logistic)
"""
Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-1.8628  -0.6774  -0.4666  -0.1781   2.7644  

Coefficients:
                   Estimate Std. Error z value Pr(>|z|)    
(Intercept)         0.48069    0.07532   6.382 1.75e-10 ***
satisfaction_level -3.72386    0.08852 -42.069  < 2e-16 ***
salarymedium       -0.53427    0.04436 -12.044  < 2e-16 ***
salaryhigh         -1.98592    0.12461 -15.938  < 2e-16 ***
time_spend_company  0.21159    0.01418  14.922  < 2e-16 ***
---
Signif. codes:  0 ?***? 0.001 ?**? 0.01 ?*? 0.05 ?.? 0.1 ? ? 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 16465  on 14998  degrees of freedom
Residual deviance: 13597  on 14994  degrees of freedom
AIC: 13607

Number of Fisher Scoring iterations: 5
"""

# 모형의 성능 평가
HR$salary = factor(HR$salary, levels = c('low', 'medium', 'high'))
Log_odds = predict(Logistic, newdata = HR)
probability = predict(Logistic, newdata = HR, type='response')

predicted_c = ifelse(probability > 0.5, 1, 0)
predicted_c = factor(predicted_c, levels = c(1,0))

library(caret)
HR$left = factor(HR$left, levels=c(1,0))
confusionMatrix(predicted_c, HR$left)

# Roc Curve
library(pROC)
HR$left = factor(HR$left, levels=c(0,1))
ROC = roc(HR$left, probability)

plot.roc(ROC, col='royalblue', print.auc=TRUE, max.auc.polygon=TRUE,
         print.thres=TRUE, print.thres.pch=19, print.thres.col='red',
         auc.polygon=TRUE, auc.polygon.col = '#A0A0A0')
