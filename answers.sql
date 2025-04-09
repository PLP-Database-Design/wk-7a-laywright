/*Question 1*/

WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 10
)
SELECT 
    p.OrderID,
    p.CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(p.Products, ',', n.n), ',', -1)) AS Product
FROM 
    ProductDetail p
JOIN 
    numbers n
ON 
    n.n <= LENGTH(p.Products) - LENGTH(REPLACE(p.Products, ',', '')) + 1;




/*Question 2*/
-- Create Orders table 
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderProducts table
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Populate Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Populate OrderProducts table
INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
