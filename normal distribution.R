# 정규분포(normal distribution)
x <- seq(40, 120, length=300)
y <- dnorm(x, mean=80, sd=10)
plot(x,y,type='l')

# 한줄로 만들기
lines(x, dnorm(x, mean=80, sd=20), col="blue")

# 다각형만들기
x2<-seq(65, 75, length=200)
y2<-dnorm(x2, mean=80, sd=10)
polygon(c(65, x2, 75),c(0,y2,0),col="gray")

# x값의 %위치
pnorm(75, mean=80, sd=10)
# x값의 상위 %
pnorm(92, mean=80, sd=10, lower.tail=FALSE)

# 몇 % 일때의 x값
qnorm(0.3, mean=80, sd=10)
