# a. List the top 5 most frequently purchased products
SELECT ProductName, SUM(Quantity) AS Total_Quantity_Sold
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY ProductName
ORDER BY Total_Quantity_Sold DESC
LIMIT 5;

# b. Calculate the total sales for each product category
SELECT Category, SUM(Quantity * Price) AS Total_Sales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY Category
ORDER BY Total_Sales DESC;



