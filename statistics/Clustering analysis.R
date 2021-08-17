library(tidyr)
library(data.table)
fifa = read.csv('C:/R/statistic/CompleteDataset.csv', header=TRUE, stringsAsFactors=FALSE)
fifa_field = subset(fifa, fifa$Preferred.Positions != "GK ")


library(purrr)
fifa_field2 = fifa_field[1:100, c(2, 10:40, 42:48, 61:71)]
fifa_field2 = fifa_field2 %>% map_if(is.character, as.numeric)
fifa_field2 = fifa_field2 %>% map_if(is.integer, as.numeric)
fifa_field2 = as.data.frame(fifa_field2)
rownames(fifa_field2) = fifa_field$Name[1:100]
SCALED = as.data.frame(scale(fifa_field2[,1:34]))

library(cluster)
library(factoextra)

# 100명의 선수들 중 40명을 랜덤으로 뽑아 계층적 군집분석 실행
c = sample(1:nrow(SCALED), 40, replace=FALSE)
fifa_sample = SCALED[c, ]
res.hk = hkmeans(SCALED[c, ],3)
fviz_dend(res.hk, cex=0.6, palette='jco', rect=TRUE, rect_border='jco', rect_fill=TRUE)
# hkmeans : 계층적 군집분석 명령어
# 3 : 3개의 군집으로 표시
# 대표본을 대상으론 효율X, 소표본으로 샘플링 한 후 탐색


# 비계층적 군집분석
# k평균 군집분석 : k개의 중심으로 부터 유사도가 가장 높은 데이터를 k에 할당 반복
km.res = kmeans(SCALED, 3, nstart=25)
fviz_cluster(km.res, data=SCALED) + theme_bw()

# 개별 산점도를 군집이 잘 묶였는지 시각화 -> 비효율
plot(SCALED[,1:5], col=km.res$cluster)

# 데이터가 어떤 군집에 속햇는지 확인
km.res$cluster[1:10]
"""
Cristiano Ronaldo          L. Messi            Neymar        L. Su찼rez 
                1                 1                 1                 1 
   R. Lewandowski         E. Hazard          T. Kroos       G. Higua챠n 
                1                 1                 3                 1 
     Sergio Ramos      K. De Bruyne 
                3                 1 
"""