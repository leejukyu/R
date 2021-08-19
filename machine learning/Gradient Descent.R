# 샘플데이터 난수생성
x = runif(300, -10,10)
noise = rnorm(n=300, mean=0, sd=3)
y = x+noise

DF = data.frame(x=x, 
                y=y)
library(ggplot2)
ggplot(DF, aes(x=x, y=y)) + geom_point(col='royalblue') + theme_bw()

# learning rate
alpha=0.01
# 초기가중치 행렬생성
weights = matrix(c(0,0),nrow=2)
weights

# 행렬형태로 만들기
x = matrix(x)
x = cbind(1,x)
colnames(x) = c('v1', 'v2')

# Error 계산 %*%는 행렬의 곱셈
error = function(x,y,weight){
  sum((y - x %*% weight)^2)/(2*lenght(y))
}

# eroor값과 가중치가 저장될 빈공간을 만듦
error_surface = c()
weight_value = list()

for (i in 1:300) {
  # x는 (300,2) 행렬 weights는 (2,1)행렬 X*weights => (300,1)행렬
  error = (x %*% weights -y)
  # delta funtion 계산
  delta_function = t(x) %*% error/length(y)
  # 가중치 수정
  weights = weights - alpha*delta_function
  error_surface[i] = error(x,y, weights)
  weight_value[[i]] = weights
}


# 시각화
p = ggplot(DF, aes(x=x, y=y)) + geom_point(col='royalblue',alpha=0.4) + theme_bw()
for (i in 1:300) { 
  p = p + geom_abline(slope = Weight_Value[[i]][2], intercept = Weight_Value[[i]][1], 
                      col = "red", alpha = 0.4)
}
p
DF$num = 1:300
DF$Error_value = error_surface
ggplot(DF) + geom_line(aes(x = num, y = Error_value), group = 1) + geom_point(aes(x = num, y = Error_value)) + theme_bw() + ggtitle("Error Function") + xlab("Num of iterations")
# error값이 감소하면서 기울기에 수렴

# 최소제곱법을 이용한 선형회귀식과의 비교
REG = lm(y~x)
A = summary(REG)
print(paste('R square :', round(A$r.squared, 4)))

# 경사하강법으로 회귀식 추정할 경우 R^2
GR_model = weight_value[[300]][1] + weight_value[[300]][2] * x
actual = y
rss = sum((GR_model - actual)^2)
tss = sum((actual - mean(actual))^2)
rsq = 1 - rss/tss
print(paste('R square :', round(rsq, 4)))