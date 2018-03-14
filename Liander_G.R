#####################################################################################
#
# Liander_G 
#
# - loads libraries
# - calls scripts
#   - Liander_G_read_csv
#   - Liander_G_data_cleaning
#   - Liander_G_visualise_heat_map
# 
#
#####################################################################################

# load reaquired libraries
# gglplot2: Load the package or install if not present
if (!require("ggplot2")) {
  install.packages("ggplot2")
  library(ggplot2)
}

# RColorBrewer: Load the package or install if not present
if (!require("RColorBrewer")) {
  install.packages("RColorBrewer")
  library(RColorBrewer)
}

# gridExtra: Load the package or install if not present
if (!require("gridExtra")) {
  install.packages("gridExtra")
  library(gridExtra)
}

############ call scripts
# Liander_G_read_csv.R
if(!exists("foo", mode="function")) source("Liander_G_read_csv.R")
# Liander_G_data_cleaning
if(!exists("foo", mode="function")) source("Liander_G_data_cleaning.R")
# Liander_G_visualise_heat_map
if(!exists("foo", mode="function")) source("Liander_G_visualise_heat_map.R")