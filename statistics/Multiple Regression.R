x1 = runif(n=100, min=-10, max=10)
x2 = 0.7*x1 + rnorm(n=100, mean=0, sd = 1)

y = 1.3*x1 + rnorm(n=100, mean = 6, sd = 3)

DF = data.frame(
  x1 = x1,
  x2 = x2,
  y = y
)
library(GGally)
ggpairs(DF)

# 다중회귀분석
M_Reg = lm(y ~ x1 + x1)
summary(M_Reg)
"""
Call:
lm(formula = y ~ x1 + x1)

Residuals:
    Min      1Q  Median      3Q     Max 
-8.5902 -2.1484 -0.1913  2.3114  6.8550 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   5.5386     0.3257   17.00   <2e-16 ***
x1            1.2644     0.0534   23.68   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.257 on 98 degrees of freedom
Multiple R-squared:  0.8512,	Adjusted R-squared:  0.8497 
F-statistic: 560.7 on 1 and 98 DF,  p-value: < 2.2e-16
"""

# 다중공선성 진단
library(car)
vif(M_Reg)
# 5보다 작으면 다중공선성이 없다고 판다
