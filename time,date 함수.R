# as.Date() : 년-월-일 형태
date_o = "2018-01-02"
date_c = as.Date(date_o, format='%Y-%m-%d')
str(date_o) # chr "2018-01-02"
str(date_c) # Date[1:1], format: "2018-01-02"

# as.POSIXct() : 시간:분:초 까지
date_02 = "2015-02-04 23:13:23"
date_p = as.POSIXct(date_02, format="%Y-%m-%d %H:%M:%s")
str(date_p) # POSIXct[1:1], format: "2015-02-04 23:13:23"

# format(날짜변수, "형식")
format(date_p, "%A") # "수요일"
format(date_p, "%S") # "23"
format(date_p, "%M") # "13"
