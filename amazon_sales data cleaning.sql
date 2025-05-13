DROP DATABASE IF EXISTS Amazon_sales;
CREATE DATABASE Amazon_sales;

SELECT * FROM amazon_sales2025;

CREATE TABLE amazon_sales_2025
LIKE amazon_sales2025;

INSERT amazon_sales_2025
SELECT * FROM amazon_sales2025;

SELECT * FROM amazon_sales_2025;

SELECT `Order id`, 
CAST(SUBSTRING(`Order id`, 4, 4) AS UNSIGNED) 
FROM amazon_sales_2025;

UPDATE amazon_sales_2025
SET `order id` = CAST(SUBSTRING(`Order id`, 4, 4) AS UNSIGNED);

ALTER TABLE amazon_sales_2025
MODIFY COLUMN `order id` INT;
SELECT `date`,
STR_TO_DATE(`date`, '%d-%m-%Y')
FROM amazon_sales_2025;

UPDATE amazon_sales_2025
SET `date` = STR_TO_DATE(`date`, '%d-%m-%Y');

ALTER TABLE amazon_sales_2025
MODIFY COLUMN `date` DATE;