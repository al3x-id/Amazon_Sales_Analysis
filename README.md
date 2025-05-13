# Amazon Sales & Payment Behaviour Analysis

## Problem Statement

Amazon, one of the largest e-commerce platforms globally, handles millions of transactions daily. However, gaining meaningful insights from this raw sales data can be difficult without effective querying and analysis. This project was carried out using SQL to uncover patterns, trends, and business opportunities hidden within Amazon's sales data.

## Overview

This project analyzes Amazon sales data using structured SQL queries to explore revenue trends, product category performance, geographic distribution of sales, and profitability. The aim is to understand how sales fluctuate across different regions, time periods, and product types.

## Key Business Questions Answered

- What are the monthly and weekly sales trends?
- Who are the repeat vs. one-time customers?
- Which payment method has the highest cancellation or success rate?
- What are the most profitable product categories?
- Do weekends outperform weekdays in order volume?

## SQL Tasks Performed

- Monthly and weekly sales breakdown
- Order volume and average order value trends
- Category-level profitability analysis
- Customer segmentation (repeat vs one-time)
- Payment method vs order status correlation
- Best and worst performing days (sales peaks/dips)

## Dataset Information

The dataset contains historical sales transaction records with fields such as:

- `Order ID`: Unique identifier for each transaction.
- `Date`: Date the order was placed.
- `Product`: Name of the product sold.
- `Category`: Product classification.
- `Price`: Price of each goods.
- `Quantity`: Number of units sold.
- `Total Sales`: Revenue from the sale.
- `Customer Name`: Name of buyer.
- `Customer Location`: Location of the buyer.
- `Payment Method`: Payment method used
- `Status`: Current state of payment transaction.

## Data Source

- The dataset was sourced from [Kaggle](https://www.kaggle.com/).

## Analysis Tools and Skills Used

- **SQL (Structured Query Language):** Used for data cleaning, exploration, aggregation, and trend analysis.
- **Key SQL Functions:** 
  - `GROUP BY` for summarizing trends across categories, time, and geography.
  - `ORDER BY` and `LIMIT` for ranking and sorting results.
  - `DATE_FORMAT()` and `EXTRACT()` for time-based analysis.
  - `CASE` statements for conditional logic.
  - `JOINs` for combining relevant tables (if multiple tables were used).
- **Data Skills:** generate metrics for a monthly sales, Analyze customer behavior, Analyze product/category-level performance, Breakdown sales by customer location, Performance of different payment methods, IdentityTime series analysis

## Key Insights & Recommendations

- The majority of cancelled orders were placed using Debit Cards, suggesting issues with that method. Credit Card transactions had the highest completion rate, making it the most reliable.”
- Electronics and Home Appliances together account for most of the total revenue, suggesting a heavy customer preference and high-margin potential in these categories.
- Average order value peaked in March 2025, indicating high-value transactions. Order count, however, was highest in February.
- Weekdays saw higher customer activity, ideal for promotions and ads.
- Out of 92 unique customers, most were repeat buyers, indicating good customer retention

## Conclusion

This SQL-based analysis of Amazon's sales data successfully uncovered valuable insights that can guide marketing, pricing, and operational decisions. By using SQL for data exploration, we efficiently filtered and summarized the information necessary to support data-driven strategies.
