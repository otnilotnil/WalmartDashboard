-- Payment Method Sale count comparison to generated revenue
SELECT 
PAYMENT_METHOD,
COUNT(*),
ROUND(SUM(TOTAL_PRICE)/ SUM(SUM(TOTAL_PRICE)) OVER(),2) * 100 AS "Revenue Percentage",
ROUND(COUNT(*)/ SUM(COUNT(*)) OVER(),2) * 100 AS "Sale Count Percentage"
FROM WALMART
GROUP BY PAYMENT_METHOD;

-- Peak shopping hours
SELECT HOUR(STR_TO_DATE(time, '%H:%i:%s')) AS hour_of_day,
       ROUND(SUM(total_price),2) AS revenue
FROM WALMART
GROUP BY hour_of_day
ORDER BY revenue DESC;

-- Highest rated category per branch
SELECT BRANCH, CATEGORY, avg_rating FROM ( -- No need to select ranked as we only want the highest ranked category anyways
	SELECT
		BRANCH,
        CATEGORY,
        ROUND(AVG(RATING),2) AS avg_rating,
		RANK() OVER(PARTITION BY BRANCH ORDER BY AVG(RATING) DESC) AS ranked
	FROM WALMART
    GROUP BY BRANCH,CATEGORY
) as temp
WHERE ranked = 1;

--  Sales per month
SELECT DATE_FORMAT(STR_TO_DATE(date, '%d/%m/%y'), '%y/%m') AS YearMonth,
       ROUND(SUM(total_price),2) AS monthly_sales
FROM WALMART
GROUP BY YearMonth
ORDER BY YearMonth;

-- Rating analytics for each city
-- We can see how each category performs in each city
SELECT 
	CITY,
    CATEGORY,
    ROUND(AVG(RATING),2) AS AVG_RATING,
    MIN(RATING) AS MIN_RATING,
    MAX(RATING) AS MIN_RATING
FROM WALMART
GROUP BY CITY,CATEGORY;

-- Profit brought by each category, compared to revenue generated

SELECT 
	CATEGORY,
    ROUND(SUM(PROFIT_MARGIN * TOTAL_PRICE),2) AS TOTAL_PROFIT,
    SUM(TOTAL_PRICE) AS REVENUE,
    CONCAT(ROUND(SUM(PROFIT_MARGIN * TOTAL_PRICE)/SUM(TOTAL_PRICE),2) * 100,"%") AS PROFIT_MARGIN
FROM WALMART
GROUP BY CATEGORY
ORDER BY TOTAL_PROFIT;
