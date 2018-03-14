#####################################################################################
#
# Liander_E_visualise_heat_map
#
# - 
#
#####################################################################################

# laad required libraries
lapply(libraries, FUN = function(y) {
  do.call('require', list(y))})

options(scipen=999)  # turn off scientific notation like 1e+06

# create heat map reference: https://benjaminlmoore.wordpress.com/tag/ggplot2/
hm.palette <- colorRampPalette(rev(brewer.pal(11, 'Spectral')), space='Lab')
Liander_E_heat_map <- ggplot(Liander_E, aes(y=Time, x=Date)) + 
  geom_tile(aes(fill=Profile_Total_average_kWh)) +
  theme(legend.position="bottom", 
        panel.background = element_blank(),
        plot.background = element_blank()) +
  scale_y_continuous(name = "Hour of day", 
                     breaks = seq(0, 23, by=1)) + 
  scale_x_date(name = "Month of year", 
               breaks = seq(as.Date("2009-01-15"), 
                            as.Date("2009-12-15"), 
                            by = "1 month"), date_labels ="%B") +
  guides(fill = guide_colourbar(title.position = "bottom",
                                title.hjust = .5,
                                label.position = "bottom"))  
Liander_E_heat_map <- Liander_E_heat_map +
  scale_fill_gradientn(colours = hm.palette(100),
                       name = "kWh electricity",
                       limits = c(0, max(Liander_E$Profile_Total_average_kWh, na.rm=T)))
#                       limits = c(0, max(Liander_G$Profile_Total_average_kWh, na.rm=T)))