# load reaquired libraries
library(ggplot2)
#Load the package or install if not present
if (!require("RColorBrewer")) {
  install.packages("RColorBrewer")
  library(RColorBrewer)
}

# set the working directory
setwd("~/Downloads")

# load the data
MyData <- read.csv(file="dagprofielen_elektriciteit.csv",  
                   header = TRUE,
                   sep = ";",
                   dec=",", 
                   skip=0,
                   encoding = "latin1",
                   stringsAsFactors = FALSE
)

# migrate string date and time to Time stamp
MyData[,"Datetime"] <- as.POSIXct(MyData[,"Datetime"],
                                  format="%m-%d-%Y %H:%M:%S")

# divide by 10000 "customers" to achieve average customer demand
MyData$Totaal <- MyData$Totaal/10000

# Simple ggplot
options(scipen=999)  # turn off scientific notation like 1e+06

#data(MyData, package = "ggplot2")  # load the data
# Init Ggplot
#ggplot(MyData, aes(x=Datetime, y=Totaal)) +geom_point() +
#  scale_y_continuous(breaks = round(seq(0, max(MyData$Totaal), by = 0.05),1))

# for heat map add culomns
# Date only
MyData$Day <- as.Date(MyData$Datetime) 
# Time in hours as numerical value
MyData$Time <- as.numeric(format(as.POSIXct(MyData$Datetime) ,format = "%H") )

# create heat map reference: https://benjaminlmoore.wordpress.com/tag/ggplot2/
hm.palette <- colorRampPalette(rev(brewer.pal(11, 'Spectral')), space='Lab')
ggplot(MyData, aes(y=Time, x=Day)) + 
  geom_tile(aes(fill=Totaal)) +
  scale_fill_gradientn(colours = hm.palette(100)) + 
  scale_y_continuous(name = "Hour of day", 
                     breaks = seq(0, 23, by=1),
                    ) + 
  scale_x_date(name = "Month of year", 
               breaks = seq(as.Date("2009-01-15"), 
                            as.Date("2009-12-15"), 
                            by = "1 month"), date_labels ="%B") +
  theme(panel.background = element_blank(),
        plot.background = element_blank())

