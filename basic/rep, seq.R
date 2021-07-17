a = 2
print(a)
# a = 2

a == 2
# TRUE
a != 2
# FALSE

b = c(2,3,4,5)
print(b)
# 2 3 4 5


# seq() : 순차적 데이터 생성
# 1~10까지 1씩 증가하는 수열 생성
x1 = c(1:10)
print(x1)
# 1 2 3 4 5 6 7 8 9 10
x1_seq = seq(from = 1, to = 10, by = 1)
print(x1_seq)
# 1 2 3 4 5 6 7 8 9 10

# 1~10까지 2씩 증가하는 수열 생성
x2 = seq(from = 1, to = 10, by = 2)
print(x2)
# 1 3 5 7 9

# rep(): 반복적인 수열 생성
# 1을 10번 반복
y = rep(1,10)
print(y)
# 1 1 1 1 1 1 1 1 1 1

y2 = rep(c(1,10), 2)
print(y2)
# 1 10  1 10

y3 = rep(c(1,10),c(2,2))
print(y3)
# 1  1 10 10