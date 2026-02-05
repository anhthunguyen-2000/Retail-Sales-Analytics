# Retail Sales Analytics

**Tools:** SQL, Power BI  
**Role:** Data Analyst  
**Dataset Size:** 1,000 transactions  

## Project Objective
Analyze retail sales data to identify key factors influencing revenue, customer behavior, and branch performance, and translate insights into actionable business recommendations.

---

## Business Questions
- How does revenue change over time (monthly)?
- Which branch performs the best?
- Which product lines generate the highest sales?
- Which payment methods are preferred by customers?

---

## Dataset Overview
The dataset contains **1,000 retail transactions** with the following fields:

| Column Name | Description |
|------------|-------------|
| Invoice ID | Unique invoice identifier |
| Branch | Branch (A, B, C) |
| City | City |
| Customer type | Member / Normal |
| Gender | Customer gender |
| Product line | Product category |
| Unit price | Unit price (USD) |
| Quantity | Quantity purchased |
| Date | Transaction date |
| Time | Transaction time |
| Payment | Payment method |
| Tax 5% | Tax amount |
| Total | Total transaction value |
| COGS | Cost of goods sold |
| Rating | Customer rating (1–10) |

---

## Data Processing (SQL)

### Data Cleaning
- Standardized data types (Date, Time, Numeric)
- Removed duplicate records
- Created **Revenue = Unit Price × Quantity**
- Generated **Month**, **DayName**, and **Hour** for trend analysis

### SQL Analysis
SQL was used to:
- Calculate total revenue
- Analyze product line performance
- Analyze payment method contribution
- Identify highest and lowest revenue days
- Analyze Average Order Value (AOV) by customer segment

---

## Dashboard (Power BI)

### Key KPIs
- **Total Revenue:** 307.59K  
- **Total Quantity Sold:** 5,510  
- **Total Invoices:** 1,000  

### Dashboard Components
- Revenue by Month
- Quantity by Product Line
- Revenue by Payment Method
- Branch Performance
- Product & Customer Insights

---

## Key Insights

### Revenue Trend
- **January** recorded the highest revenue.
- Revenue declined slightly in **February** and recovered in **March**.

### Product Performance
- Top-selling categories: **Electronic Accessories**, **Food & Beverages**
- Lowest-performing category: **Health & Beauty**

### Payment Methods
- **E-Wallets & Credit Cards** contribute ~**69%** of total revenue.
- Cash payments account for ~**31%**.

### Branch Performance
- **Branch C** generates the highest revenue.

---

## Business Recommendations

### Growth Opportunities
- Increase inventory for **Electronic Accessories** during peak months.
- Run targeted promotions for **Health & Beauty** products.
- Encourage digital payments through incentives and discounts.

### Branch Strategy
- Improve **Branch B** performance through localized marketing initiatives. 

---

## 7. Attachments 
- `queries.sql` — All SQL queries  
- `retail_sales_dashboard.pbix` — File Power BI  
- `README.md` — Documentation  

---

## 8. SQL Queries  
All SQL queries

```sql
-- 1. Tổng doanh thu theo từng chi nhánh và thành phố
SELECT 
    Branch,
    City,
    ROUND(SUM(Unit_price * Quantity), 2) AS [Total Revenue]
FROM FinalTest_Dataset
GROUP BY Branch, City;

-- 2. Top 5 sản phẩm có tổng số lượng bán cao nhất
SELECT TOP 5
    Product_line,
    SUM(Quantity) AS [Total Quantity Sold]
FROM FinalTest_Dataset
GROUP BY Product_line
ORDER BY [Total Quantity Sold] DESC;

-- 3. Tỷ lệ doanh thu theo phương thức thanh toán
SELECT
    Payment,
    CONCAT(
        ROUND(
            SUM(Unit_price * Quantity) 
            / (SELECT SUM(Unit_price * Quantity) FROM FinalTest_Dataset) * 100, 2
        ), '%'
    ) AS [% Revenue by Payment]
FROM FinalTest_Dataset
GROUP BY Payment;

-- 4. Ngày có doanh thu cao nhất và thấp nhất
WITH [Revenue by Date] AS (
    SELECT
        [Date],
        ROUND(SUM(Unit_price * Quantity), 2) AS [Total Revenue]
    FROM FinalTest_Dataset
    GROUP BY [Date]
)
SELECT
    [Date],
    [Total Revenue]
FROM [Revenue by Date]
WHERE 
    [Total Revenue] = (SELECT MAX([Total Revenue]) FROM [Revenue by Date])
    OR 
    [Total Revenue] = (SELECT MIN([Total Revenue]) FROM [Revenue by Date]);

-- 5. Nhóm khách hàng có AOV cao nhất
WITH AOV_Customer AS (
    SELECT
        Customer_type,
        SUM(Unit_price * Quantity) AS [Total Revenue],
        COUNT(DISTINCT Invoice_ID) AS [Total Orders],
        ROUND(SUM(Unit_price * Quantity) * 1.0 / COUNT(DISTINCT Invoice_ID), 2) 
            AS [Average Order Value]
    FROM FinalTest_Dataset
    GROUP BY Customer_type
)
SELECT 
    Customer_type,
    [Average Order Value]
FROM AOV_Customer
ORDER BY [Average Order Value] DESC;
```

---

## 9. Skills Demonstrated  
- SQL Data Cleaning & Aggregation  
- Exploratory Data Analysis  
- Power BI Dashboard Design  
- Data Visualization  
- Business Insight Interpretation  
- Analytical Storytelling  

---

