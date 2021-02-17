-- with rollup
SELECT productCode, MAX(price), MIN(price), 
CAST(AVG(price) AS DECIMAL(7,2)) AS `Average`, SUM(quantity)
FROM products GROUP BY productCode WITH ROLLUP ; -- 총계

-- update
UPDATE products SET price = price * 1.1 WHERE TRUE ;
SELECT * FROM products ;
UPDATE products SET quantity = quantity - 100 WHERE name = 'Pen Red' ;
SELECT * FROM products WHERE name = 'Pen Red' ;
UPDATE products SET quantity = quantity + 50, price = 1.23 WHERE name = 'Pen Red' ;
SELECT * FROM products WHERE name = 'Pen Red' ;

-- Delete
DELETE FROM products WHERE name LIKE 'Pencil%' ;
SELECT * FROM products ;

-- one to many
DROP TABLE IF EXISTS suppliers ;
CREATE TABLE suppliers (
	supplierID  INT UNSIGNED  NOT NULL AUTO_INCREMENT, 
	name        VARCHAR(30)   NOT NULL DEFAULT '', 
	phone       CHAR(8)       NOT NULL DEFAULT '',
	PRIMARY KEY (supplierID)
) ;

INSERT INTO suppliers VALUE
(501, 'ABC Traders', '88881111'), 
(502, 'XYZ Company', '88882222'), 
(503, 'QQ Corp', '88883333') ;

SELECT * FROM suppliers ;

-- alter table
ALTER TABLE products ADD COLUMN supplierID INT UNSIGNED NOT NULL ;

UPDATE products SET supplierID = 501 WHERE TRUE ;

ALTER TABLE products
ADD FOREIGN KEY (supplierID) REFERENCES suppliers (supplierID) ;

UPDATE products SET supplierID = 502 WHERE productID  = 2004 ;

SELECT * FROM products ;

-- insert
DELETE FROM products ;

INSERT INTO products(productId, productCode, NAME, quantity, price, supplierid)
VALUES 
(2001, 'PEC', 'Pencil 3B', 500, 0.52, 501 ),
(2002, 'PEC', 'Pencil 4B', 200, 0.62, 501 ),
(2003, 'PEC', 'Pencil 5B', 100, 0.73 ,501 ),
(2004, 'PEC', 'Pencil 6B', 500, 0.47, 502 ) ;

-- SELECT with JOIN
SELECT products.name, price, suppliers.name 
FROM products 
JOIN suppliers ON products.supplierID = suppliers.supplierID
WHERE price < 0.6 ;

SELECT products.name, price, suppliers.name 
FROM products, suppliers 
WHERE products.supplierID = suppliers.supplierID
AND price < 0.6 ;

SELECT products.name AS `Product Name`, price, suppliers.name AS `Supplier Name` 
FROM products 
JOIN suppliers ON products.supplierID = suppliers.supplierID
WHERE price < 0.6 ;

SELECT p.name AS `Product Name`, p.price, s.name AS `Supplier Name` 
FROM products AS p 
JOIN suppliers AS s ON p.supplierID = s.supplierID
WHERE p.price < 0.6 ;

-- many to many
CREATE TABLE products_suppliers (
   productID   INT UNSIGNED  NOT NULL,
   supplierID  INT UNSIGNED  NOT NULL, 
   
   PRIMARY KEY (productID, supplierID), 
   
   FOREIGN KEY (productID)  REFERENCES products  (productID),
   FOREIGN KEY (supplierID) REFERENCES suppliers (supplierID)
 ) ;
 
 INSERT INTO products_suppliers VALUES 
 (2001, 501), (2002, 501),
 (2003, 501), (2004, 502), (2001, 503) ;
 
 SELECT * FROM products_suppliers ;
 
-- query of many-to-many
SELECT products.name AS `Product Name`, price, suppliers.name AS `Supplier Name`
FROM products_suppliers 
JOIN products  ON products_suppliers.productID = products.productID
JOIN suppliers ON products_suppliers.supplierID = suppliers.supplierID
WHERE price < 0.6 ;

SELECT p.name AS `Product Name`, s.name AS `Supplier Name`
FROM products_suppliers AS ps 
JOIN products AS p ON ps.productID = p.productID
JOIN suppliers AS s ON ps.supplierID = s.supplierID
WHERE p.name = 'Pencil 3B' ;

SELECT p.name AS `Product Name`, s.name AS `Supplier Name`
FROM products AS p, products_suppliers AS ps, suppliers AS s
WHERE p.productID = ps.productID
AND ps.supplierID = s.supplierID
AND s.name = 'ABC Traders' ;

-- one-to-one , child-parent
CREATE TABLE product_details (
	productID  INT UNSIGNED   NOT NULL , 
	comment    TEXT  NULL, 
	
	PRIMARY KEY (productID),
	FOREIGN KEY (productID) REFERENCES products (productID)
) ;


-- 
