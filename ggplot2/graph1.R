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


# Bar Chart
# 이산형 변수 시각화 그래프, 기본적으로 y 축은 따로 설정할 필요 X
ggplot(Group_Data) + geom_bar(aes(x = as.factor(Counts), fill=..count..)) +
  xlab("") + ylab("") +
  scale_fill_gradient(low = '#CCE5FF', high = '#FF00FF') +
  theme_classic() + ggtitle('Continuous Color')

ggplot(Group_Data) + geom_bar(aes(x = as.factor(Counts), fill=Day), alpha = 0.4) +
  xlab("") + ylab("") +
  theme_classic() + ggtitle('Discrete Color')

# 색 구분 포지션을 변경하고 싶은 경우
ggplot(Group_Data) + 
  geom_bar(aes(x = as.factor(Counts), fill=Day), alpha = 0.4, position = 'dodge') +
  xlab("") + ylab("") +
  theme_classic() + ggtitle('Discrete Color\n position Dodge')

# x축, y축 1개씩 총 변수 2개로 그리는 경우, stat = identity
ggplot(Group_Data) + geom_bar(aes(x = Year, y = Mean, fill=Day), stat = 'identity') +
  scale_fill_manual(values = c('#C2DAEF', '#C2EFDD','#BBAAE9','#E9F298','#FABDB3')) +
  theme_classic()



# Histogram
# 연속형 변수를 시각화
ggplot(stock) + geom_histogram(aes(x = High, fill = ..x..), binwidth = 1000) +
  scale_fill_gradient(low = '#CCE5FF', high = '#FF00FF') +
  theme_classic() + labs(fill = 'Lables Name')

ggplot(stock) + geom_histogram(aes(x = High, fill = Day), binwidth = 1000, alpha = 0.4) +
  theme_classic() + labs(fill = 'Lables Name')

ggplot(stock) + geom_histogram(aes(x = High, fill = Day), binwidth = 1000, alpha = 0.4, position = 'dodge') +
  theme_classic() + labs(fill = 'Lables Name')


# Density plot
# 그래프 면적이 각각의 비율이 되도록 맞춰 줌
ggplot(stock) + geom_density(aes(x = High)) +  theme_classic() + labs(fill = 'Lables Name')

ggplot(stock) + geom_density(aes(x = High, fill = Day), alpha = 0.4) +
  theme_classic() + labs(fill = 'Lables Name') +
  theme(axis.text.x = element_text(size = 9, angle = 45, hjust = 1))
