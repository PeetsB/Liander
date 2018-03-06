# load reaquired libraries
if (!require("ggplot2")) {
  install.packages("ggplot2")
  library(ggplot2)
}

#Load the package or install if not present
if (!require("RColorBrewer")) {
  install.packages("RColorBrewer")
  library(RColorBrewer)
}

# for Mac OS X
setwd("~/R/Liander")
# for Linux Mint LMDB2
# setwd("/media/psf/Home/R/Liander")

if(!exists("foo", mode="function")) source("read_csv_test.R")

# divide by 10000 "customers" to achieve average customer demand
Liander_E$Profile_Total_kWh <- Liander_E$Profile_Total_kWh/10000

# Simple ggplot
options(scipen=999)  # turn off scientific notation like 1e+06

#data(MyData, package = "ggplot2")  # load the data
# Init Ggplot
#ggplot(MyData, aes(x=Datetime, y=Totaal)) +geom_point() +
#  scale_y_continuous(breaks = round(seq(0, max(MyData$Totaal), by = 0.05),1))


# create heat map reference: https://benjaminlmoore.wordpress.com/tag/ggplot2/
hm.palette <- colorRampPalette(rev(brewer.pal(11, 'Spectral')), space='Lab')
ggplot(Liander_E, aes(y=Time, x=Day)) + 
  geom_tile(aes(fill=Profile_Total_kWh)) +
  scale_fill_gradientn(colours = hm.palette(100)) + 
  scale_y_continuous(name = "Hour of day", 
                     breaks = seq(0, 23, by=1)) + 
  scale_x_date(name = "Month of year", 
               breaks = seq(as.Date("2009-01-15"), 
                            as.Date("2009-12-15"), 
                            by = "1 month"), date_labels ="%B") +
  theme(panel.background = element_blank(),
        plot.background = element_blank())

