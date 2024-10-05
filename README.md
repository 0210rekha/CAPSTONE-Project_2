DataSpark: Illuminating Insights from Global Electronics
Overview
DataSpark is a data-driven project designed to analyze Global Electronics' business data, providing key insights into customer demographics, sales performance, product profitability, and store operations. The data pipeline involves extracting and transforming datasets, storing them in a MySQL database, and utilizing Power BI to create interactive, analytical dashboards for business intelligence.

Project Objective
The goal is to perform in-depth Exploratory Data Analysis (EDA) and derive actionable recommendations to improve customer satisfaction, optimize operations, and enhance product and sales strategies.

Key Components
Data Collection & Preparation:

Import multiple datasets related to customers, products, sales, and stores.
Data cleaning and transformation using Python (Pandas).
Merging datasets into a single unified format for analysis.
SQL Query Execution:

Custom SQL queries in MySQL to extract valuable insights.
Queries for demographics, sales trends, product performance, and geographical analysis.
Use of aggregation functions and advanced SQL joins to generate comprehensive reports.
Data Warehousing:

Data storage in MySQL for efficient querying and access.
Ensuring relational integrity with properly defined foreign key constraints across tables (e.g., customers, products, sales).
Power BI Dashboards:

Build visually appealing, dynamic dashboards.
Dashboards for customer insights, sales trends, product profitability, and store performance.
Data refresh from MySQL for real-time visualization.
Technologies Used
Python: Data extraction, cleaning, and SQL execution using libraries such as Pandas, MySQL-Connector, and SQLAlchemy.
MySQL: Database for structured data storage and complex querying.
Power BI: Data visualization and business intelligence for building interactive dashboards.
SQLAlchemy: ORM framework for database management and interaction between Python and MySQL.
Core SQL Queries & Insights
Customer Demographic Distribution:

Analyzes customers by gender, age, location (city, state, country), providing insights into customer segments and their geographical distribution.
Average Purchase Value per Customer:

Calculates the average customer spending by analyzing transaction data.
Top Performing Products:

Identifies high-demand products by tracking quantity sold across various categories.
Store Performance:

Evaluates store profitability based on total sales, location, and store size.
Profitability Analysis:

Computes product profitability by evaluating unit price vs. unit cost, including currency conversion impacts.
Sales Trends Over Time:

Monitors monthly sales performance to track trends and seasonality.
Power BI Dashboards
Customer Dashboard: Visualizes customer demographic data, purchasing behavior, and customer segmentation.
Sales Dashboard: Tracks key sales metrics like revenue, sales volume, and customer spending patterns.
Product Dashboard: Analyzes product performance, including sales volume, profitability, and category distribution.
Store Dashboard: Examines store performance based on sales, size, geographical region, and store opening date.
Installation & Setup
Python Environment:

Ensure Python 3.x is installed.
Install required Python libraries via requirements.txt:
bash
Copy code
pip install -r requirements.txt
MySQL Setup:

Install MySQL and configure the database.
Import data into MySQL tables by running the data preparation scripts.
Power BI:

Use the .pbix Power BI file to view the pre-built dashboards.
Ensure data connections to MySQL are correctly configured for live data refresh.
Project Structure
data_cleaning.py: Cleans and prepares raw data for analysis.
sql_queries.py: Executes SQL queries to extract insights from the MySQL database.
dashboard_creation.pbix: Power BI file containing the interactive dashboards.
requirements.txt: List of all dependencies required for Python environment setup.
Usage
Clone the repository:

bash
Copy code
git clone https://github.com/your-repository.git
Run data cleaning and SQL execution scripts:

bash
Copy code
python data_cleaning.py
python sql_queries.py
Open the Power BI file for dashboard interaction and exploration:

Ensure data refresh is set to live query mode.
Contributions
Contributions are welcome. Feel free to open a pull request or submit an issue on GitHub to suggest improvements or additional features.

Demo
Watch a demo video showcasing the Power BI dashboards: Demo Video