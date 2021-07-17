# 무작위 추출
# replace = False : 비복원 추출

# sample(데이터범위, 개수, replace = )
s1 = sample(1:45, 6, replace = FALSE)
print(s1)
# 1  2 26 31 17  4

# set.seed() : 무작위 값 고정
set.seed(1234)
s2 = sample(1:45, 6, replace = FALSE)
print(s2) # 28 16 22 37  9  5


# A 안에 7이 있는지 확인하는 조건문
A = c(1,2,3,4,5)

if (7 %in% A){
  print("TRUE")
} else{
  print("FALSE")
}
# "FALSE"


# 