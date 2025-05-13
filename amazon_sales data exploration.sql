-- Skill used: Aggregate Functions, CTE, Temptable, WIndow function, Creating Views

SELECT * FROM amazon_sales_2025;

-- Write queries to generate metrics for a monthly sales dashboard:
-- Total Sales per Month, Total Orders per Month & Average Order Value
SELECT
DATE_FORMAT(`date`, '%Y-%m') AS `Month`, 
SUM(`total sales`) AS Monthly_sales,
COUNT(`order id`) AS Total_orders,
ROUND(SUM(`total sales`)/COUNT(`order id`), 2) AS AVG_order
FROM amazon_sales_2025
GROUP BY `Month`;


-- Best-Selling Categories & Products
SELECT 
`Order id`, 
Product, 
Category,
`Total sales`
FROM amazon_sales_2025
ORDER BY `Total sales` DESC
LIMIT 1;

-- Analyze customer behavior:

-- Top 5 Customers by Total Spend
SELECT `Customer name`,
SUM(`Total sales`) AS Total_spend
FROM amazon_sales_2025
GROUP BY `Customer name`
ORDER BY SUM(`Total sales`) DESC
LIMIT 5;

-- Number of Orders per Customer
SELECT `Customer name`,
COUNT(`Order id`) AS No_of_order
FROM amazon_sales_2025
GROUP BY `Customer name`;

-- Average Purchase Value per Customer
SELECT `Customer name`,
SUM(`Total sales`) AS Total_spend,
COUNT(`Order id`) AS No_of_order,
ROUND(SUM(`Total sales`)/COUNT(`Order id`), 2) AS APV
FROM amazon_sales_2025
GROUP BY `Customer name`;

-- Repeat vs. One-time Customers
SELECT `Customer name`,
 COUNT(`Order id`) AS Total_order,
CASE
	WHEN COUNT(`Order id`) = 1 THEN 'One-time customer'
    ELSE 'Repeat customer'
END AS Customer_classification
FROM amazon_sales_2025
GROUP BY `Customer name`;


-- Analyze product/category-level performance:
-- Most Profitable Categories
SELECT Category,
COUNT(`Order id`) AS Total_order
FROM amazon_sales_2025
GROUP BY Category
ORDER BY COUNT(`Order id`) DESC
LIMIT 1;

-- Products with the Highest Quantity Sold
SELECT Product,
COUNT(Quantity) AS Quantity_sold
FROM amazon_sales_2025
GROUP BY Product
ORDER BY COUNT(Quantity) DESC
LIMIT 1;

-- Products with High Cancellation Rates
SELECT Product,
COUNT(`Status`) AS Cancellation_Rates
FROM amazon_sales_2025
WHERE `Status` = 'Cancelled'
GROUP BY Product
ORDER BY COUNT(`Status`) DESC
LIMIT 1;

-- Breakdown sales by customer location:
-- Top 5 Cities by Sales Volume
SELECT `Customer location` AS Cities,
SUM(Quantity) AS No_of_unitsold,
COUNT(`Order id`) AS Total_order,
SUM(`Total sales`) AS Total_revenue
FROM amazon_sales_2025
GROUP BY `Customer location`
ORDER BY SUM(`Total sales`) DESC
LIMIT 5;
 
-- Regional Preference for Product Categories
WITH Pref_CTE AS(
SELECT
`Customer Location`,
Category,
SUM(`Total Sales`) AS Total_sales,
RANK() OVER(PARTITION BY `Customer Location` ORDER BY SUM(`Total Sales`) DESC) AS Preference
FROM amazon_sales_2025
GROUP BY `Customer Location`, Category)
SELECT `Customer Location`,
Category
FROM Pref_CTE
WHERE Preference = 1;

-- City-wise Revenue Trend Over Time
SELECT
`Customer Location`,
`date`,
SUM(`Total Sales`) AS Total_sales
FROM amazon_sales_2025
GROUP BY `Customer Location`, `date`;

