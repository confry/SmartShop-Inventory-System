-- 1. Recuperar detalles de productos
SELECT ProductName, Category, Price, StockLevel
FROM Products;

-- 2. Filtrar productos por categoría (ejemplo: 'Electronics')
SELECT ProductName, Category, Price, StockLevel
FROM Products
WHERE Category = 'Electronics';

-- 3. Filtrar productos con bajo nivel de stock (ejemplo: menos de 10 unidades)
SELECT ProductName, Category, Price, StockLevel
FROM Products
WHERE StockLevel < 10;

-- 4. Ordenar productos por precio (ascendente)
SELECT ProductName, Category, Price, StockLevel
FROM Products
ORDER BY Price ASC;
