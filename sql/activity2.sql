-- ===============================================
-- Activity 2: Advanced SQL Queries for SmartShop
-- ===============================================

-- 1. JOIN Products, Sales, and Suppliers
SELECT p.ProductName, s.SaleDate, s.StoreLocation, s.UnitsSold
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
JOIN Suppliers sup ON p.SupplierID = sup.SupplierID;

-- 2. Subquery: Calculate total sales for each product
SELECT p.ProductName,
       (SELECT SUM(s.UnitsSold)
        FROM Sales s
        WHERE s.ProductID = p.ProductID) AS TotalUnitsSold
FROM Products p;

-- 3. Identify suppliers with the most delayed deliveries
SELECT SupplierName, COUNT(*) AS DelayedDeliveries
FROM Suppliers sup
JOIN Deliveries d ON sup.SupplierID = d.SupplierID
WHERE d.DeliveryDate > d.ExpectedDate
GROUP BY SupplierName
ORDER BY DelayedDeliveries DESC;

-- 4. Aggregate: Sales trends (total units sold per product)
SELECT p.ProductName, SUM(s.UnitsSold) AS TotalUnitsSold
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName
ORDER BY TotalUnitsSold DESC;

-- 5. Aggregate: Average stock level per store
SELECT StoreLocation, AVG(StockLevel) AS AvgStock
FROM Inventory
GROUP BY StoreLocation;

-- 6. Consolidated report: Inventory across all stores
SELECT p.ProductName, SUM(i.StockLevel) AS TotalStock
FROM Products p
JOIN Inventory i ON p.ProductID = i.ProductID
GROUP BY p.ProductName
ORDER BY TotalStock DESC;
