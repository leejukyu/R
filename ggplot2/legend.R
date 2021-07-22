library(ggplot2)

HR = read.csv('C:/R/basic/HR_comma_sep.csv')
HR$left = as.factor(HR$left)
HR$salary = factor(HR$salary, levels = c("low",'medium','high'))

# 범례제목 수정
ggplot(HR, aes(x=salary)) + geom_bar(aes(fill=salary)) + theme_bw() + labs(fill = '범례 제목 수정(fill)')
ggplot(HR, aes(x=salary)) + geom_bar(aes(col=salary)) + theme_bw() + labs(col = '범례 제목 수정(col)')
# fill : 도형의 색채우기
# col : 점, 글씨, 선 색을 바꿔줌

# 범례 위치 수정
Graph + theme(legend.position = 'top')
Graph + theme(legend.position = 'bottom')
Graph + theme(legend.position = c(0.9,0.7))
Graph + theme(legend.position = 'none')

# 범례 테두리 설정
Graph + theme(legend.position = 'bottom',
              legend.box.background = element_rect(),
              legend.box.margin = margin(1,1,1,1))