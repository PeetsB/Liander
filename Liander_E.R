#####################################################################################
#
# Liander_E 
#
# - loads libraries
# - calls scripts
#   - Liander_E_read_csv
#   - Liander_E_data_cleaning
#   - Liander_E_visualise_heat_map
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

############ call scripts
# Liander_E_read_csv.R
if(!exists("foo", mode="function")) source("Liander_E_read_csv.R")
# Liander_E_data_cleaning
if(!exists("foo", mode="function")) source("Liander_E_data_cleaning.R")
# Liander_E_visualise_heat_map
if(!exists("foo", mode="function")) source("Liander_E_visualise_heat_map.R")