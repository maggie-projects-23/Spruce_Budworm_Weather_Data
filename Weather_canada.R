# Import packages
library("weathercan")
library(dplyr)
setwd("/Users/maggiesullens/Library/Mobile Documents/com~apple~CloudDocs/Spruce Budworm/Retrieved weather")

all_stations <- stations()
qc_stations <- subset(all_stations, prov == "QC" & interval=="day")
head(qc_stations)

# Define batch size (this is the number of stations in each batch)
batch_size <- 20  

# Create a list of station ID subsets
qc_station_batches <- split(qc_stations$station_id, 
                         ceiling(seq_along(qc_stations$station_id) / batch_size))

# Create an empty list to store  Quebec weather data
qc_weather_list <- list()

#Create a for loop to cycle through all the batches
  for (i in 1:length(qc_station_batches)){
    if(!file.exists(paste0("qc_weather_chunk_",i,".RData"))){
    cat("Downloading batch", i, "of", length(qc_station_batches), "...\n")
    
    # Download data for the current batch
    qc_weather_data <- weather_dl(station_ids = qc_station_batches[[i]], interval = "day")
    
    # Select only the "date" and "temp_min" columns
    qc_weather_data <- qc_weather_data %>% 
      select(prov, station_name, station_id,
                              lat, lon, elev, date, max_temp, mean_temp, min_temp, total_precip)
    qc_weather_data <- qc_weather_data %>% 
      filter(!is.na(date) & !is.na(max_temp) & !is.na(mean_temp) & !is.na(min_temp) & !is.na(total_precip))
    
    cat("Saving batch", i, "of", length(qc_station_batches), "...\n")
    save(qc_weather_data, file=paste0("qc_weather_chunk_",i,".RData"))
  } else{
    
    cat("Loading batch", i, "of", length(qc_station_batches), "...\n")
    load(file=paste0("qc_weather_chunk_",i,".RData"))
  }
    qc_weather_list[[i]] <- qc_weather_data
  }
length(qc_weather_list)
 qc_weather <- bind_rows(qc_weather_list)
