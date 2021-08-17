# 주성분분석 : 예측치의 선형조합을 통하여 서로 독립적인 인공변수들을 만들어내는 방법
# 차원축소 : 변수들이 가지고 있는 힘을 인공 변수에 몰아주어 분석에 사용되는 변수를 줄여준다

library(tidyr)
library(data.table)
fifa = read.csv('C:/R/statistic/CompleteDataset.csv', header=TRUE, stringsAsFactors=FALSE)
fifa_field = subset(fifa, fifa$Preferred.Positions != "GK ")

library(purrr)
# 상위 100명의 능력치를 추출
fifa_field2 = fifa_field[1:100, c(2, 10:40, 42:48, 61:71)]
fifa_field2 = fifa_field2 %>% map_if(is.character, as.numeric)
fifa_field2 = fifa_field2 %>% map_if(is.integer, as.numeric)

fifa_field2 = as.data.frame(fifa_field2)

rownames(fifa_field2) = fifa_field$Name[1:100]

# 데이터 표준화 : 분산이 큰 변수가 분산이 작은 변수의 변동을 덮어 왜곡되는것을 방지
# scale : 수치형의 모든 변수들이 평균 0, 분산 1 로 표준화
SCALED = as.data.frame(scale(fifa_field2[,1:34]))

# 선형관계 확인
library(corrplot) 
library(RColorBrewer) 
Corr_mat = cor(SCALED) 
corrplot(Corr_mat, method = "color", outline = T, addgrid.col = "darkgray", 
         order = "hclust", addrect = 4, rect.col = "black", rect.lwd = 5, 
         cl.pos = "b", tl.col = "indianred4", tl.cex = 0.5, cl.cex = 0.5, 
         addCoef.col = "white", number.digits = 2, number.cex = 0.3, 
         col = colorRampPalette(c("darkred", "white", "midnightblue"))(100))

# 차원축소
library(factoextra)
library(FactoMineR)
Principal_component = PCA(SCALED, graph = FALSE)
# 변동을 먼저 확인하기 위해 자동으로 그래프가 출력되는걸 막았다
Principal_component$eig[1:5,]
"""
       eigenvalue percentage of variance
comp 1  14.894127              43.806256
comp 2   3.600039              10.588349
comp 3   2.975834               8.752452
comp 4   2.480377               7.295227
comp 5   2.002131               5.888621
       cumulative percentage of variance
comp 1                          43.80626
comp 2                          54.39461
comp 3                          63.14706
comp 4                          70.44228
comp 5                          76.33090

comp1(제1주성분)은 전체 변동의 43.80%를 설명
comp2(제2주성분)은 전체 변동의 10.58%를 설명하며, 누적 54.39%
"""

# 주성분이 전체 변동에 대해 설명하는 비율
fviz_screeplot(Principal_component, addlabels=TRUE, ylim=c(0,50))

