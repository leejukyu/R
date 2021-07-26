library(ggplot2)
# 자유도가 99인 t분포를 따르는 유의확률 0.05
k1 = c()
p1 = c()
for(k in seq(-5,5,by=0.01)){
  p=dt(x=k, df=99)
  k1 = c(k1,k)
  p1 = c(p1,p)
}
DF = data.frame(
  k1 = k1,
  p1 = p1
)

ggplot(DF) + geom_line(aes(x = k1, y = p1)) + 
  geom_area(aes(x = ifelse(k1 > qt(p = 0.025, df = 99) & k1 < qt(p = 0.975, df = 99), k1, 0), y = p1), fill = 'red', alpha = 0.2) + 
  geom_text(aes(x = 0, y = 0.2), label = "95%") + theme_bw() + scale_x_continuous(breaks = seq(-4,4, by = 1)) + 
  scale_y_continuous(expand = c(0,0),limits = c(0,0.45)) + xlab("") + ylab("")

# 검정통계량
xbar = 170
sd = 10
n = 100
mu = 167.5

T_Statistics = (xbar-mu)/(sd/sqrt(n))
1-pt(q= T_Statistics, df = n-1)  # [1] 0.007031298

ggplot(DF) + geom_line(aes(x = k1, y = p1)) + 
  geom_area(aes(x = ifelse(k1 > qt(p = 0.025, df = 99) & k1 < qt(p = 0.975, df = 99), k1, 0), y = p1), fill = 'red', alpha = 0.2) + 
  geom_text(aes(x = 0, y = 0.2), label = "95%") + geom_vline(xintercept = qt(p = 1-0.007,df = 99),linetype = 'dashed') + 
  geom_area(aes(x = ifelse(k1 < qt(p = 1-0.007, df = 99),0,k1), y = p1),fill = 'royalblue') + 
  theme_bw() + scale_x_continuous(breaks = seq(-4,4, by = 1)) + scale_y_continuous(expand = c(0,0),limits = c(0,0.45)) + 
  xlab("") + ylab("")

# 일표본 T검정
Height = rnorm(n=98, mean=170, sd=10)
print(paste("평균 :", round(mean(Height),2))) # [1] "평균 : 170.81"
print(paste("표준편차 :", round(sd(Height),2))) # [1] "표준편차 : 9.76"
t.test(x = Height, mu = 167.5, alternative="two.sided")
'''
	One Sample t-test

data:  Height
t = 3.3546, df = 97, p-value = 0.001135
alternative hypothesis: true mean is not equal to 167.5
95 percent confidence interval:
 168.8509 172.7653
sample estimates:
mean of x 
 170.8081 
'''
