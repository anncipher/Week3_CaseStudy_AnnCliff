# a. Compare sales across regions (e.g., North, South, East, West)
# Add a "Region" column to Stores table and update with a CASE statement:
ALTER TABLE Stores ADD Region VARCHAR(20);
UPDATE Stores
SET Region = CASE
    WHEN city IN ('Philadelphia') THEN 'Northeast'
    WHEN city IN ('Chicago') THEN 'Midwest'
    WHEN city IN ('Houston', 'San Antonio', 'Dallas') THEN 'South'
    WHEN city IN ('New York', 'Los Angeles', 'Phoenix', 'San Diego', 'San Jose') THEN 'West'
    ELSE 'Other'
END;

SELECT st.Region, SUM(Quantity * Price) AS Total_Sales
FROM Sales s
JOIN Stores st ON s.StoreID = st.StoreID
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY st.Region
ORDER BY Total_Sales DESC;

# b. Identify the region with the highest average sale value
SELECT st.Region, AVG(Quantity * Price) AS Avg_Sale_Value
FROM Sales s
JOIN Stores st ON s.StoreID = st.StoreID
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY st.Region
ORDER BY Avg_Sale_Value DESC
LIMIT 1;
