-- ============ Phần 1: Truy vấn dữ liệu với SQL ================

-- 1. Liệt kê tổng doanh thu (Total Revenue = Unit Price * Quantity) 
-----------theo từng chi nhánh và thành phố. Kết quả cần hiển thị Branch, City, Total Revenue.
SELECT 
    Branch
    , City
    , ROUND(sum(Unit_price * Quantity),2) AS [Total Revenue] 
from FinalTest_Dataset
GROUP BY 
    Branch
    , City

-- 2. Tìm 5 sản phẩm có tổng số lượng bán ra nhiều nhất. Kết quả cần hiển thị Product line, Total Quantity Sold.
SELECT TOP 5
    Product_line
    , SUM(Quantity) AS [Total Quantity Sold]
from FinalTest_Dataset
GROUP BY Product_line
ORDER BY [Total Quantity Sold] DESC

-- 3. Tính tỷ lệ phần trăm doanh thu của từng phương thức thanh toán so với tổng doanh thu toàn bộ cửa hàng.
SELECT
    Payment
    , CONCAT(ROUND(SUM(Unit_price * Quantity)/(SELECT SUM(Unit_price * Quantity) FROM FinalTest_Dataset)*100,2),'%')
    AS [% Revenue by Payment]
FROM FinalTest_Dataset
GROUP BY Payment

-- 4. Xác định ngày có doanh thu cao nhất và thấp nhất trong toàn bộ dữ liệu. Hiển thị kết quả theo dạng Date, Total Revenue.
WITH [Revenue by Date] AS (
SELECT
    [Date]
    , ROUND(sum(Unit_price * Quantity),2) AS [Total Revenue]
FROM FinalTest_Dataset
GROUP BY [Date]
)
SELECT
    [Date]
    , [Total Revenue]
FROM [Revenue by Date]
WHERE 
    [Total Revenue] = (SELECT MAX([Total Revenue]) FROM [Revenue by Date])
    OR [Total Revenue] = (SELECT MIN([Total Revenue]) FROM [Revenue by Date])

-- 5. Tìm nhóm khách hàng có giá trị trung bình trên mỗi hóa đơn (Average Order Value = Total Revenue / Số lượng hóa đơn) cao nhất. 
-- Hiển thị Customer Type, Average Order Value.
WITH AOV_Customer AS (
    SELECT
        Customer_type
        , SUM(Unit_price * Quantity) AS [Total Revenue]
        , COUNT(DISTINCT Invoice_ID) AS [Total Orders]
        , ROUND(SUM(Unit_price * Quantity) * 1.0 / COUNT(DISTINCT Invoice_ID),2) AS [Average Order Value]
    FROM FinalTest_Dataset
    GROUP BY Customer_type
)
SELECT 
    Customer_type
    , [Average Order Value]
FROM AOV_Customer
ORDER BY [Average Order Value] DESC