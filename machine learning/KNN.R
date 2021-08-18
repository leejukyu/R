# 지도학습, 계산 비용이 높다
# k값이 작으면 noise의 영향을 크게 받고 k가 크면 정상적인 분류에 어려움 발생

library(caret)
library(class)
library(gmodels)
library(ggplot2)

data(iris)

plot(iris$Sepal.Length, iris$Sepal.width, col=iris$Species, pch=19)
legend('topright', legend=levels(iris$Species), bty = 'n', pch=19, col=palette())

# 0~1 범위로 정규화
normMinMax = function(x) {
  return((x-min(x))/max(x)-min(x))
}
iris_norm = as.data.frame(lapply(iris[1:4], normMinMax))

# Train/Test 데이터 구분
ratio = 0.7
indexes = sample(2, nrow(iris), replace=TRUE, prob=c(ratio, 1-ratio))
iris_train = iris[indexes==1, 1:4]
iris_test=iris[indexes==2, 1:4]
iris_train_labels = iris[indexes==1, 5]
iris_test_labels = iris[indexes ==2, 5]

K = c()
ACC = c()

for(x in seq(1,80, by=2)) {
  iris_mdl = knn(train=iris_train, test=iris_test, cl=iris_train_labels, k=x)
  CM = confusionMatrix(iris_test_labels, iris_mdl)
  accuracy = CM$overall[1]
  K = c(K,x)
  ACC = c(ACC,accuracy)
}
KNN_Result = data.frame(
  K = K,
  ACC = ACC
)
ggplot(KNN_Result) + geom_point(aes(x=K, y=ACC)) + geom_line(aes(x=K, y=ACC), group=1) +
  scale_x_continuous(breaks=seq(0,80,by=10)) + theme_bw() + guides(col=FALSE)

# 