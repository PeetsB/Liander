#####################################################################################
#
# Liander_E 
#
# - loads libraries
# - calls scripts
#   - Liander_libraries
#   - Liander_E_read_csv
#   - Liander_E_data_cleaning
#   - Liander_E_visualise_heat_map
# 
#
#####################################################################################



############ call scripts
# Liander_libraries
if(!exists("foo", mode="function")) source("Liander_libraries.R")
# Liander_E_read_csv.R
if(!exists("foo", mode="function")) source("Liander_E_read_csv.R")
# Liander_E_data_cleaning
if(!exists("foo", mode="function")) source("Liander_E_data_cleaning.R")
# Liander_E_visualise_heat_map
if(!exists("foo", mode="function")) source("Liander_E_visualise_heat_map.R")
