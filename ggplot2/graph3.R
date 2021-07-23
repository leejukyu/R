library(ggplot2)
library(dplyr)

stock = read.csv('C:/R/basic/Uniqlo_stocks2012-2016.csv')

stock$Date = as.Date(stock$Date)
stock$Year = as.factor(format(stock$Date, '%Y'))
stock$Day = as.factor(format(stock$Date, '%a'))

Group_Data = stock %>%
  group_by(Year,Day) %>%
  dplyr::summarise(Mean = round(mean(Open)),
                   Median = round(median(Open)),
                   Max = round(max(Open)),
                   Counts = length(Open))

# Scatter plot
# 데이터의 상관관계 파악
ggplot(stock) + geom_point(aes(x=Open, y = Stock.Trading, col = High, size = log(Volume), shape=Year)) +
  scale_color_gradient(low = '#CCE5FF', high = '#FF00FF') +
  scale_shape_manual(values = c(19,20,21,22,23)) +
  labs(col = 'color', shape = 'shape', size = 'size') +
  theme_bw() + theme(axis.text.x = element_blank())

# Smooth plot
# geom_smooth 는 회귀선
ggplot(stock) + geom_smooth(aes(x=Open, y=Stock.Trading), method = 'lm', col = '#8A8585') + theme_bw()
ggplot(stock) + geom_point(aes(x=Open, y=Stock.Trading,), col = 'royalblue', alpha = 0.2) +
  geom_smooth(aes(x=Open, y=Stock.Trading), method='lm', col = '#8A8585') + theme_bw()

# abline, vline, hline
# 평행선, 수직선, 대각선
ggplot(NULL) + geom_vline(xintercept = 10, linetype = 'dashed', col = 'royalblue', size = 3) +
  geom_hline(yintercept = 10, linetype = 'dashed', col = 'royalblue', size = 3) +
  geom_abline(intercept = 0, slope = 1, col = 'red', size = 3) + theme_bw()

# Step plot
# 계단 형식의 그래프, 값의 증가량을 나타낼 때 효과적
Hazard_Ratio = c(0.1,0.3,0.4,0.45,0.49,0.52,0.6,0.65,0.75,0.8,0.95)
Survival_Time = c(1,2,3,4,5,6,7,8,9,10,11)
ggplot(NULL) + geom_step(aes(x = Survival_Time, y = Hazard_Ratio), col = 'red') +
  scale_x_continuous(breaks = Survival_Time) + theme_classic()
