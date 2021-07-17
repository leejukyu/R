name <- c('father','mother','daother','son')
age <- c(50,40,15,10)
sex <- c('f','f','f','m')
family <- data.frame(name,age,sex)
family
name[2]
sex[3]
family[2]
family[1,]
family[1:2,3]
family[1,3] <- 'm'
family
