Data Analyst Portfolio Projects


This repository contains a collection of data analysis and data cleaning projects focusing on SQL exploration and Tableau visualization. These projects demonstrate skills in data manipulation, exploratory data analysis (EDA), and creating interactive dashboards.


📂 Project Overview




1. COVID-19 Data Exploration

Tools Used: SQL (MySQL/SQL Server), Tableau
Files: CovidPortfolio-Project1.sql, Covid Deaths.csv, Covid Vaccinations.csv, Covid DashBoard.twb

Objective: Analyze global COVID-19 data to identify trends in infection rates, death percentages, and vaccination progress.

Key SQL Techniques: Joins, CTEs, Temp Tables, Window Functions, Aggregate Functions, and Creating Views.



Analysis Highlights:

Likelihood of dying if you contract COVID-19 in specific countries.

Percentage of the population infected by country and continent.

Rolling count of vaccinations per location using Partition By.

Visualization: An interactive Tableau dashboard displaying global statistics, percent population infected by country, and forecasted infection rates.





2. Nashville Housing Data Cleaning

Tools Used: SQL
Files: Data_Cleaning of Nashville Housing.sql, Nashville Housing Data for Data Cleaning.csv

Objective: Take raw housing data and transform it into a format suitable for analysis.

Cleaning Tasks:

Standardizing Date Formats: Converting text-based sale dates into proper DATE types.

Populating Missing Data: Using self-joins to fill in null Property Address fields based on matching Parcel IDs.

Breaking Out Addresses: Splitting composite address strings (Address, City, State) into individual columns for better usability.

Data Normalization: Changing "Y" and "N" to "Yes" and "No" in the "Sold as Vacant" field for consistency.

Removing Duplicates: Utilizing CTEs and Window Functions (ROW_NUMBER) to identify and delete duplicate records.

Deleting Unused Columns: Streamlining the dataset by removing redundant columns after transformation.





🛠️ Technologies Used
SQL: Primary tool for data extraction, transformation, and cleaning.

Tableau: Used for high-level data visualization and storytelling.

Excel/CSV: Source data format for all projects.





📊 How to Use This Repo
SQL Scripts: The .sql files contain the logic used to transform the data. You can run these in your SQL environment (MySQL, PostgreSQL, or SQL Server) after importing the corresponding .csv files.

Tableau Dashboard: To view the COVID-19 visualizations, open the Covid DashBoard.twb file using Tableau Desktop or Tableau Public.

Data: The raw data files are provided in the root directory for reproducibility.





📈 Insights and Results
The COVID-19 analysis reveals significant disparities in vaccination rates across different continents.

The Nashville Housing project reduced the dataset complexity and improved data integrity by resolving over 200+ address discrepancies and removing duplicate entries.





Covid DashBoard Link : https://public.tableau.com/app/profile/hanishka.kela/viz/CovidDashBoard_17750551809200/Dashboard1?publish=yes
