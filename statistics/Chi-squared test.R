library(gmodels)
HR = read.csv('C:/R/basic/HR_comma_sep.csv')
HR$salary = factor(HR$salary, levels=c('low','medium','high'))
CrossTable(HR$left, HR$salary, prop.r = FALSE, prop.c = FALSE,
           prop.t = FALSE, chisq = TRUE, expected = TRUE)
# prop.r,c,t : 각 셀 비율표시 옵션
# chisq : 카이제곱 독립성검정을 실행하겠다
# expected : 기대빈도도
"""
   Cell Contents
|-------------------------|
|                       N |
|              Expected N |
| Chi-square contribution |
|-------------------------|

 
Total Observations in Table:  14999 

 
             | HR$salary 
     HR$left |       low |    medium |      high | Row Total | 
-------------|-----------|-----------|-----------|-----------|
           0 |      5144 |      5129 |      1155 |     11428 | 
             |  5574.188 |  4911.320 |   942.492 |           | 
             |    33.200 |     9.648 |    47.915 |           | 
-------------|-----------|-----------|-----------|-----------|
           1 |      2172 |      1317 |        82 |      3571 | 
             |  1741.812 |  1534.680 |   294.508 |           | 
             |   106.247 |    30.876 |   153.339 |           | 
-------------|-----------|-----------|-----------|-----------|
Column Total |      7316 |      6446 |      1237 |     14999 | 
-------------|-----------|-----------|-----------|-----------|

 
Statistics for All Table Factors


Pearson's Chi-squared test 
------------------------------------------------------------
Chi^2 =  381.225     d.f. =  2     p =  1.652087e-83 
"""

