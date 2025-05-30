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

Degree days were calulated using the method that has $\frac{(T_{Max}-T_{Min})}{2}=T_{Base}$ when $\frac{(T_{Max}-T_{Min})}{2}<T_{Base}$ (https://digitalcommons.unl.edu/cgi/viewcontent.cgi?article=1086&context=usdaarsfacpub). $T_{Base}=8\degree C$ (https://academic.oup.com/jee/article-abstract/82/4/1161/2215153)

### Overview
The workflow:
- Extracts weather records from a SQLite database.
- Assigns a yearly grouping to each record based on the date field.
- Aggregates daily weather values into yearly averages and calulates BioClim variables.
- Formulates Degree Days
- Stores the aggregated results in a new table.
- Exports the final datasets to a CSV file.


### Steps Performed
1. Group Records by day and then by year
    - Records are grouped using the DENSE_RANK() function applied to the day and then by year extracted from the date column.

    - The results are converted into a pandas DataFrame and saved to a new SQL table:

2. Compute Daily, Monthly Quarterly Variables in respective tables in order to calulate BioClim Variables
    - Daily Variables include:
    	 - avg_max_temp
     	 - avg_min_temp
    	 - avg_mean_temp
    	 - avg_total_precip
    - Monthly Variables include:
   		- month_avg_max_temp
   		- month_avg_min_temp
   		- month_avg_mean_temp
   		- month_max_temp
   		- month_min_temp
   		- mean_diurnal_range
   		- month_total_precip
    - Quarterly Variables include:
    	- quarter_avg_max_temp
     	- quarter_avg_min_temp
      	- quarter_avg_mean_temp
      	- quarter_total_precip
			
4. Compute Yearly Averages and BioClim Variables
The script then creates a new table that contains yearly averages for the following metrics along with all the BioClim variables listed previously:
    - avg_max_temp
    - avg_min_temp
    - avg_mean_temp
    - avg_total_precip
      
5. Add Degree Days
    - Add Degree Days to Daily table
    - Create Temporary table to store the accumlation of Degree Days for each year
    - Add days_until_89_degree_days_hit	 and degree_days_hit_on_July_1st to Yearly table
    
7. Export to CSV
    -The Yearly table and Daily tables are read back into a DataFrame and exported to a CSV file:


## Requirements
- Python 3.x
- pandas
- ipython-sql
- SQLite-compatible database (WEATHER.db)

