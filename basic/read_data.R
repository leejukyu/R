# 기본 경로 설정하기
# CTRL + SHIGT + H : 열기로 쉽게 경로 지정 가능
setwd("C:/python/전처리/2. 탐색적 데이터 분석/데이터")

# csv 파일 읽기
customers_readcsv <- read.csv("Telco_customer_info.csv")

# data.table - fread: 빠르게 데이터를 읽고 처리하는 라이브러리
library(data.table)
customers_fread <- fread("Telco_customer_info.csv")

# dplyr - tibble: 데이터도 빠르게 읽어오고 어떤 타입인지, 컬럼까지 다 나옴
library(dplyr)
customers_fread %>% tibble()
tibble(customers_fread)

# xlsx 파일 읽기
library(readxl)
kospi_xlsx <-read_excel("2018-20_코스피지수.xlsx", sheet = "sheet1")
kospi_xlsx <-read_excel("2018-20_코스피지수.xlsx", sheet = 2)

# gsheet 파일 읽기
install.packages("googlesheets4")
library(googlesheets4)
gsheet_link <- "https://docs.google.com/spreadsheets/d/1xAFvq_aBNBxoAFOZkFcNwpRIN7QpzJ-V6N7oQvNAWjA/edit#gid=0"

customers_gsheet <- read_sheet(gsheet_link, sheet = "customers")
test_gsheet <- read_sheet(gsheet_link,sheet = "test")

# 데이터 저장하기
write.csv(customers_readcsv, "write_name.csv", row.names = F)