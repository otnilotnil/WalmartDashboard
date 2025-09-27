--  COUNT Payment Method and percentage from totalm sales
SELECT 
	DISTINCT PAYMENT_METHOD,
	COUNT(*) AS "Count",
	CONCAT(ROUND(COUNT(Payment_Method)/ SUM(COUNT(*)) OVER(),2) * 100, "%") AS "Percentage"
FROM WALMART
GROUP BY PAYMENT_METHOD
ORDER BY COUNT(*) DESC;

-- Shows the branches
SELECT 
	COUNT(DISTINCT BRANCH)
FROM WALMART;

