📊 Sales Data Analysis Project

This project analyzes international sales data containing information about stores, countries, regions, salespersons, items, pricing, discounts, and price realization.
The goal is to clean the dataset, perform exploratory data analysis (EDA), calculate KPIs, and visualize insights using Python, SQL, and Power BI.

📂 Dataset Preview
Code	Store	Country	Region	Item	Salesperson	List Price	Actual Price	Clean_Date	Discount_num	Price_Realization %
I-1001	Moscow	Russia	EMEA	Microwave	May Wilmot	80	79	2018-10-06	1.25	98.75
I-1002	Toronto	Canada	EMEA	Microwave	David Shiner	80	54	2015-04-23	32.50	67.50
I-1003	Sao Paolo	Brazil	LATAM	Air conditioner	Gary Reynolds	700	686	2017-04-03	2.00	98.00
I-1004	Istanbul	Turkey	EMEA	Ceiling fan	Mark Buntain	150	137	2018-08-14	8.67	91.33
I-1005	Sydney	Australia	APAC	Toaster	Christine Davies	50	37	2015-03-03	26.00	74.00
🎯 Project Objectives

Clean messy date formats

Handle missing values

Calculate Discount % and Price Realization %

Identify top-performing regions, items, and salespersons

Compare list price vs actual price

Calculate revenue trends

Build visualizations in Power BI and Python

🛠️ Tools Used

Python (Pandas, Matplotlib, Seaborn)

SQL (CTE, Window Functions, Aggregations)

Power BI (DAX, KPIs, Interactive Dashboards)

Excel (Initial inspection)

🧹 Data Cleaning Steps

✔ Converted Clean_Date column into proper YYYY-MM-DD format
✔ Removed special characters from discounts
✔ Converted Discount_num into numeric
✔ Calculated Price_Realization % = Actual Price / List Price * 100
✔ Checked for NaN and replaced using median/mode
✔ Standardized Region and Country spelling

📈 Key KPIs

Total Revenue = SUM(Actual Price)

Total Discount %

Average Price Realization %

Average List Price vs Actual Price

Top Salesperson by Revenue

Region-wise Revenue Contribution

📊 Analysis Performed
Python EDA:

Distribution of List Price

Actual Price vs List Price comparison

Item category performance

Salesperson-wise revenue

Region-wise sales count

SQL Analysis:

Top 3 sales per item

Total revenue per region

Average actual price per region

Window function: previous sale using LAG()

CTE for discount calculation

Pivot table for Region vs Item revenue

📊 Power BI Dashboard Includes

Revenue Overview Page

Salesperson Leaderboard

Item Category Performance

Region-wise Revenue Map

List Price vs Actual Price Visuals

Price Realization KPI Card

🔍 Key Insights

EMEA region shows strong performance due to Russia, Turkey, and Canada sales.

Air conditioner category has the highest value sales.

Toaster and Microwave items receive higher discounts.

High discount directly reduces price realization % (67% for microwaves).

Salespersons like Gary Reynolds and Mark Buntain show strong consistency.

📁 Project Structure
/Sales-Analysis-Project
│── data/
│   └── sales_data.csv
│── python/
│   └── sales_analysis.ipynb
│── sql/
│   └── sales_queries.sql
│── powerbi/
│   └── sales_dashboard.pbix
│── README.md

🧾 Conclusion

This Sales Analysis Project provides actionable insights into pricing, discounts, regional performance, and salesperson efficiency.
It demonstrates strong skills in Python, SQL, Data Cleaning, KPI Design, and Power BI Visualization — suitable for portfolio and job interviews.

👤 Author

Ashik Kushwaha
Data Analyst | Python • SQL • Power BI • Excel
