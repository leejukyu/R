# 선형 & 비선형 모델링
# 비선형일 경우 상관관계는 낮게 잡힐 수 있음
library(ggplot2)
ggplot(Regression) + geom_point(aes(x=X, y=y),col='royalblue', alpha=0.4) +
  geom_smooth(aes(x=X, y=y), col = 'red') + theme_bw() + xlab("") + ylab("")

ggplot(Regression) + geom_point(aes(x=X, y=y2),col='royalblue', alpha=0.4) +
  geom_smooth(aes(x=X, y=y2), col = 'red') + theme_bw() + xlab("") + ylab("")

ggplot(Regression) + geom_point(aes(x=X, y=y3),col='royalblue', alpha=0.4) +
  geom_smooth(aes(x=X, y=y3), col = 'red') + theme_bw() + xlab("") + ylab("")

# 선형인 경우 회귀분석
LINEAR = lm(y ~ X, data = Regression)
summary(LINEAR)
"""
Call:
lm(formula = y ~ X, data = Regression)

Residuals:
    Min      1Q  Median      3Q     Max 
-9.5537 -5.7116  0.2738  5.0961 10.2835 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   1.9839     0.9975   1.989   0.0486 *  
X            10.0924     0.1620  62.308   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 6.085 on 148 degrees of freedom
Multiple R-squared:  0.9633,	Adjusted R-squared:  0.963 
F-statistic:  3882 on 1 and 148 DF,  p-value: < 2.2e-16
"""

# 제곱을 선형으로 적합
NonLinear = lm(y2 ~ X, data = Regression)
summary(NonLinear)
"""
Call:
lm(formula = y2 ~ X, data = Regression)

Residuals:
    Min      1Q  Median      3Q     Max 
-154.19  -84.79  -46.28   46.35  446.95 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) -208.872     21.225  -9.841   <2e-16 ***
X            103.788      3.447  30.113   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 129.5 on 148 degrees of freedom
Multiple R-squared:  0.8597,	Adjusted R-squared:  0.8587 
F-statistic: 906.8 on 1 and 148 DF,  p-value: < 2.2e-16
"""

# 2차항 회귀분석
NonLinear2 = lm(y2 ~ poly(X,2), data = Regression)
summary(NonLinear2)
"""
Call:
lm(formula = y2 ~ poly(X, 2), data = Regression)

Residuals:
    Min      1Q  Median      3Q     Max 
-65.180 -25.879   5.213  29.693  39.436 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  345.341      2.582  133.74   <2e-16 ***
poly(X, 2)1 3899.149     31.625  123.29   <2e-16 ***
poly(X, 2)2 1527.866     31.625   48.31   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 31.63 on 147 degrees of freedom
Multiple R-squared:  0.9917,	Adjusted R-squared:  0.9916 
F-statistic:  8767 on 2 and 147 DF,  p-value: < 2.2e-16
"""


