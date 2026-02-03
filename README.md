# Retail Sales Analytics  
**Tools:** SQL, Power BI  
**Objective:** Phân tích dữ liệu bán lẻ để xác định các yếu tố ảnh hưởng đến doanh thu, hành vi khách hàng và hiệu suất chi nhánh.

---

## 1. Giới thiệu dự án  
Dự án nhằm phân tích dữ liệu bán lẻ từ chuỗi siêu thị để trả lời các câu hỏi kinh doanh quan trọng:

- Doanh thu thay đổi như thế nào theo từng tháng?  
- Chi nhánh nào hoạt động tốt nhất?  
- Dòng sản phẩm nào bán chạy nhất?  
- Phương thức thanh toán nào được khách hàng ưa chuộng?  

Dữ liệu được xử lý bằng **SQL**, sau đó trực quan hóa bằng **Power BI** để tạo dashboard.

---

## 2. Dataset  
Dataset gồm **1000 giao dịch**, với các trường:

| Column Name    | Data Type | Description |
|----------------|-----------|-------------|
| Invoice ID     | String    | Mã hóa đơn duy nhất |
| Branch         | String    | Chi nhánh (A, B, C) |
| City           | String    | Thành phố |
| Customer type  | String    | Loại khách (Member / Normal) |
| Gender         | String    | Giới tính |
| Product line   | String    | Nhóm sản phẩm |
| Unit price     | Float     | Giá bán (USD) |
| Quantity       | Integer   | Số lượng mua |
| Date           | Date      | Ngày giao dịch |
| Time           | Time      | Thời gian |
| Payment        | String    | Phương thức thanh toán |
| Tax 5%         | Float     | Thuế |
| Total          | Float     | Thành tiền |
| COGS           | Float     | Giá vốn |
| Rating         | Float     | Đánh giá dịch vụ 1–10 |

---

##  3. Xử lý dữ liệu (SQL)  
### Làm sạch dữ liệu  
- Chuẩn hóa kiểu dữ liệu (Date, Time, Numeric)  
- Loại bỏ trùng lặp  
- Tạo cột Revenue = Unit Price × Quantity  
- Tạo các trường Month, DayName, Hour để phân tích xu hướng  

### Phân tích SQL  
Dùng để:  
- Tính doanh thu  
- Phân tích dòng sản phẩm  
- Phương thức thanh toán  
- Tìm ngày cao nhất/thấp nhất về doanh thu  
- Phân tích AOV theo nhóm khách hàng  

---

## 4. Dashboard (Power BI)

### Các KPI chính  
- **Total Revenue:** 307.59K  
- **Total Quantity:** 5510  
- **Total Invoice:** 1000  

### Thành phần dashboard  
- Revenue by Month  
- Quantity by Product Line  
- Revenue by Payment  
- Branch Performance  
- Product & Customer Insights  

##  5. Key Insights

### Doanh thu theo tháng  
- Tháng **January** đạt doanh thu cao nhất.  
- Doanh thu giảm nhẹ ở **February** nhưng phục hồi vào **March**.

### Dòng sản phẩm  
- Bán chạy nhất: **Electronic Accessories**, **Food & Beverages**  
- Thấp nhất: **Health & Beauty**

### Phương thức thanh toán  
- E-Wallet + Credit Card chiếm **~69%** tổng doanh thu.  
- Thanh toán tiền mặt chiếm ~31%.

### Chi nhánh  
- Chi nhánh **C** đứng đầu về doanh thu.  

---

## 6. Kết luận & Khuyến nghị kinh doanh

### Cơ hội tăng trưởng  
- Tăng tồn kho sản phẩm **Electronic Accessories** vào tháng cao điểm.  
- Tập trung khuyến mãi cho nhóm **Health & Beauty**.  
- Khuyến khích thanh toán bằng ví điện tử (ưu đãi, giảm giá).  

### Chi nhánh  
- Chi nhánh B có thể cải thiện doanh thu bằng hoạt động marketing tại chỗ.  

---

## 7. File đính kèm (trong repository)
- `retail_sales_queries.sql` — Toàn bộ SQL queries  
- `retail_sales_dashboard.pbix` — File Power BI  
- `README.md` — Tài liệu mô tả dự án  

---

## 8. SQL Queries  
Toàn bộ truy vấn SQL của dự án:

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

