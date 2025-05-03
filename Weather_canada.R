# Import packages
library(weathercan)
library(dplyr)
setwd("/Users/maggiesullens/Library/Mobile Documents/com~apple~CloudDocs/Spruce Budworm/Retrieved weather")

all_stations <- stations()
stations <- subset(all_stations, prov == "NB" & interval=="day")
head(stations)

# Define batch size (this is the number of stations in each batch)
batch_size <- 20  

# Create a list of station ID subsets
station_batches <- split(stations$station_id, 
                         ceiling(seq_along(stations$station_id) / batch_size))

# Create an empty list to store  Quebec weather data
qc_weather_list <- list()

#Create a for loop to cycle through all the batches
  for (i in 1:length(station_batches)){
    if(!file.exists(paste0("nb_weather_chunk_",i,".RData"))){
    cat("Downloading batch", i, "of", length(station_batches), "...\n")
    
    # Download data for the current batch
    weather_data <- weather_dl(station_ids = station_batches[[i]], interval = "day")
    
    # Select only the "date", "temp_min", "total_precip" columns
    weather_data <- weather_data %>% 
      select(prov, station_name, station_id,
                              lat, lon, elev, date, max_temp, mean_temp, min_temp, total_precip)
    weather_data <- weather_data %>% 
      filter(!is.na(date) & !is.na(max_temp) & !is.na(mean_temp) & !is.na(min_temp) & !is.na(total_precip))
    
    cat("Saving batch", i, "of", length(station_batches), "...\n")
    save(weather_data, file=paste0("nb_weather_chunk_",i,".RData"))
  } else{
    
    cat("Loading batch", i, "of", length(station_batches), "...\n")
    load(file=paste0("nb_weather_chunk_",i,".RData"))
  }
    weather_list[[i]] <- weather_data
  }
length(weather_list)
 weather <- bind_rows(weather_list)
 
 write.csv(weather, "nb_weather.csv", row.names = FALSE)
