-- SQL Syntax for Data Cleaning and Manipulation using DBeaver's Sample Database (SQLite)

-- Casting Values
-- Convert a numeric value to VARCHAR
SELECT CAST (25.65 AS VARCHAR);

-- Convert an entire column's datatype from CustomerId (INTEGER) to VARCHAR
SELECT CAST (CustomerId AS VARCHAR) FROM Customer;

-- Working with Dates in SQLite
-- Current Date in YYYY-MM-DD format
SELECT DATE('now');

-- Last day of the current month calculation
SELECT DATE('now', 'start of month', '+1 month') AS LastDayMonth;

-- Convert Unix timestamp to readable datetime format
SELECT datetime(1193961488, 'unixepoch');
SELECT DATETIME(1707349396, 'unixepoch', 'localtime');

-- Calculate the number of days since a specific date (e.g., Canada's Confederation)
SELECT ROUND(JULIANDAY('now') - JULIANDAY('1867-07-01')) AS CanadaDays;

-- Calculate age at the time of hiring
SELECT FirstName, LastName,
    (STRFTIME('%Y', HireDate) - STRFTIME('%Y', BirthDate)) -
    (STRFTIME('%m-%d', HireDate) < STRFTIME('%m-%d', BirthDate)) AS HireAge
FROM Employee
ORDER BY BirthDate;

-- Filtering employees born after 1958
SELECT FirstName, LastName, CAST (BirthDate AS INTEGER) FROM Employee WHERE BirthDate > 1958;

-- Data Definition Language (DDL) Examples
-- Dropping and Creating Tables with specific constraints and relationships

-- Drop Customers table if it exists
DROP TABLE IF EXISTS Customers;

-- Create Customers table
CREATE TABLE Customers (
  CustomerID INTEGER PRIMARY KEY,
  Name TEXT,
  Segment TEXT,
  City TEXT,
  State TEXT,
  PostalCode VARCHAR(20),
  Region TEXT
);

-- Drop Orders table if it exists
DROP TABLE IF EXISTS Orders;

-- Create Orders table with foreign keys
CREATE TABLE Orders (
  Order_ID VARCHAR(20) NOT NULL PRIMARY KEY,
  Order_Date DATE NOT NULL,
  Sales DECIMAL(18,2),
  Quantity INT NOT NULL,
  Cust_ID INTEGER REFERENCES Customers(CustomerID),
  Product_ID INTEGER NOT NULL REFERENCES Products(Product_ID)
);

-- Drop Products table if it exists
DROP TABLE IF EXISTS Products;

-- Create Products table
CREATE TABLE Products (
  Product_ID INTEGER NOT NULL PRIMARY KEY,
  Category VARCHAR(50) NOT NULL,
  Sub_Category TEXT NOT NULL
);

-- Inserting Data into Tables
-- Populating Customers table with sample data
INSERT INTO Customers (CustomerID, Name, Segment, City, State, PostalCode, Region)
VALUES
  (12520, 'Claire Gute', 'Consumer', 'Henderson', 'Kentucky', '42420', 'South'),
  (13045, 'Darrin Van Huff', 'Corporate', 'Los Angeles', 'California', '90036', 'West'),
  (20335, 'Sean ODonnell', 'Consumer', 'Fort Lauderdale', 'Florida', '33311', 'South'),
  (11710, 'Brosina Hoffman', 'Consumer', 'Los Angeles', 'California', '90032', 'West'),
  (10480, 'Andrew Allen', 'Consumer', 'Concord', 'North Carolina', '28027', 'South'),
  (15070, 'Irene Maddox', 'Consumer', 'Seattle', 'Washington', '98103', 'West'),
  (14815, 'Harold Pawlan', 'Home Office', 'Fort Worth', 'Texas', '76106', 'Central'),
  (13868, 'Darrin Van Huff', 'Corporate', NULL, 'California', '90036', 'West');

-- Populating Orders table with sample data
INSERT INTO Orders (Order_ID, Order_Date, Sales, Quantity, Cust_ID, Product_ID)
VALUES
('2019-145317',    '3/18/2019',  	22638.48,   6,  	12520,  	'FUR-BO-10001798'),
('2021-118689',    '10/2/2022', 	17499.95,   5,	12520,  	'FUR-CH-10000454'),
('2022-140151',   '3/23/2022',  	13999.96,   4,  	13045,  	'OFF-LA-10000240'),
('2022-127180',   '10/22/2022', 	11199.97,   4,  	20335,  	'FUR-TA-10000577'),
('2022-166709',   '11/17/2022', 	10499.97,   3,  	20335,  	'OFF-ST-10000760'),
('2021-117121',   '12/17/2021', 	9892.74,     13,  11710,  	'FUR-FU-10001487'),
('2019-116904',   '9/23/2019',  	9449.95,      5,  	11710,  	'OFF-AR-10002833');

-- Populating Products table with sample data
INSERT INTO Products (Product_ID, Category, Sub_Category)
VALUES
(10001798,'Furniture','Bookcases');
INSERT INTO Products
VALUES
(10002640,'Technology','Phones'),
(10000240,'Office Supplies','Labels'),
(10000577,'Furniture','Tables'),
(10000760,'Office Supplies','Storage'),
(10000562,'Technology','Phones');

-- Table Alterations and Updates
-- Add a new column to Products table
ALTER TABLE Products ADD COLUMN Origin TEXT;

-- Remove the 'Origin' column from Products table
ALTER TABLE Products DROP COLUMN Origin;

-- Rename a column in Products table from Sub_Category to CategoryDesc
ALTER TABLE Products RENAME COLUMN Sub_Category TO CategoryDesc;

-- Update data in Customers table (Region modification)
UPDATE Customers
SET Region = REPLACE(Region, 'South', 'USA_South');

-- Using CASE clause for conditional logic in SELECT statements
SELECT Name, Segment,
  CASE 
    WHEN Segment = 'Consumer' AND State = 'North Carolina' THEN 'ConsumersNC'
    WHEN Segment = 'Consumer' AND State = 'California' THEN 'ConsumersCA'
    ELSE 'Others' 
  END AS Segment_States
FROM Customers;

