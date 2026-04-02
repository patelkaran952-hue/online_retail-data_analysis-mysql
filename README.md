# 🛒 Online Retail Data Analysis (SQL Project)

## 📌 Project Overview

This project focuses on analyzing a real-world transactional dataset from the UCI Machine Learning Repository.
The dataset contains online retail transactions for a UK-based e-commerce store.

The goal of this project is to:

* Clean and preprocess raw data
* Normalize the database into multiple tables
* Perform exploratory data analysis (EDA) using SQL
* Generate business insights

---

## 📂 Dataset Information

* Source: UCI Machine Learning Repository
* Dataset Name: Online Retail
* Records: ~500,000+ transactions
* Time Period: 2010–2011

### 🧾 Columns:

* InvoiceNo → Transaction ID
* StockCode → Product ID
* Description → Product name
* Quantity → Number of items purchased
* InvoiceDate → Date & time of transaction
* UnitPrice → Price per item
* CustomerID → Unique customer ID
* Country → Customer location

---

## 🧱 Database Design (Normalization)

The raw dataset was normalized into multiple tables to reduce redundancy and improve data integrity.

### Tables Created:

* **customers** → Customer information
* **products** → Product details
* **orders** → Order-level data
* **order_details** → Transaction-level data

### 🔗 ER Diagram:

```
customers ───< orders ───< order_details >─── products
```

---

## ⚙️ Data Cleaning Steps

* Removed NULL CustomerIDs
* Removed negative/zero quantities and prices
* Standardized text fields

---

## 🛠️ Technologies Used

* SQL (MySQL)
* Excel (for initial data handling)

---

## 📊 Key SQL Analysis

### 💰 Total Revenue

```sql
SELECT SUM(quantity * unit_price) AS revenue
FROM order_details;
```

---

### 🌍 Revenue by Country

```sql
SELECT c.country, SUM(od.quantity * od.unit_price) AS revenue
FROM order_details od
JOIN orders o ON od.invoice_no = o.invoice_no
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.country
ORDER BY revenue DESC;
```

---

### 🛍️ Top Selling Products

```sql
SELECT p.description, SUM(od.quantity) AS total_sold
FROM order_details od
JOIN products p ON od.stock_code = p.stock_code
GROUP BY p.description
ORDER BY total_sold DESC
LIMIT 10;
```

---

### 👤 Top Customers

```sql
SELECT o.customer_id, SUM(od.quantity * od.unit_price) AS spending
FROM orders o
JOIN order_details od ON o.invoice_no = od.invoice_no
GROUP BY o.customer_id
ORDER BY spending DESC
LIMIT 10;
```

---

## 🚀 Advanced Analysis

### 📈 Monthly Revenue Trend

```sql
SELECT YEAR(o.invoice_date) AS year,
       MONTH(o.invoice_date) AS month,
       SUM(od.quantity * od.unit_price) AS revenue
FROM orders o
JOIN order_details od ON o.invoice_no = od.invoice_no
GROUP BY year, month
ORDER BY year, month;
```

---

### 🧠 RFM Analysis (Customer Segmentation)

```sql
SELECT 
    o.customer_id,
    MAX(o.invoice_date) AS last_purchase,
    COUNT(DISTINCT o.invoice_no) AS frequency,
    SUM(od.quantity * od.unit_price) AS monetary
FROM orders o
JOIN order_details od ON o.invoice_no = od.invoice_no
GROUP BY o.customer_id;
```

---

## 🔍 Key Insights

* Majority of revenue comes from a few top countries
* A small percentage of customers contribute to most sales
* Certain products dominate total sales volume
* Seasonal trends are visible in monthly revenue

---

## 📌 Learning Outcomes

* Applied database normalization (up to 3NF)
* Built relational schema using foreign keys
* Improved SQL query writing using joins and aggregations
* Performed business-driven data analysis

---

## 📁 Project Structure

```
📦 online-retail-sql-project
 ┣ 📄 README.md
 ┣ 📄 schema.sql
 ┣ 📄 data_cleaning.sql
 ┣ 📄 analysis_queries.sql
 ┗ 📄 dataset.csv
```

---

## 🌟 Future Improvements

* Build interactive dashboard using Power BI / Tableau
* Add customer segmentation visualization
* Perform cohort analysis

---

## 🤝 Connect With Me

If you liked this project or have suggestions, feel free to connect!

---

⭐ Don't forget to star this repository if you found it useful!
