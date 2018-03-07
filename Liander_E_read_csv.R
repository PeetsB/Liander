#####################################################################################
#
# Liander_E_read_csv
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
Liander_E <- read.csv(file="dagprofielen elektriciteit.csv",  
                   header = TRUE,
                   sep = ";",
                   dec=",", 
                   skip=1,                     # skip first row - not of interest
                   encoding = "latin1",
                   stringsAsFactors = FALSE
)

