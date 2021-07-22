library(ggplot2)
library(ggthemes)

HR = read.csv('C:/R/basic/HR_comma_sep.csv')
HR$left = as.factor(HR$left)
HR$salary = factor(HR$salary, levels = c("low",'medium','high'))

#classic Theme
ggplot(HR, aes(x=salary)) + geom_bar(aes(fill=salary)) + theme_classic()

# BW Theme
ggplot(HR, aes(x = salary)) + geom_bar(aes(fill=salary)) + theme_bw()

Graph = ggplot(HR, aes(x=salary)) + geom_bar(aes(fill=salary))
Graph + theme_bw() + ggtitle('Theme_bw')
Graph + theme_classic() + ggtitle('Theme_classic')
Graph + theme_dark() + ggtitle('Theme_dark')
Graph + theme_light() + ggtitle('Theme_light')

Graph + theme_linedraw() + ggtitle('Theme_linedraw')
Graph + theme_minimal() + ggtitle('Theme_minimal')
Graph + theme_test() + ggtitle('Theme_test')
Graph + theme_void() + ggtitle('Theme_void')
