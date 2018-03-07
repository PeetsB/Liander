#####################################################################################
#
# Liander_E data cleaning
#
# - change heading names in row 1
# - delete unnecessary columns "Day" and "empty_column"
# - delete all rows with no Datetime
# - migrate string date and time "Datetime" to R time stamp POSIXct
# - Liander dataset is missing first data point for 2009-01-01 00:00 
#   add new row and copy data from 2009-01-01 01:00
#   and delete the last row which is 2010-01-01 00:00
# - add columns "Date" (YYYY-MM-DD) and "Time" (HH) and 
#   add column for Profile_Total_average_kWh = Profile_Total_kWh divided by 10000 houses
#
#####################################################################################

# change heading names in row 1
# set the column headings
col_headings <- c("Datetime",
                  "Day",
                  "Profile_E1a_kWh",
                  "Profile_E1b_kWh",
                  "Profile_Total_kWh",
                  "empty_column",
                  "hour_fraction_E") # refers to Total
names(Liander_E) <- col_headings

# - delete unnecessary columns "Day" and "empty_column"
Liander_E$Day          <- NULL
Liander_E$empty_column <- NULL

# - delete all rows with no Datetime
Liander_E <- Liander_E[!(Liander_E$Datetime == "" | is.na(Liander_E$Datetime)), ]

# - migrate string date and time "Datetime" to R time stamp POSIXct
# Note that timezone is set to UTC to avoid missing times due to daylight saving time changes
Liander_E[,"Datetime"] <- as.POSIXct(Liander_E[,"Datetime"],
                                  format="%m-%d-%Y %H:%M:%S",
                                  tz ="UTC")

# Liander dataset is missing first data point for 2009-01-01 00:00 
# add new row and copy data from 2009-01-01 01:00
# and delete the last row which is 2010-01-01 00:00
# copy row 1 into temporary variable
# reference: https://stackoverflow.com/questions/11561856/add-new-row-to-dataframe-at-specific-row-index-not-appended
newrow <- Liander_E[1,]
# define number of rows to add
r<-1 
# add copied row 1 into row 1 and bind the rest of the data frame
Liander_E <- rbind(Liander_E[1:1,],newrow,Liander_E[-(1:r),])
# change new row 1 date time 
Liander_E[1,1] <- as.POSIXct('2009-01-01 00:00:00', tz="UTC")
# delete the last row which is 2010-01-01 00:00
Liander_E <- head(Liander_E, -1)

# add columns "Date" (YYYY-MM-DD) and "Time" (HH) for heat map plot
# Date
Liander_E$Date <- as.Date(Liander_E$Datetime) 
# Time in hours as numerical value
Liander_E$Time <- as.numeric(format(as.POSIXct(Liander_E$Datetime) ,format = "%H") )
# add column for Profile_Total_average_kWh = Profile_Total_kWh divided by 10000 houses
Liander_E$Profile_Total_average_kWh <- Liander_E$Profile_Total_kWh / 10000