#####################################################################################
#
# Liander_G data cleaning
#
# - change heading names in row 1
# - delete unnecessary columns "Day"
# - delete all rows with no Datetime
# - migrate string date and time "Datetime" to R time stamp POSIXct
# - Liander dataset is missing first data point for 2009-01-01 00:00 
#   add new row and copy data from 2009-01-01 01:00
#   and delete the last row which is 2010-01-01 00:00
# - add columns "Date" (YYYY-MM-DD) and "Time" (HH) and 
# - add column for Profile_Total_average_kWh which is calculated by
#     hour_fraction_G multiplied with an average natural gas consumption of 1500Nm3 per yer multiplied by
#     the G-gas LCV of 35.17 MJ/Nm3 and divided by 3.6 to yield kWh per hour
#     (kWh is required for comparison with electricity)
#
#####################################################################################

# change heading names in row 1
# set the column headings
col_headings <- c("Datetime",
                  "Day",
                  "Profile_G1a_MJ",
                  "Profile_G2a_MJ",
                  "Profile_Total_MJ",
                  "hour_fraction_G") # refers to Total
names(Liander_G) <- col_headings

# - delete unnecessary columns "Day"
Liander_G$Day          <- NULL

# - delete all rows with no Datetime
Liander_G <- Liander_G[!(Liander_G$Datetime == "" | is.na(Liander_G$Datetime)), ]

# - migrate string date and time "Datetime" to R time stamp POSIXct
# Note that timezone is set to UTC to avoid missing times due to daylight saving time changes
Liander_G[,"Datetime"] <- as.POSIXct(Liander_G[,"Datetime"],
                                  format="%m-%d-%Y %H:%M:%S",
                                  tz ="UTC")

# Liander dataset is missing first data point for 2009-01-01 00:00 
# add new row and copy data from 2009-01-01 01:00
# and delete the last row which is 2010-01-01 00:00
# copy row 1 into temporary variable
# reference: https://stackoverflow.com/questions/11561856/add-new-row-to-dataframe-at-specific-row-index-not-appended
newrow <- Liander_G[1,]
# define number of rows to add
r<-1 
# add copied row 1 into row 1 and bind the rest of the data frame
Liander_G <- rbind(Liander_G[1:1,],newrow,Liander_G[-(1:r),])
# change new row 1 date time 
Liander_G[1,1] <- as.POSIXct('2008-01-01 00:00:00', tz="UTC")
# delete the last row which is 2009-01-01 00:00
Liander_G <- head(Liander_G, -1)

# add columns "Date" (YYYY-MM-DD) and "Time" (HH) for heat map plot
# Date
Liander_G$Date <- as.Date(Liander_G$Datetime) 
# Time in hours as numerical value
Liander_G$Time <- as.numeric(format(as.POSIXct(Liander_G$Datetime) ,format = "%H") )
# add column for Profile_Total_average_kWh which is calculated by
#     hour_fraction_G multiplied with an average natural gas consumption of 1500Nm3 per yer multiplied by
#     the G-gas LCV of 35.17 MJ/Nm3 and divided by 3.6 to yield kWh per hour
#     (kWh is required for comparison with electricity)
Liander_G$Profile_Total_average_kWh <- Liander_G$hour_fraction_G * 1500 * 35.17 / 3.6000 