-- Performance of different payment methods:
-- Payment Method Preference per Region
WITH Pref_CTE2 AS
(SELECT `Customer Location`,
`Payment Method`,
COUNT(`Order id`) AS No_of_order,
RANK() OVER(PARTITION BY `Customer Location` ORDER BY COUNT(`Order id`) DESC) AS Preference
FROM amazon_sales_2025
GROUP BY `Customer Location`, `Payment Method`)
SELECT `Customer Location`,
`Payment Method`
 FROM Pref_CTE2
 WHERE Preference = 1;
 
-- Success vs Cancellation Rates by Payment Method
SELECT `Payment Method`,
COUNT(*) AS status_rate,
ROUND(SUM(CASE
	WHEN `status` = 'Completed' THEN 1
    ELSE 0
END) * 100 / COUNT(*), 2) AS Success_rate,
ROUND(SUM(CASE
	WHEN `status` = 'Cancelled' THEN 1
    ELSE 0
END) * 100 / COUNT(*), 2) AS Cancellation_rate
FROM amazon_sales_2025
WHERE `status` IN('Completed', 'Cancelled')
GROUP BY `Payment Method`;

-- indicate if success vs cancellation rate is high or low
WITH PM_CTE AS
(SELECT 
`Payment Method`,
`status`,
COUNT(`status`),
RANK() OVER(PARTITION BY `Payment Method` ORDER BY COUNT(`status`) DESC) AS status_rank
FROM amazon_sales_2025
WHERE `status` IN('Completed', 'Cancelled')
GROUP BY `Payment Method`, `status`)
SELECT `Payment Method`,
CASE
	WHEN `status` = 'Completed'AND status_rank = 1 THEN 'High'
    ELSE 'Low'
END AS Success_rate,
CASE
	WHEN `status` = 'Cancelled'AND status_rank = 1 THEN 'High'
    ELSE 'Low'
END AS Cancellation_rate
FROM PM_CTE
WHERE status_rank = 1;

-- Correlation Between Payment Method and Order Status
SELECT `Payment Method`,
`status`,
COUNT(*) AS Order_status
FROM amazon_sales_2025
GROUP BY `Payment Method`,
`status`
ORDER BY `Payment Method`, COUNT(*) DESC;

-- Identify trends and seasonality:
-- Sales Trend Over Weeks/Months
#Over weeks
SELECT 
YEAR(`date`) AS `Year`,
WEEK(`date`) AS Weekdays,
COUNT(`Total Sales`) AS Sales
FROM amazon_sales_2025
GROUP BY YEAR(`date`),
WEEK(`date`)
ORDER BY WEEK(`date`);

#Over Months
SELECT 
DATE_FORMAT(`date`, '%Y-%m') AS `Month`,
COUNT(`Total Sales`) AS Sales
FROM amazon_sales_2025
GROUP BY DATE_FORMAT(`date`, '%Y-%m');

-- Sales Peaks and Dips
# Creating a temp table
CREATE TEMPORARY TABLE Sales_Trend AS
SELECT 
`date`,
COUNT(`Total Sales`) AS Sales
FROM amazon_sales_2025
GROUP BY `date`;

#Use the Temp table to find Sales Peaks and Dips
#Sales Peaks
Select * FROM Sales_Trend
ORDER BY Sales DESC
LIMIT 5;

#Sales Dips
Select * FROM Sales_Trend
ORDER BY Sales ASC
LIMIT 5;

-- Impact of Weekday/Weekend on Order Volume
SELECT 
CASE 
	WHEN DAYOFWEEK(`date`) IN (1, 7) THEN 'Weekends'
ELSE 'Weekdays'
END AS day_type,
COUNT(`Order id`) AS Order_count,
SUM(`Total Sales`) AS Total_sales
FROM amazon_sales_2025
GROUP BY CASE 
	WHEN DAYOFWEEK(`date`) IN (1, 7) THEN 'Weekends'
ELSE 'Weekdays'
END;