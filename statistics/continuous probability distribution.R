# 누적 확률 밀도 함수(cumulative probability density function)
R = rnorm(n=100000, mean=0, sd=1)
ggplot(NULL) + geom_histogram(aes(x=R, y=..density..), binwidth = 0.2, fill = 'white',col = 'black') +
  geom_density(aes(x=R), col='red',size=1) + scale_y_continuous(expand=c(0,0), limits = c(0,0.5)) +
  scale_x_continuous(limits = c(-3,3)) + xlab("") + theme_bw()
# 위 분포의 누적확률 분포
CR = ecdf(R) # CDF 계산
x = seq(from = -3, to=3, by=0.2)
CP = CR(x)
ggplot(NULL) + geom_line(aes(x=x, y=CP)) + geom_area(aes(x=x,y=CP), fill = 'royalblue', alpha = 0.4) +
  theme_bw()


# 정규분포(Normal Distribution)
library(reshape)
library(dplyr)
k1 = c()
p1 = c()

for(k in seq(-15,15,by=0.01)){
  p = dnorm(x=k, mean=0, sd=3)
  k1 = c(k1,k)
  p1 = c(p1,p)
}
k2 = c()
p2 = c()
for(k in seq(-15,15,by=0.01)){
  p = dnorm(x=k, mean=0, sd=5)
  k2 = c(k2,k)
  p2 = c(p2,p)
}
DF = data.frame(
  k = k1, 
  p1 = p1, 
  p2 = p2
)
DF %>%
  melt(id.vars = c('k')) %>%
  ggplot() + geom_line(aes(x = k, y = value, col = as.factor(variable))) +
  geom_vline(xintercept=0, linetype='dashed') + theme_bw() +
  theme(legend.position = 'none') + xlab("") + ylab("") + scale_y_continuous(expand=c(0,0))
# Y ~` N(20,5)인 확률변수에 대해 표준화를 진행
x1 = rnorm(n=1000, mean=20, sd = 5)
x2 = scale(x1)
DF = data.frame(
  x1 = x1,
  x2 = x2
)
DF %>%
  melt() %>%
  mutate(variabel = ifelse(variable == 'x1', '비표준화', '표준화')) %>%
  ggplot() + geom_density(aes(x=value, fill=variable), alpha=0.4) + theme_bw() +
  theme(legend.position = c(0.8, 0.6)) + xlab("") + ylab("") + labs(fill="")
# 평균이 30.2, 표준편차 0.6인 정규분포를 따를 때 29.6 이상 31.4 이하일 확률은?
z1 = (29.6-30.2) / 0.6
z2 = (31.4-30.2) / 0.6
print(paste('z1 :',round(z1),", z2 :",z2)) # [1] "z1 : -1 , z2 : 2"

k1 = c()
p1 = c()
for(k in seq(-5,5, by = 0.01)){
  p = dnorm(x=k, mean=0, sd=1)
  k1 = c(k1,k)
  p1 = c(p1,p)
}
ggplot(NULL) + geom_line(aes(x=k1, y=p1)) +
  geom_area(aes(x=ifelse(k1>-1 & k1<2,k1,0), y=p1),fill='royalblue',alpha=0.4) +
  theme_bw() + scale_x_continuous(breaks=seq(-5,5,by=1)) + scale_y_continuous(expand=c(0,0),limits=c(0,0.45)) +
  xlab("") + ylab("")
# pnorm -> 누적확률 구하기
Answer = pnorm(q=2, mean=0, sd=1, lower.tail=TRUE) - 
  pnorm(q=-1, mean=0, sd=1, lower.tail=TRUE)
print(paste("Answer :",round(Answer,5))) # [1] "Answer : 0.81859"



# 표본분포(sample distribution)
library(ggplot2)
K = c(10,100,1000,10000,100000)
for(k in K){
  prob_list = c()
  for(i in 1:k){
    bi = sample(c("H","T"),size = 200, replace = TRUE, prob = c(0.5,0.5))
    prob = ifelse(bi == 'H', 1,0)
    prob = sum(prob) /200
    prob_list = c(prob_list, prob)
  }
  clt = data.frame(prob = prob_list)
  graph = ggplot(clt,aes(x=prob)) + geom_bar(fill = 'royalblue',alpha=0.3) + 
    theme_bw() +xlab("") + ylab("")
}



# 카이제곱분포와 F분포(chi-square distribution and  F-distribution)
chi_2 = rchisq(n=100,df=2)
chi_3 = rchisq(n=100,df=3)
chi_10 = rchisq(n=100, df=10)
chi_30 = rchisq(n=100, df=30)

DF_chi = data.frame(
  'df=2' = chi_2,
  'df=3' = chi_3,
  'df=10' = chi_10,
  'df=30' = chi_30
)
DF_chi %>%
  melt() %>%
  ggplot() + geom_density(aes(x=value, fill=variable),alpha=0.4) +
  theme_bw() + xlab('') + ylab("") + labs(fill="") +
  theme(legend.position='bottom') + ggtitle("카이제곱분포")

F_11 = rf(n=100, df1 = 1, df2 = 1)
F_21 = rf(n=100, df1 = 2, df2 = 1)
F_52 = rf(n=100, df1 = 5, df2 = 2)
F_101 = rf(n=100, df1 = 10, df2 = 1)
DF_F = data.frame(
  'df=1,1' = F_11,
  'df=2,1' = F_21,
  'df=5,5' = F_52,
  'df=10,1' = F_101
)
DF_F %>%
  melt() %>%
  ggplot() + geom_density(aes(x=value, fill=variable),alpha=0.05) +
  theme_bw() + xlab("") + ylab("") + labs(fill = "") +
  theme(legend.position='bottom') + xlim(0,5) + ggtitle('F분포')
