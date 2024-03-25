SELECT*
FROM dbo.Walmart$

--Data sorting
ALTER TABLE dbo.Walmart$
ADD City NVARCHAR(255),
    State NVARCHAR(255),
	Country NVARCHAR(255);

UPDATE dbo.Walmart$
SET Country = PARSENAME(REPLACE(Geography, ',', '.'), 3),
    City = PARSENAME(REPLACE(Geography, ',', '.'), 2),
    State = PARSENAME(REPLACE(Geography, ',', '.'), 1);




--Sales trends over time
--days
SELECT [Order Date],
       SUM(sales) AS total_sales
From dbo.Walmart$
GROUP BY [Order Date]
ORDER BY total_sales desc
-- BY month
SELECT 
    DATENAME(month, [Order Date]) AS Month,
    ROUND(CAST(SUM(Sales)AS FLOAT),2) AS TotalSales
FROM 
    dbo.Walmart$
GROUP BY 
    DATENAME(month, [Order Date])
ORDER BY 
    Month desc;

--SHIPPING PERFOMANCE
SELECT AVG(DATEDIFF(day ,[Order Date],[Ship Date])) AS shipping_duration,
      [Category]
FROM dbo.Walmart$
GROUP BY Category 
ORDER BY shipping_duration desc

-- GEOGRAPHICAL ANALYSIS
-- by State
SELECT ROUND(CAST(SUM(Sales)AS float),0) AS total_sales ,State
FROM dbo.Walmart$
GROUP BY State

-- By city
SELECT TOP 10 City,State,ROUND(CAST(SUM(Sales)AS float),0) AS total_sales 
FROM dbo.Walmart$
GROUP BY City,State
ORDER BY total_sales desc

--PRODUCT CARTEGORY ANALYSIS
SELECT Category,ROUND(CAST(SUM(Sales) AS float ),0) AS total_sales
FROM dbo.Walmart$
GROUP BY Category
ORDER BY total_sales desc

--PRODUCT PERFOMANCE

SELECT [Product Name],SUM(Sales) AS total_sales,SUM([Profit]) as total_profit 
FROM dbo.Walmart$
GROUP BY [Product Name]
ORDER BY total_sales desc


--CUSTOMER ANALYSIS
SELECT EmailID,
       COUNT(*) AS total_orders,
	   SUM(Sales) AS total_sales,
	   ROUND(CAST(AVG(Sales)as FLOAT),2) AS avg_sales,
	   State
FROM dbo.Walmart$
GROUP BY EmailID,State
ORDER BY total_sales desc

--SALES QUANTITY ANALYSIS
SELECT 
      Category,
	  SUM(Quantity)AS total_quantity
	  --SUM(Sales) As total_sales
FROM dbo.Walmart$
GROUP BY Category
ORDER BY total_quantity desc

--Profitability analysis
--by category
SELECT Category,
      SUM(Sales) AS total_sales,
	  SUM(Profit) as total_profit,
	  ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2) AS ProfitMargin
FROM dbo.Walmart$
GROUP BY Category
ORDER BY ProfitMargin desc

--by productname
SELECT [Product Name],
      SUM(Sales) AS total_sales,
	  SUM(Profit) as total_profit,
	  ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2) AS ProfitMargin
FROM dbo.Walmart$
GROUP BY [Product Name]
ORDER BY ProfitMargin desc


