library(dplyr)
stock = read.csv('C:/R/basic/Uniqlo_stocks2012-2016.csv')
stock$Date = as.Date(stock$Date)
stock$Year = as.factor(format(stock$Date,'%Y'))
stock$Day = as.factor(format(stock$Date, '%a'))
str(stock)

# 집계 데이터 만들기
# goup_by : 집계 기준 변수를 정해주는 명령어
Group_Data = stock %>%
  group_by(Year,Day) %>%
  summarise(Mean = round(mean(Open)),
            Median = round(median(Open)),
            Max = round(max(Open)),
            Counts = length(Open))
# ungoup : 그룹으로 묶인 데이터를 해제 시켜주는 명령어, 에러방지
Ungroup_Data = Group_Data %>%
  ungroup()
str(Group_Data)
str(Ungroup_Data)
# 기본적으로 데이터 프레임 형태가 아니므로 꼭 strings로 변경
# count
Count_Data = stock %>%
  group_by(Year, Day) %>%
  count()


# 조건에 따라 데이터 추출
Subseted_Data = Group_Data %>%
  filter(Year == '2012')
head(Subseted_Data)


# 데이터 중복 제거
SL = sample(1:nrow(Group_Data), 500, replace = TRUE) # 중복을 허용하여 500개로 증가
Duplicated_Data = Group_Data[SL,] 
Duplicated_Data2 = Duplicated_Data %>%
  distinct(Year,Day,Mean,Median,Max,Counts)


# 샘플 데이터 무작위 추출
sample_frac_Gr = Group_Data %>%
  sample_frac(size = 0.4, replace = FALSE)
# 각 년도에서 2개씩 균형있게 샘플링됨
sample_frac_Un = Ungroup_Data %>%
  sample_frac(size = 0.4, replace=FALSE)

sample_N_Gr = Group_Data %>%
  sample_n(size = 5, replace = FALSE)
sample_N_Un = Ungroup_Data %>%
  sample_n(size = 10, replace = FALSE)


# 정해진 index에 따라 데이터 추출하기
# slice() : 인덱스를 직접 설정해서 원하는 구간만
Slice_Data = Ungroup_Data %>%
  slice(1:10)
# top_n() : 설정해준 변수를 기준으로 가장 값이 높은 n개
Top_n_Data = Ungroup_Data %>%
  top_n(5,Mean) # Mean이 가장 높은 5개 데이터 추출출


# 데이터 정렬하기
# 오름차순
Asce_Data = Ungroup_Data %>%
  arrange(Mean) # Mean을 기준으로 오름차순 정렬
# 내림차순
Desc_Data = Ungroup_Data %>%
  arrange(-Mean)


# 원하는 변수만 뽑아내기
# select() : 인덱스나, 변수명으로
Select_Data = Group_Data %>%
  select(1:2)
select_data = Group_Data %>%
  select(Year,Day)
# select_if() : 조건을 통해 
select_if_data1 = Group_Data %>%
  select_if(is.factor)
select_if_data2 = Group_Data %>%
  select_if(is.integer)


# 새로운 변수 만들기 혹은 한번에 처리하기
# mutate() : 하나의 변수를 명령어에 따라 추가
Mutate_Data = stock %>%
  mutate(Divided = round(High/Low,2)) %>%
  select(Date,High,Low,Divided)
# mutate_if() : 지정해준 모든 변수에 계산식 적용
Mutate_if_data = stock %>%
  mutate_if(is.integer, as.numeric())
Mutate_at_data = stock %>%
  mutate_at(vars(-Date, -Year, -Day), log) %>%
  select_if(is.numeric)
# Date, Year, Day  를 제외하고 모두 log변환