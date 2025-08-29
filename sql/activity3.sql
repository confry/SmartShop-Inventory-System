-- ===============================================
-- Activity 3: Optimized SQL Queries for SmartShop
-- ===============================================

-- 1. Optimized JOIN Products, Sales, and Suppliers
-- Added proper JOIN conditions, only select needed columns
SELECT p.ProductName, s.SaleDate, s.StoreLocation, s.UnitsSold
FROM Sales s
INNER JOIN Products p ON s.ProductID = p.ProductID
INNER JOIN Suppliers sup ON p.SupplierID = sup.SupplierID;

-- 2. Total sales per product (optimized using GROUP BY instead of subquery)
SELECT p.ProductName, SUM(s.UnitsSold) AS TotalUnitsSold
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName
ORDER BY TotalUnitsSold DESC;

-- 3. Suppliers with the most delayed deliveries
-- Added index suggestion on DeliveryDate and SupplierID
CREATE INDEX idx_deliveries_supplier_date ON Deliveries(SupplierID, DeliveryDate);

SELECT sup.SupplierName, COUNT(*) AS DelayedDeliveries
FROM Suppliers sup
JOIN Deliveries d ON sup.SupplierID = d.SupplierID
WHERE d.DeliveryDate > d.ExpectedDate
GROUP BY sup.SupplierName
ORDER BY DelayedDeliveries DESC;

-- 4. Sales trends: total units sold per product (same as optimized total sales)
-- Already optimized by using GROUP BY
SELECT p.ProductName, SUM(s.UnitsSold) AS TotalUnitsSold
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName
ORDER BY TotalUnitsSold DESC;

-- 5. Average stock level per store
-- Index suggestion on StoreLocation and StockLevel
CREATE INDEX idx_inventory_store_stock ON Inventory(StoreLocation, StockLevel);

SELECT StoreLocation, AVG(StockLevel) AS AvgStock
FROM Inventory
GROUP BY StoreLocation;

-- 6. Consolidated report: Inventory across all stores
-- Avoids unnecessary joins or computations
SELECT p.ProductName, SUM(i.StockLevel) AS TotalStock
FROM Products p
JOIN Inventory i ON p.ProductID = i.ProductID
GROUP BY p.ProductName
ORDER BY TotalStock DESC;

