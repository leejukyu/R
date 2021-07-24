# 이항분포(Binomial distribution) : 가능한 결과가 두가지인 경우
# 확률률변수가 배타적인 두 가지 범주를 갖고 각 시해이 독립적인 경우
library(ggplot2)
RB = rbinom(n = 400, size = 1, prob = 0.6) # 난수생성성
ggplot(NULL) + geom_bar(aes(x=as.factor(RB), fill = as.factor(RB))) +
  theme_bw() + xlab("") + ylab("") + scale_x_discrete(labels = c("실패","성공")) +
  theme(legend.position = 'none')
# 성공확률이 0.4
x = c()
p = c()
for(k in 1:10){
  RDB = dbinom(x = k, size = 10, prob = 0.4)
  x = c(x,k)
  p = c(p, RDB)
}
ggplot(NULL) + geom_bar(aes(x=x, y=p),stat = 'identity') + theme_bw() +
  scale_x_continuous(breaks = seq(1,10)) + xlab("성공횟수") + ylab("확률")
# 성공확률이 0.8
x = c()
p = c()
for(k in 1:10){
  RDB = dbinom(x = k, size = 10, prob = 0.8)
  x = c(x,k)
  p = c(p, RDB)
}
ggplot(NULL) + geom_bar(aes(x=x, y=p),stat = 'identity') + theme_bw() +
  scale_x_continuous(breaks = seq(1,10)) + xlab("성공횟수") + ylab("확률")



# 다항분포(multinomial distribution) : 실험 결과가 k개인 확률 실험을 n번 반복했을 때, 각 번주에 속하는 횟수를 확률 변수로 하는 분포
RM = as.data.frame(t(rmultinom(n=1, size=10, prob=c(0.2,0.5,0.3))))
RM = colSums(RM)
ggplot(NULL) + geom_bar(aes(x=names(RM), y=RM, fill=names(RM)), stat='identity') +
  theme_bw() + theme(legend.position='none') + scale_x_discrete(labels=c('1','2','3')) + xlab("") +ylab("")
# p.m.f계산
n_F = factorial(10)
x_F = factorial(5) * factorial(3) * factorial(2)
prob = (n_F/x_F)*(1/3)^5 *(1/3)^3 *(1/3)^2
prob # [1] 0.04267642
# 명령어 활용
dmultinom(c(5,3,2), prob=c(1/3,1/3,1/3)) # [1] 0.04267642


# 포아송분포(poisson distribution) : 일정 단위에서 평균 성공 횟수가 람다일 때 성공 횟수를 확률변수로 하는 분포
# 빈도 데이터에 적용하기 적절
RP = rpois(n=100, lambda=2)
ggplot(NULL) + geom_bar(aes(x=as.factor(RP),fill=as.factor(RP))) + theme_bw() +
  xlab('성공횟수') + ylab('빈도') + theme(legend.position = 'none')
ppois(q = 15, lambda = 20, lower.tail=TRUE) # [1] 0.1565131
