x1 = runif(n=1000, min = -10, max = 10)
x2 = runif(n=1000, min = -10, max = 10)
x3 = runif(n=1000, min = -10, max = 10)
x4 = runif(n=1000, min = -10, max = 10)
x5 = runif(n=1000, min = -10, max = 10)

y = 0.1 * x1 - 0.7*x3 + runif(n=1000,min=-1,max=1)

reg = step(lm(y ~ x1 + x2 + x3 + x4 + x5), direction = 'backward')

"""
Start:  AIC=-1147.92
y ~ x1 + x2 + x3 + x4 + x5

       Df Sum of Sq     RSS      AIC
- x5    1       0.0   313.5 -1149.92
- x2    1       0.0   313.5 -1149.80
- x4    1       0.5   314.1 -1148.19
<none>                313.5 -1147.92
- x1    1     383.2   696.7  -351.38
- x3    1   16113.2 16426.8  2808.91

Step:  AIC=-1149.92
y ~ x1 + x2 + x3 + x4

       Df Sum of Sq     RSS      AIC
- x2    1       0.0   313.5 -1151.80
- x4    1       0.5   314.1 -1150.19
<none>                313.5 -1149.92
- x1    1     384.2   697.7  -351.99
- x3    1   16113.7 16427.2  2806.94

Step:  AIC=-1151.8
y ~ x1 + x3 + x4

       Df Sum of Sq     RSS     AIC
- x4    1       0.6   314.1 -1152.0
<none>                313.5 -1151.8
- x1    1     384.2   697.7  -353.9
- x3    1   16194.1 16507.6  2809.8

Step:  AIC=-1152.02
y ~ x1 + x3

       Df Sum of Sq     RSS      AIC
<none>                314.1 -1152.02
- x1    1     385.6   699.7  -353.14
- x3    1   16197.3 16511.5  2808.05
"""

summary(Reg)
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

# lm 명령어에 step을 덮어주면 자동으로 변수선택법에 의해 변수 선별
# 변수선택법은 필요한 변수만 뽑아주는 효과적인 방법이지만, 다중공선성을 통제할 수 없다