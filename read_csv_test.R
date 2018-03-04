# set the working directory
setwd("~/R/Liander")

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