SELECT *
FROM [Coffee Shop Sales];

--Total Sales Analyst by MONTH
SELECT ROUND(SUM(unit_price * transaction_qty),1) as [Total Sales]
FROM [Coffee Shop Sales] 
WHERE MONTH(transaction_date) = 5

SELECT ROUND(SUM(unit_price * transaction_qty),1) as [Total Sales]
FROM [Coffee Shop Sales] 
WHERE MONTH(transaction_date) = 3

-- Compare % in sales between the selected month snf the previous month (such as 4 and 5)
SELECT
	MONTH(transaction_date) as Month,
	ROUND(SUM(unit_price * transaction_qty),1) as [Total Sales],
	(SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty),1) OVER (ORDER BY MONTH(transaction_date))) / LAG(SUM(unit_price * transaction_qty),1) OVER (ORDER BY MONTH(transaction_date)) * 100
FROM [Coffee Shop Sales]
WHERE MONTH(transaction_date) between 4 and 5
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date)

-- Compare amount in sales between the selected month snf the previous month (such as 4 and 5)
SELECT
	MONTH(transaction_date) as Month,
	ROUND(SUM(unit_price * transaction_qty),1) as [Total Sales],
	(SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty),1) OVER (ORDER BY MONTH(transaction_date)))
FROM [Coffee Shop Sales]
WHERE MONTH(transaction_date) between 4 and 5
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date)

--Total Order
SELECT COUNT(Transaction_id) as Total_Orders
FROM [Coffee Shop Sales]
WHERE MONTH(transaction_date) = 5

SELECT
	MONTH(transaction_date) as Month,
	COUNT(Transaction_id) as Total_Orders,
	CAST(((CAST(COUNT(Transaction_id) AS DECIMAL(10,5))) - LAG(CAST(COUNT(Transaction_id) AS DECIMAL(10,5)),1) OVER (ORDER BY MONTH(transaction_date))) / LAG(CAST(COUNT(Transaction_id) AS DECIMAL(10,5)),1) OVER (ORDER BY MONTH(transaction_date)) AS decimal(10,5)) * 100
FROM [Coffee Shop Sales]
WHERE MONTH(transaction_date) between 4 and 5
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date)