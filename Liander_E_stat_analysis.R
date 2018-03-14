#####################################################################################
#
# Liander_E Statistical analysis per day
#
# - min
# - average
# - max
#
#####################################################################################
library(ggplot2)

Liander_E_days <- data.frame(Date=as.Date(character()),
                  Minimum=numeric(), 
                  Average=numeric(), 
                  Maximum=numeric(),
                 stringsAsFactors=FALSE) 

uniq <- unique(unlist(Liander_E$Date))
for (i in 1:length(uniq)){
  Liander_E_day <- subset(Liander_E, Date == uniq[i])
  newrow2 <- data.frame(Liander_E_day$Date[1],
                       min(Liander_E_day$Profile_Total_average_kWh),
                       mean(Liander_E_day$Profile_Total_average_kWh),
                       max(Liander_E_day$Profile_Total_average_kWh)
                       )
  Liander_E_days <- rbind(Liander_E_days, newrow2)
}
col_headings <- c("Day",
                  "Min",
                  "Mean",
                  "Max")
names(Liander_E_days) <- col_headings

ggplot(Liander_E_days) + 
  geom_line(aes(Day,Mean), colour = "blue") +
  geom_ribbon(aes(ymin=Min,ymax=Max, x=Day, fill = "band"), alpha = 0.3)+
  scale_colour_manual("",values="blue")+
  scale_fill_manual("",values="grey12") +
  scale_x_date(name = "Month of year", 
              breaks = seq(as.Date("2009-01-15"), 
                            as.Date("2009-12-15"), 
                            by = "1 month"), date_labels ="%B") +
  scale_y_continuous(name = "Energy use per hour in kWh")

ggplot(Liander_E, aes(x=Date, y=Profile_Total_average_kWh)) +geom_point(size=.25)
