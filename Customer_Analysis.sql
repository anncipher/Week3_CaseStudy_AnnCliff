# a. Identify the top 5 cities with the highest number of unique customers
SELECT st.City, COUNT(DISTINCT c.CustomerID) AS Unique_Customers
FROM Customers c
JOIN Stores st ON c.Location = st.City
GROUP BY st.City
ORDER BY Unique_Customers DESC
LIMIT 5;

# b. Determine the age group that spends the most on average
#  Divide age groups into 18-25, 26-35, 36-45, 46-55, 56-65, etc.
SELECT 
  CASE 
    WHEN Age BETWEEN 18 AND 25 THEN '18-25'
    WHEN Age BETWEEN 26 AND 35 THEN '26-35'
    WHEN Age BETWEEN 36 AND 45 THEN '36-45'
    WHEN Age BETWEEN 46 AND 55 THEN '46-55'
    WHEN Age BETWEEN 56 AND 65 THEN '56-65'
    ELSE '66+' 
  END AS Age_Group,
  AVG(Quantity * Price) AS Avg_Spending
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY Age_Group
ORDER BY Avg_Spending DESC;