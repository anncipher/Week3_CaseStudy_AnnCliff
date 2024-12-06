# a. Find customers who made purchases every month
SELECT c.CustomerID, CustomerName
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE YEAR(Sale_Date) = 2023
GROUP BY c.CustomerID
HAVING COUNT(DISTINCT MONTH(Sale_Date)) = 12;

# b. Calculate the percentage of repeat customers
SELECT 
  (SUM(CASE WHEN Transaction_Count > 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(CustomerID)) AS Repeat_Customer_Percentage
FROM (
  SELECT CustomerID, COUNT(*) AS Transaction_Count
  FROM Sales
  GROUP BY CustomerID
) t;

