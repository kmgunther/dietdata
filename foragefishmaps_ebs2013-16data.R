#Mapping with R

library("ggplot2")
theme_set(theme_bw())
library("sf")
library("rnaturalearth")
library("rnaturalearthdata")
library("rgeos")

#World map contrained to AK
ggplot(data=world)+
      geom_sf()+
      coord_sf(xlim = c(-180, -140), ylim = c(50,72))

#Scale bar and North arrow
library("ggspatial")
ggplot(data = world) +
      geom_sf() +
      annotation_scale(location = "bl", width_hint = 0.5) +
      annotation_north_arrow(location = "br", which_north = "true", 
                             pad_x = unit(0.5, "in"), pad_y = unit(0.5, "in"),
                             style = north_arrow_fancy_orienteering) +
      coord_sf(xlim = c(-180, -140), ylim = c(50,72))


#Point data
sandlance <- data.frame(read.csv("ammodytes_13.16_latlong.csv"))
herring <- data.frame(read.csv("herring_13.16_latlong.csv"))
capelin <- data.frame(read.csv("capelin_13.16_latlong.csv"))
eulachon <- data.frame(read.csv("eulachon_13.16_latlong.csv"))
      
#separate and plot in grid view
sl <- ggplot(data = world) +
            geom_sf() +
            geom_point(data = sandlance, aes(x=LONGITUDE, y=LATITUDE), size = 2, 
                 shape = 23, fill = "darkred", alpha=0.4) +
            ggtitle("Ammodytes sp. 2013-2016")+
            xlab(NULL)+ylab(NULL)+
            annotation_scale(location = "br", width_hint = 0.5) +
            annotation_north_arrow(location = "bl", which_north = "true", 
                             pad_x = unit(0.1, "in"), pad_y = unit(0.5, "in"),
                             style = north_arrow_fancy_orienteering) +
            coord_sf(xlim = c(-180, -155), ylim = c(52,65))
herr <- ggplot(data = world) +
            geom_sf() +
            geom_point(data = herring, aes(x=LONGITUDE, y=LATITUDE), size = 2, 
                 shape = 22, fill = "blue", alpha = 0.4) +
            ggtitle("Clupea pallasii 2013-2016")+
            xlab(NULL)+ylab(NULL)+
            coord_sf(xlim = c(-180, -155), ylim = c(52,65))
cape <- ggplot(data = world) +
            geom_sf() +
            geom_point(data = capelin, aes(x=LONGITUDE, y=LATITUDE), size = 2, 
                 shape = 21, fill = "green", alpha = 0.5) +
      ggtitle("Mallotus villosus 2013-2016")+
      xlab(NULL)+ylab(NULL)+
            coord_sf(xlim = c(-180, -155), ylim = c(52,65))
eul <- ggplot(data = world) +
      geom_sf() +
      geom_point(data = eulachon, aes(x=LONGITUDE, y=LATITUDE), size = 2, 
                 shape = 24, fill = "yellow", alpha = 0.4) +
      ggtitle("Thaleichthys pacificus 2013-2016")+
      xlab(NULL)+ylab(NULL)+
      coord_sf(xlim = c(-180, -155), ylim = c(52,65))

library(gridExtra)
grid.arrange(sl, herr, cape, eul, ncol=2, nrow=2)
