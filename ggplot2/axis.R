library(ggplot2)

HR = read.csv('C:/R/basic/HR_comma_sep.csv')
HR$left = as.factor(HR$left)
HR$salary = factor(HR$salary, levels = c("low",'medium','high'))

# 축변경
# 축 변수가 discrete인지 continuous인지 먼저 확인
# x 축 이산형 -> scale_x_discrete()
# x 축 연속형 -> scale_x_continuous()
# y 축 이산형 -> scale_y_discrete()
# y 축 연속형 -> scale_y_continuous()
ggplot(HR, aes(x=salary)) + geom_bar(aes(fill=salary)) + theme_bw() + 
  scale_x_discrete(expand = c(0,0), labels = c('하', '중', '상')) +
  scale_y_continuous(expand = c(0,0), breaks = seq(0,8000,by=1000)) +
  scale_fill_discrete(labels = c('하','중','상'))
# expand : 그래프 테두리에 맞추어 그리게 해주는 옵션
# 이산형에서는 labels, 연속형에서는 breaks로 축 변경
# scale_fill_discrete() : 범례의 표시 변경


# 축 범위 설정
ggplot(HR,aes(x = salary)) + geom_bar(aes(fill = salary)) + theme_bw() + ylim(0,5000)
ggplot(HR,aes(x = salary)) + geom_bar(aes(fill = salary)) + theme_bw() + ylim(0,13000)


# 색 변경
# scale_fill_manual() or scale_color_manual()
ggplot(HR,aes(x = salary)) + geom_bar(aes(fill = salary)) + theme_bw() + scale_fill_manual(values = c('red','royalblue','tan'))
ggplot(HR,aes(x = salary)) + geom_bar(aes(fill = salary), alpha=0.4) + theme_bw() + scale_fill_manual(values = c('red','royalblue','tan'))


# 그래프 분할 및 대칭이동
ggplot(HR,aes(x = salary)) + geom_bar(aes(fill = salary)) + theme_bw() + scale_fill_manual(values = c('red','royalblue','tan')) + coord_flip()
ggplot(HR,aes(x = salary)) + geom_bar(aes(fill = salary)) + theme_bw() + scale_fill_manual(values = c('red','royalblue','tan')) +
  guides(fill = FALSE) + facet_wrap(~left, ncol = 1)
# guides : 범례 없애기 가능
# coord_flip() : x축, y축 대각선 대칭
# facet_wrap() : 그래프를 분할하고 싶은 변수의 기준을 입력하고 ncol로 몇 개의 열로 표현할지 정함

# 글자 크기, 각도 수정
ggplot(HR,aes(x = salary)) + geom_bar(aes(fill = salary)) + theme_bw() + scale_fill_manual(values = c('red','royalblue','tan')) +
  coord_flip() + theme(legend.position = 'none',
                       axis.text.x = element_text(size = 15, angle = 90),
                       axis.text.y = element_text(size = 15),
                       legend.text = element_text(size = 15))
