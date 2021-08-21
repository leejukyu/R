library(C50)
library(caret)
library(xtable)

HR = read.csv('C:/R/basic/HR_comma_sep.csv')
SL = sample(1:nrow(HR), nrow(HR)*0.7, replace=FALSE)
HR$left = as.factor(HR$left)
train=HR[SL, ]
test = HR[-SL, ]

feature = train[, c(1:6, 8:10)]
response = train[, 7]

# 의사결정나무 분류규칙 생성
tree = C5.0(feature, response, control = C5.0Control(noGlobalPruning=FALSE, minCases=100), trials=10)
plot(tree)
"""
C5.0 : Tree 알고리즘 명령어
trials = boosting 실행
mincases : 최종 결과 노드에 최소 몇개의 관측치를 포함할지 설정
"""

# mincases 값을 높게 조정하면 의사결정나무가 단순해짐
tree = C5.0(feature, response, control = C5.0Control(noGlobalPruning=FALSE, minCases=300), trials=10)
plot(tree)


# test set 검증
y_pred = predict(tree, newdata = test)
confusionMatrix(y_pred, test$left)



# Random Forest
library(randomForest)
rf.fit = randomForest(left ~ ., data = train, mtry=3, ntree=200, importance=T)
y_pred = predict(rf.fit, test)
confusionMatrix(y_pred, test$left)
# mtry : 랜덤으로 투입할 변수의 갯수

varImpPlot(rf.fit, type = 2, pch = 19, col=1, cex=1, main="")
# 랜덤 포레스트 내부의 오류율 -> 수렴
plot(rf.fit$err.rate[,1], col='red')



# ROC커브
GLM = step(glm(left ~ ., data = train, family = binomial(link='logit')))
GLM_pred = predict(GLM, newdata = test, type = 'response')
Tree_pred = predict(tree, newdata = test, type = 'prob')
RF_pred = predict(rf.fit, newdata = test, type = 'prob')

library(pROC)
GLM_ROC = roc(test$left, GLM_pred)
Tree_ROC = roc(test$left, Tree_pred[, 2])
RF_ROC = roc(test$left, RF_pred[, 2])

ROC_DF = data.frame( 
  SEN = c(GLM_ROC$sensitivities,Tree_ROC$sensitivities,RF_ROC$sensitivities), 
  SPE = c(GLM_ROC$specificities,Tree_ROC$specificities,RF_ROC$specificities), 
  Model = c(rep("GLM",length(GLM_ROC$sensitivities)), rep("Tree",length(Tree_ROC$sensitivities)), 
            rep("RF",length(RF_ROC$sensitivities))) )

ggplot(ROC_DF) + geom_line(aes(x = 1-SPE, y = SEN, col = Model),size = 1.2) +
  xlab("1-specificity") + ylab("sensitivity") + theme_bw() + 
  theme(legend.position = "bottom", legend.box.background = element_rect(), 
        legend.box.margin = ggplot2::margin(2,2,2,2), text = element_text(size = 15))

