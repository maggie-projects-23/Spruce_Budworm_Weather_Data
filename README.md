## Note: In progress.....
Daily station data was downloaded from https://climate.weather.gc.ca/historical_data/search_historic_data_e.html 
using the "weathercan" package in R. 

We used BioClim (https://www.worldclim.org/data/bioclim.html) to find common weather variables used. They are as followed:
1. BIO1 = Annual Mean Temperature
2. BIO2 = Mean Diurnal Range (Mean of monthly (max temp - min temp))
3. BIO3 = Isothermality (BIO2/BIO7) (×100)
4. BIO4 = Temperature Seasonality (standard deviation ×100)
5. BIO5 = Max Temperature of Warmest Month
6. BIO6 = Min Temperature of Coldest Month
7. BIO7 = Temperature Annual Range (BIO5-BIO6)
8. BIO8 = Mean Temperature of Wettest Quarter
9. BIO9 = Mean Temperature of Driest Quarter
10. BIO10 = Mean Temperature of Warmest Quarter
11. BIO11 = Mean Temperature of Coldest Quarter
12. BIO12 = Annual Precipitation
13. BIO13 = Precipitation of Wettest Month
14. BIO14 = Precipitation of Driest Month
15. BIO15 = Precipitation Seasonality (Coefficient of Variation)
16. BIO16 = Precipitation of Wettest Quarter
17. BIO17 = Precipitation of Driest Quarter
18. BIO18 = Precipitation of Warmest Quarter
19. BIO19 = Precipitation of Coldest Quarter

# Spruce_Budworm_Weather_Data
This project performs SQL-based data cleaning and transformation of daily weather data from provience weather stations. The goal is to group weather records by year and compute yearly averages for key weather metrics.

### Overview
The workflow:
- Extracts weather records from a SQLite database.
- Assigns a yearly grouping to each record based on the date field.
- Aggregates daily weather values into yearly averages.
- Stores the aggregated results in a new table.
- Exports the final dataset to a CSV file.


### Steps Performed
1. Group Records by day and then by year
    - Records are grouped using the DENSE_RANK() function applied to the day and then by year extracted from the date column.

    - The results are converted into a pandas DataFrame and saved to a new SQL table:

2. Compute Yearly Averages
The script then creates a new table that contains yearly averages for the following metrics:
    - avg_max_temp
    - avg_min_temp
    - avg_mean_temp
    - avg_total_precip
    
3. Export to CSV
    -The final table is read back into a DataFrame and exported to a CSV file:


## Requirements
- Python 3.x
- pandas
- ipython-sql
- SQLite-compatible database (WEATHER.db)

