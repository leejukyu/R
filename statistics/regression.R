Regression = read.csv('C:/R/statistic/Regression.csv')

# 산점도
library(ggplot2)
ggplot(Regression, aes(x=X, y=y)) +
  geom_point() + geom_smooth(method = 'lm') + theme_classic()

# 단순 선형 회귀분석
Reg = lm(y~X, data = Regression)
anova(Reg)
summary(Reg)
'''
Analysis of Variance Table

Response: y
          Df Sum Sq   Mean Sq F value   Pr(>F)    
X           1 143757  143757  3882.2 < 2.2e-16 ***
Residuals 148   5480      37                      
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# H0 : 회귀식은 유의하지 않다 기각


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
'''

# 잔차진단
plot(Reg)
qqnorm(Reg$residuals) # 정규성성
# 독립성
ggplot(NULL) + geom_point(aes(x = 1:nrow(Regression), y=Reg$residuals)) +
  geom_hline(yintercept = 0, linetype = 'dashed', col='red') +
  xlab('index') + ylab('Residuals') + theme_bw()
