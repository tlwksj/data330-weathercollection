# get_emmitsburg_temp.R

library(httr)
library(jsonlite)
library(readr)

#res <- GET("https://api.weather.gov/stations/KHGR/observations/latest")
data <- fromJSON("https://api.weather.gov/stations/KHGR/observations/latest")

temp_c <- data$properties$temperature$value
temp_f <- temp_c * 9/5 +32

wind_speed_km <- data$properties$windSpeed$value
wind_speed_mi <- round(wind_speed_km / 1.6,3)

df <- data.frame(
  time = format(Sys.time(), tz = "America/New_York", usetz = TRUE),
  station = "KHGR",
  temp_c = temp_c,
  temp_f = temp_f,
  wind_speed_km = wind_speed_km,
  wind_speed_mi = wind_speed_mi
)

dir.create("data", showWarnings = FALSE)

file <- "data/emmitsburg_weather.csv"

if(file.exists(file)){
  write_csv(df, file, append = TRUE)
} else{
  write_csv(df,file)
}
