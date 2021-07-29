HR = read.csv('C:/R/basic/HR_comma_sep.csv')

library(ggplot2)
x1 = runif(n = 100, min = -10, max = 10)

y = x1 * 10 + rnorm(n=100, mean = 3, sd = 5)

# 산점도
ggplot() +
  geom_point(aes(x=x1, y=y), size = 3) +
  geom_text(aes(x = 5, y = -30), label = round(cor(x1, y),4)) +
  theme_bw()

# 상관분석 검정 H0 : p = 0
cor.test(x1, y)
"""
Pearson's product-moment correlation

data:  x1 and y
t = 119.21, df = 98, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.9948972 0.9976948
sample estimates:
      cor 
0.9965698 

H0 기각
"""

y = x1^2 + x1 * 10 + rnorm(n=100, mean = 3, sd = 5)
ggplot() +
  geom_point(aes(x = x1, y = y), size=3) +
  geom_text(aes(x = 0, y = 100), label = round(cor(x1,y),4)) +
  theme_bw()
# 상관계수가 매우 낮게 나와도 뚜렷한 관계가 있음이 나타날 수 있다다