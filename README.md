# Electronic Store Sales Performance

## Table of Content
* [ Project Objective](Project-Objective)
* [EDA and Data Cleaning (SQL)](EDA-and-Data-Cleaning-(SQL))
* [Outlier Detection](Outlier-Detection)
* [Overall Data Quality Assessment](Overall-Data-Quality-Assessment)
* [Report showing all business metrics](Report-showing-all-business-metrics)
* [Sales & Revenue Analysis](Sales-&-Revenue-Analysis)
* [Year-over-Year Growth per Product Category](Year-over-Year-Growth-per-Product-Category)
* [Business Takeaway](Business-Takeaway)
* [Findings](Findings)
* [Executive Takeaways](Executive-Takeaways)
* [Recommendations](Recommendations)
* [View of the Dashboard](View-of-the-Dashboard)


### Project Objective
The objective of this project is to design an Electronic Sales Performance system that helps management make data-driven decisions about sales, pricing, and promotions. 

* Using SQL for data analysis and Excel for reporting and visualization, the project aims to:
* Track and monitor accessories across regions to prevent stockouts and overstocking.
* Identify fast-moving and slow-moving products to optimize stock allocation.
* Evaluate sales performance by product, category, monthly trend, and region.

< <img width="1024" height="686" alt="Electronic store picture" src="https://github.com/user-attachments/assets/70804660-9992-4386-a0e8-b41c583c5373" />



* Data Source and import
This dataset was imported into SQL using the Flat Import method.
It contains over 266 records, including fields such as Date, Product, Category, Region, sales, Quantity, and cost.

#### EDA and Data Cleaning (SQL)
Missing Values
* No missing values were found across all columns
* Logic: Completeness of data ensures that subsequent analysis will not be biased by gaps in reporting.

#### Outlier Detection
* cost: All product costs fall within a valid range (0–1000).
* Quantity: No value is equal to zero or unreasonably high counts (above 10).
* Sales: No negative sales were observed.
* Logic: This indicates that transactional and Electronic data are consistent with business expectations.


#### Overall Data Quality Assessment
No missing values, duplicates, or unreasonable outliers were detected, and all key business rules were satisfied. 
The dataset is deemed reliable and fit for accurate business analysis.

###### Report showing all business metrics
* Total Sales: 841,248.68
* Total Quantity Sold: 1,623
* Sum of Cost: 121,519.9
* Total Profit: 719,728.78
* Unique Products: 6
* Regions: 4
* Years: 2

  ### Sales & Revenue Analysis
  Monthly Sales & Revenue Trends

* Aggregated total units sold and revenue per month across 2023–2024.
* Logic: This helps track seasonality, growth trends, and anomalies in sales volume and revenue.
  
###### Key Findings:
* Sales and revenue were increased in 2024 compared to the previous year 2023.

###### Revenue by Product
Summarized revenue contribution by products and year.
Logic: Identifies which products and year are the highest revenue drivers.

* Key Findings:
* Almost all the 6 products have equally generated revenue.
* Headphones, Mouse, Monitor, and Keyboard were  top performers.

###### Revenue by Region
Calculated total revenue by region (East, South, North, West).
Logic: Regional performance highlights geographical strengths and weaknesses.

* Key Findings:
* There was a significant difference in revenue across the regions with a slight difference between East and North.
* The West region generated the highest sales, while the West region lagged behind.

##### Year-over-Year Growth per Product Category
Measured annual revenue by sales and calculated YoY growth.

* Logic: Tracks sales performance over time and highlights growth or decline.
Key Findings:
* Between 2023–2024, there was a significant growth of 30% from $365.6k to $475.6k.


### Business Takeaway
* Quarterly & Monthly Seasonal Peaks
Logic: Aggregated sales by quarter and month  to identify peaks and dips.

###### Findings:
* Quarterly: Sales are remarkably impressive during the 1st, 3rd, and 4th quarters, with $220.0k, $223.6k, and $224.3k per quarter.
* Monthly: Stronger months: April ( $95K), October ($91K). Weaker months: May ($20K).
* Clear pattern: significant dips in May (summer) and small surges in the beginning of the year.

### Executive Takeaways
Seasonality: Demand is relatively high at the start of a summer(April), fall(October) but certain months where we experience a great dip(December and May).
Weather: Sunny conditions improve sales, but weather is not a major driver.

## Recommendations
Since the highest sales product is Headphones and there is a significant drop in sales in December probably, due to Christmas for staff and non-functional, it is ideal to have a business website and drive promotional promo so as to increase sales.

##### View of the Dashboard
[Click the link to view the Dashboard](https://docs.google.com/spreadsheets/d/1eoxVxBjJMieEgkZPIWYvkJNEAjOTI70ZkKzSM4KVynk/edit?usp=sharing)
<img width="1366" height="768" alt="Diagram view of the 2023 vs 2024" src="https://github.com/user-attachments/assets/7a72c894-1f54-48fc-8271-901906b84aa4" />

