# a. Calculate the total monthly sales for the year
SELECT 
  DATE_FORMAT(Sale_Date, '%Y-%m') AS Month, 
  SUM(Quantity * Price) AS Total_Sales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(Sale_Date) = 2023 
GROUP BY Month
ORDER BY Month;

# b. Identify the store generating the highest revenue
SELECT StoreName, SUM(Quantity * Price) AS Total_Revenue
FROM Sales s
JOIN Stores st ON s.StoreID = st.StoreID
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY StoreName
ORDER BY Total_Revenue DESC
LIMIT 1;
