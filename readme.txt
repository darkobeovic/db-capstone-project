Little Lemon – Booking System Project

Final Capstone – Full Database, Python Client, and Tableau Analytics Solution

Overview

This project implements a complete Booking System for Little Lemon, integrating:
	•	A fully structured MySQL database with all required tables and relationships.
	•	Stored procedures to handle booking and order operations.
	•	A Python client using mysql-connector-python.
	•	Tableau dashboards for sales and profit analytics.
	•	A GitHub repository containing all project components.

The goal is to give Little Lemon a robust and functional end-to-end data solution for managing reservations, exploring sales, and supporting data-driven decision-making.

⸻

1. Database Implementation

The database LittleLemonDB was created including the following tables:
	•	Customers
	•	Bookings
	•	Menu
	•	Orders
	•	OrderDeliveryStatus
	•	Staff

Included in this repository:
	•	LittleLemonDB.sql – full schema + sample data
	•	procedures_full.sql – all stored procedures required by the project

ER Diagram

An Entity-Relationship diagram is included in the repository showing all table connections and primary/foreign key relationships.

⸻

2. Stored Procedures

All procedures required by the grading rubric have been implemented and tested in MySQL Workbench.

Included Procedures
	•	GetMaxQuantity() ✔️
	•	ManageBooking() (implemented as AddValidBooking following the course instructions) ✔️
	•	UpdateBooking() ✔️
	•	AddBooking() ✔️
	•	CancelBooking() ✔️
	•	CheckBooking() ✔️
	•	CancelOrder() ✔️

Stored procedures are located in:

👉 procedures_full.sql

⸻

3. Python Client Implementation

A Python environment was configured using Jupyter Notebook and the mysql-connector-python driver.

Notebook included:
	•	configuring_mysql_connector.ipynb

Client Functionality

✔ Connects to MySQL
✔ Executes SQL queries
✔ Retrieves and prints results
✔ Performs JOIN queries
✔ Extracts customers who spent more than $60

This allows Little Lemon to interact with their database programmatically.

⸻

4. Tableau Data Analysis

Tableau Desktop was used to connect to the data and generate interactive visualizations.

Workbook included:
	•	LittleLemon Tableau.twb

Dashboards & Visuals Delivered

1. Customers Sales (Bar Chart)
	•	Filter: Sales ≥ $70
	•	Tooltip with Customer Name + Sales
	•	Named “Customers Sales”

2. Profit Trend 2019–2022 (Line Chart)
	•	Excludes 2023
	•	Named “Profit Chart”

3. Sales Bubble Chart
	•	Bubble size based on sales
	•	Tooltip displays: Name, Profit, Sales
	•	Named “Sales Bubble Chart”

4. Cuisine Sales & Profit (Bar Chart)
	•	Comparison of Turkish, Italian, Greek cuisines
	•	Years: 2020, 2021, 2022
	•	Sorted by sum of Sales
	•	Named “Cuisine Sales and Profits”

5. Interactive Dashboard
	•	Combines Customers Sales + Sales Bubble Chart
	•	Uses dashboard actions to filter bubbles based on clicked bar

All dashboards match the expected outputs shown in the instructions.