-- my sql example
CREATE DATABASE southwind ;

CREATE TABLE IF NOT EXISTS products (
	productID    INT UNSIGNED  NOT NULL AUTO_INCREMENT,
	productCode  CHAR(3)       NOT NULL DEFAULT '',
	name         VARCHAR(30)   NOT NULL DEFAULT '',
	quantity     INT UNSIGNED  NOT NULL DEFAULT 0,
	price        DECIMAL(7,2)  NOT NULL DEFAULT 99999.99,
	PRIMARY KEY  (productID)
) ;

SHOW TABLES ;

DESCRIBE products ;

SHOW CREATE TABLE products ;

INSERT INTO products VALUES (1001, 'PEN', 'Pen Red', 5000, 1.23) ;
INSERT INTO products VALUES
(NULL, 'PEN', 'Pen Blue',  8000, 1.25),
(NULL, 'PEN', 'Pen Black', 2000, 1.25) ;

INSERT INTO products (productCode, name, quantity, price) VALUES
('PEC', 'Pencil 2B', 10000, 0.48),
('PEC', 'Pencil 2H', 8000, 0.49) ;

INSERT INTO products (productCode, name) VALUES ('PEC', 'Pencil HB') ;

INSERT INTO products values (NULL, NULL, NULL, NULL, NULL) ; -- ERROR

SELECT * FROM products ;

DELETE FROM products WHERE productID = 1006 ;

-- Comparison Operators
SELECT name, price FROM products ;
SELECT name, price FROM products WHERE price < 1.0 ;
SELECT name, quantity FROM products WHERE quantity <= 2000 ;

-- Logical Operators - AND, OR, NOT, XOR
SELECT name, price FROM products WHERE productCode = 'PEN' ;
SELECT name, price FROM products WHERE name LIKE 'PENCIL%' ;
SELECT name, price FROM products WHERE name LIKE 'P__ %' ;
SELECT * FROM products WHERE quantity >= 5000 AND name LIKE 'Pen %' ;
SELECT * FROM products WHERE quantity >= 5000 AND price < 1.24 AND name LIKE 'Pen %' ;
SELECT * FROM products WHERE NOT (quantity >= 5000 AND name LIKE 'Pen %') ;

-- IN, NOT IN
SELECT * FROM products WHERE name IN ('Pen Red', 'Pen Black') ;
SELECT * FROM products 
WHERE (price BETWEEN 1.0 AND 2.0) AND (quantity BETWEEN 1000 AND 2000) ;

-- IS NULL, IS NOT NULL
SELECT * FROM products WHERE productCode IS NULL ;
SELECT * FROM products WHERE productCode = NULL ; -- LOGICAL ERROR

-- ORDER BY
SELECT * FROM products ORDER BY RAND() ;

-- LIMIT
SELECT * FROM products ORDER BY price LIMIT 2 ;
SELECT * FROM products ORDER BY price LIMIT 2, 1 ;

-- Alias
SELECT productID AS ID, productCode AS CODE,
name AS Description, price AS `Unit Price`
FROM products ORDER BY ID ; 

-- CONCAT() , 문자열 덧셈
SELECT CONCAT( productCode, ' - ', NAME ) AS `Product Description`, price 
FROM products ;

-- DISTINCT
SELECT DISTINCT price AS `Distinct Price` FROM products ;
SELECT DISTINCT price, name FROM products ;

-- GROUP BY
SELECT * FROM products GROUP BY productCode ;

-- GROUP BY Aggregate Function
SELECT COUNT(*) AS `Count` FROM products ;
SELECT productCode, COUNT(*) FROM products GROUP BY productCode ;
SELECT productCode, COUNT(*) AS COUNT 
FROM products GROUP BY productCode ORDER BY count DESC ;
SELECT MAX(price), MIN(price), AVG(price), STD(price), SUM(quantity) FROM products ;
SELECT productCode, MAX(price) AS `Highest Price`, MIN(price) AS `Lowest Price`
FROM products GROUP BY productCode ;
SELECT productCode, MAX(price), MIN(price),
CAST(AVG(price) AS DECIMAL(7,2)) AS `Average`,
CAST(STD(price) AS DECIMAL(7,2)) AS `Std Dev`,
SUM(quantity)
FROM products GROUP BY productCode ;

-- HAVING
SELECT productCode AS `Product Code`,
COUNT(*) AS `Count`, CAST(AVG(price) AS DECIMAL(7,2)) AS `Average`
FROM products GROUP BY productCode HAVING COUNT >=3 ;

-- without rollup
SELECT productCode, MAX(price), MIN(price), 
CAST(AVG(price) AS DECIMAL(7,2)) AS `Average`, SUM(quantity)
FROM products GROUP BY productCode ; -- 소계

-- with rollup
SELECT productCode, MAX(price), MIN(price), 
CAST(AVG(price) AS DECIMAL(7,2)) AS `Average`, SUM(quantity)
FROM products GROUP BY productCode WITH ROLLUP ; -- 총계


