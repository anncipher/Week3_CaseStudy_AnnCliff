CREATE DATABASE TechMart;
USE TechMart;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Age INT,
    Location VARCHAR(100)
);
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(10, 2)
);
CREATE TABLE Stores (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(100),
    City VARCHAR(100)
);
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    StoreID INT,
    Quantity INT,
    Sale_Date DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);
# To verify imported data
SELECT * 
FROM Customers;
SELECT * 
FROM Products;
SELECT * 
FROM Stores;
SELECT * 
FROM Sales;

# Analyzing data using some key metrics to draw insights
# 1. Find the most frequent buyers
SELECT c.CustomerName, COUNT(s.SaleID) AS Purchases
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerName
ORDER BY Purchases DESC;

# 2. Identify the top-selling products
SELECT p.ProductName, SUM(s.Quantity) AS Total_Sold
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName
ORDER BY Total_Sold DESC;

# 3. Calculate total sales per store
SELECT st.City, SUM(s.Quantity * p.Price) AS Total_Sales
FROM Stores st
JOIN Sales s ON st.StoreID = s.StoreID
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY st.City
ORDER BY Total_Sales DESC;

# 4. Calculate daily sales
SELECT Sale_Date, SUM(Quantity * Price) AS Daily_Sales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY Sale_Date
ORDER BY Sale_Date;

# Possible Recommendations to improve sales and improve customer satisfaction:
# - Offer loyalty rewards to frequent buyers.
# - Promote top-selling products in underperforming regions.
# - Restock high-demand products in regions with higher sales.

# DATA CLEANING AND EXPLORATION
# Identify missing or inconsistent data
# For null data
SELECT * FROM Customers WHERE CustomerName IS NULL OR Location IS NULL;
SELECT * FROM Products WHERE ProductName IS NULL OR Price IS NULL;
SELECT * FROM Sales WHERE Quantity IS NULL OR Sale_Date IS NULL;

# For duplicate data
SELECT CustomerID, COUNT(*) 
FROM Customers 
GROUP BY CustomerID 
HAVING COUNT(*) > 1;

# Identify inconsistent entries (e.g. ensuring uniform city names)
SELECT DISTINCT City 
FROM Stores;

# Identify invalid quantities or prices and delete them
DELETE FROM Sales WHERE Quantity < 0;
DELETE FROM Products WHERE Price <= 0;

# Filtering data using WHERE clauses
# Retrieve sales data for a specific product
SELECT * 
FROM Sales 
WHERE ProductID = 10;

# Retrieve sales made during a time period
SELECT * 
FROM Sales
WHERE Sale_Date BETWEEN '2023-05-01' AND '2023-12-31';

# Using JOIN operation to merge data across tables
# Retrieve sales details with customers names and product names
SELECT CustomerName, ProductName, Quantity, Sale_Date
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
JOIN Products p ON s.ProductID = p.ProductID;

# Summarize data using Aggregate functions
# Calculate total sales per product
SELECT ProductName, SUM(Quantity) AS Total_Sold
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY ProductName
ORDER BY Total_Sold DESC;

# Calculate average purchase value by customer
SELECT CustomerName, AVG(Quantity * Price) AS Avg_Purchase_Value
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY CustomerName;

# Calculate sales distribution by region
SELECT st.City, SUM(customersCustomerNameQuantity * Price) AS Total_Sales
FROM Stores st
JOIN Sales s ON s.StoreID = st.StoreID
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY st.City;

# Filter results using Comparison operators
# Identify month with highest sales
SELECT Sale_Date, SUM(Quantity * Price) AS Monthly_Sales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY Sale_Date
HAVING Monthly_Sales > 4000;

# Creating reusable query results using VIEWS
# Creating a view to summarize sales by product
CREATE VIEW ProductSalesSummary AS
SELECT ProductName, SUM(Quantity) AS Total_Quantity, SUM(Quantity * Price) AS Total_Revenue
FROM Sales s
JOIN Products p ON s.productID = p.productID
GROUP BY ProductName;

# To see the View data
SELECT * 
FROM ProductSalesSummary 
WHERE Total_Revenue > 5000;




