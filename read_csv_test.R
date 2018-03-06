# set the working directory
# for Mac OS X
setwd("~/R/Liander")
# for Linux Mint LMDB2
#setwd("/media/psf/Home/R/Liander")

# load the data
Liander_E <- read.csv(file="dagprofielen elektriciteit.csv",  
                   header = TRUE,
                   sep = ";",
                   dec=",", 
                   skip=1,
                   encoding = "latin1",
                   stringsAsFactors = FALSE
)

col_headings <- c("Datetime",
                  "Day",
                  "Profile_E1a_kWh",
                  "Profile_E1b_kWh",
                  "Profile_Total_kWh",
                  "empty_column",
                  "hour_fraction_E") # refers to Total
names(Liander_E) <- col_headings

Liander_E$Day          <- NULL
Liander_E$empty_column <- NULL

Liander_E <- Liander_E[!(Liander_E$Datetime == "" | is.na(Liander_E$Datetime)), ]

# migrate string date and time to Time stamp
Liander_E[,"Datetime"] <- as.POSIXct(Liander_E[,"Datetime"],
                                  format="%m-%d-%Y %H:%M:%S",
                                  tz ="UTC")

# for heat map add culomns
# Date only
Liander_E$Day <- as.Date(Liander_E$Datetime) 
# Time in hours as numerical value
Liander_E$Time <- as.numeric(format(as.POSIXct(Liander_E$Datetime) ,format = "%H") )
# insert a new row 
newrow <- Liander_E[1,]
r<-1 
Liander_E <- rbind(Liander_E[1:1,],newrow,Liander_E[-(1:r),])
Liander_E[1,1] <- as.POSIXct('2009-01-01 00:00:00', tz="UTC")
Liander_E$Time[1] <- 0
Liander_E <- head(Liander_E, -1)