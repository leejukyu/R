# 1. sample()을 활용해서 로또번호를 추첨
sample(1:45, 6)

# 2. 수열로 구성된 벡터를 생성하시오
# 2-1. AV = (1,3,5,7,8,...,99)
AV = seq(from = 1, to = 100, by = 2)
# 2-2. BV = (1,1,2,2,3,3,4,4,5,5)
BV = rep(c(1:5),c(rep(2,5)))

# 3. 3행 3열의 핼열을 생성하시오
matrix(1:9, nrow = 3, ncol = 3)

# Q(x,y) = x^2 + y + 10 함수를 만드시오
Q = function(x,y){
  x*x + y + 10
}

# for문을 이용하여 구구단을 만드시오.
for(i in 1:9){
  for (j in 1:9){
    print(paste(i,"*",j,"=",i*j))
  }
}
