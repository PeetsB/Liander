#####################################################################################
#
# Liander_G_read_csv
#
# - 
#
#####################################################################################

# set the working directory
# for Mac OS X
setwd("~/R/Liander")
# for Linux Mint LMDB2
#setwd("/media/psf/Home/R/Liander")

# load the data
Liander_G <- read.csv(file="dagprofielen gas.csv",  
                   header = TRUE,
                   sep = ";",
                   dec=",", 
                   skip=1,                     # skip first row - not of interest
                   encoding = "latin1",
                   stringsAsFactors = FALSE
)

