# H0 : 연봉 수준별로 직무 만족도의 평균이 같다
ANOVA = aov(satisfaction_level ~ salary, data=HR)
summary(ANOVA)
'''
              Df Sum Sq Mean Sq F value   Pr(>F)    
salary          2    2.3  1.1693   18.96 5.97e-09 ***
Residuals   14996  924.8  0.0617                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# H0 기각
'''


# Tukey사후검정
TUKEY= TukeyHSD(ANOVA)
TUKEY
'''
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = satisfaction_level ~ salary, data = HR)

$salary
                   diff         lwr          upr     p adj
low-high    -0.03671654 -0.05461098 -0.018822102 0.0000046
medium-high -0.01565305 -0.03372130  0.002415191 0.1049520
medium-low   0.02106349  0.01111999  0.031006988 0.0000021

3개의 집단을 2개씩 따로 분석, 각 신뢰구간이 0을 포함하는지 아닌지
low-high 신뢰구간이 0을 포함하지 않고, 0보다 작으므로 low가 high 보다 작다
medium-high 신뢰구간이 0을 포함하고 있어 평균이 같다고 할 수 있다
medium-low 신뢰구간이 0을 포함하지 않고 0보다 크므로 medium이 low보다 높다고 할 수 있다
'''
plot(TUKEY)




# 이원배치 분산분석
T_ANOVA = aov(satisfaction_level ~ salary + left + salary:left, data = HR)
summary(T_ANOVA)
'''
               Df Sum Sq Mean Sq  F value   Pr(>F)    
salary          2    2.3    1.17   22.276 2.19e-10 ***
left            1  137.8  137.79 2624.960  < 2e-16 ***
salary:left     2    0.0    0.01    0.155    0.856    
Residuals   14993  787.0    0.05                      
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

단일 효가ㅗ는 유의하지만 교호작용(salary:left)는 유의하지 않다
교호작용을 제거하고 다시 분석석
'''
