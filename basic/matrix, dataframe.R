# matrix(data = 데이터, nrow = 행의 수 , ncol = 열의 수 , byrow = 행/열 기준)
matrix_r = matrix(data = x1, nrow = 5)
print(matrix_r)

matrix_c = matrix(data = x1, ncol = 5)
print(matrix_c)

# dataframe생성
data_set = data.frame(X1 = x1, X1_seq = x1_seq, x2 = x2, y = y)
print(data_set)
