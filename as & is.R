# as : 변수를 ~로 취급하겠다
x = c(1:10)
x1 = as.integer(x)
x2 = as.numeric(x)
x3 = as.factor(x)
x4 = as.character(x)

str(x1) # int [1:10] 1 2 3 4 5 6 7 8 9 10
summary(x1)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.00    3.25    5.50    5.50    7.75   10.00

str(x2) # num [1:10] 1 2 3 4 5 6 7 8 9 10

str(x3) # Factor w/ 10 levels "1","2","3","4",..: 1 2 3 4 5 6 7 8 9 10
summary(x3)
# 1  2  3  4  5  6  7  8  9 10 
# 1  1  1  1  1  1  1  1  1  1 

str(x4) # chr [1:10] "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"
summary(x4)
# Length     Class      Mode 
# 10 character character


# is() : 변수가 ~인지 판단
x = c(1,2,3,4,5,6,7,8,9,10)
y = c("str","str2","str3","str4")

is.integer(x) # FALSE
is.numeric(x) # TRUE
is.factor(y) # FALSE
is.character(y) # TRUE
