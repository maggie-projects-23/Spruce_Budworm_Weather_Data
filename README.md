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