# 주성분 가중치 확인
Principal_component$var$coord[1:34,]
"""
                        Dim.1       Dim.2         Dim.3       Dim.4
Age                -0.1391304  0.15188183  0.0002134079  0.43702597
Acceleration        0.6111358 -0.41547597 -0.0837865360 -0.44590706
Aggression         -0.6583780  0.15278535  0.3071821747  0.17498731
Agility             0.8041455 -0.01336877 -0.0545868730 -0.36064461
Balance             0.6044207  0.15321777 -0.2446476197 -0.48091951
Ball.control        0.9140783  0.21037964  0.0194490653 -0.06052152
Composure           0.4190301  0.25451272 -0.0022204597  0.50070532
Crossing            0.8198600  0.25508545 -0.0058704866 -0.10857638
Curve               0.9155934  0.20091316 -0.0366767330 -0.02629993
Dribbling           0.9389829  0.04414586 -0.0944411585 -0.11187542
Finishing           0.9035608 -0.17998183  0.1005064965  0.18373436
Free.kick.accuracy  0.8181311  0.29463438  0.0920612901  0.06445744
GK.diving           0.1498721 -0.05724641  0.6802467984 -0.22159550
GK.handling         0.1079801 -0.05885318  0.6748930563 -0.16986119
GK.kicking          0.2176676 -0.08598534  0.7173101651 -0.16002126
GK.positioning      0.0916075 -0.13699776  0.6715493703 -0.11918837
GK.reflexes         0.2013511 -0.14807891  0.7759962774 -0.10869070
Heading.accuracy   -0.5371602 -0.32424989  0.1744474398  0.59771117
Interceptions      -0.7197588  0.58103933  0.1157715176 -0.07256358
Jumping            -0.4587959 -0.35864751  0.0540112040  0.29396321
Long.passing        0.3030627  0.82475985  0.0246753690 -0.06837626
Long.shots          0.8908026  0.13165638  0.0188156007  0.21303308
Marking            -0.8007995  0.48002382  0.1064117760 -0.07720033
Penalties           0.7904495  0.05422228  0.0198725876  0.37090847
Positioning         0.9291130 -0.06907396  0.0864699965  0.11034080
Reactions           0.4631281 -0.02933479  0.3068143471  0.40813025
Short.passing       0.7228698  0.59471217  0.0348525009 -0.03675211
Shot.power          0.6390028 -0.05247380  0.0937806240  0.47132125
Sliding.tackle     -0.7681472  0.51449058  0.1026265252 -0.08286023
Sprint.speed        0.3291413 -0.57989223 -0.1520787379 -0.31936558
Stamina             0.2595669  0.13767085  0.2692011000 -0.10582214
Standing.tackle    -0.7467206  0.57047254  0.1278732143 -0.06375572
Vision              0.8599387  0.38956406 -0.0452536061  0.10251926
Volleys             0.8923857 -0.07352719 -0.0296419164  0.26892071
                          Dim.5
Age                -0.080699184
Acceleration        0.380635869
Aggression          0.379845386
Agility             0.261068995
Balance             0.218730455
Ball.control        0.008509720
Composure           0.008980891
Crossing            0.169537864
Curve               0.024764215
Dribbling           0.039338751
Finishing          -0.019721032
Free.kick.accuracy -0.012611936
GK.diving          -0.123443113
GK.handling        -0.257640855
GK.kicking          0.023624321
GK.positioning     -0.086825626
GK.reflexes        -0.153215026
Heading.accuracy    0.237293106
Interceptions       0.220703722
Jumping             0.558884296
Long.passing       -0.039286745
Long.shots          0.062985964
Marking             0.261045992
Penalties           0.017259256
Positioning         0.070597985
Reactions           0.316327010
Short.passing      -0.039493887
Shot.power          0.179948600
Sliding.tackle      0.272201581
Sprint.speed        0.480337722
Stamina             0.665240423
Standing.tackle     0.245484735
Vision             -0.051609624
Volleys             0.071120981

부호는 방향을 의미, 절대값 크기에 집중
Dim.1 = 제1주성분
PC1이 양의 방향으로 큰 경우는 공을 다루는 능력치가 좋은 경우
PC1 이 음의 방향이면 수비 능력치가 높을 경우
즉, PC1은 수비 포지션 여부라는 새로운 이름을 줄 수 있음
"""

# Biplot
fviz_pca_var(Principal_component, col.var='contrib', 
             gradient.cols = c('#00AFBB','#E7B800','#FC4E07'), repal = TRUE)
# x축은 Dim1, y축은 Dim2
# PC1이 크거나 작을 경우 어떤 변수들이 영향을 많이 미치는지,
# PC2가 클 때, 작을 때 어떤 변수들이 영향을 많이 주는지 가중치를 한 눈에 확인

fviz_pca_biplot(Principal_component, repel=FALSE)

# 각 주성분 간의 상관계수는 0이기 때문에 다중공선성은 걱정하지 않아도 된다