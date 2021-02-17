SELECT CAST( '1' AS INT ) , '1' FROM DUAL ;

SELECT CAST( '1' AS INT ) , CAST( 1 AS VARCHAR(1) ) FROM DUAL ;

SELECT '2' + 1 FROM DUAL ; -- Java '21', Maria 3

SELECT '2' + 0 FROM DUAL ; 

SELECT INSTR( 'ABC', '' ) FROM DUAL ; -- 1
SELECT INSTR( 'ABC', 'A' ) FROM DUAL ; -- 1
SELECT INSTR( 'ABC', 'B' ) FROM DUAL ; -- 2

SELECT * FROM countries WHERE NAME LIKE '%K%' ;
SELECT * FROM countries WHERE INSTR( NAME, 'K' ) > 0 ;

SELECT * FROM countries 
WHERE INSTR( NAME, 'K' ) > 0 
ORDER BY INSTR( NAME, 'K' ) ;

SELECT INSTR( NAME, 'K' ) idx, c.* FROM countries c
WHERE INSTR( NAME, 'K' ) > 0  
ORDER BY idx ;

CREATE TABLE areas ( ... );
CREATE TABLE AREAS ( ... );

SELECT * FROM areas ;
select * from AREAS ;

SELECT * FROM `AREAS` ; -- o
SELECT * FROM `areas` ; -- X
SELECT * FROM `AreaS` ; -- X

CREATE TABLE `면적` ( `넓이` INT ) ;
INSERT INTO `면적` VALUES (1), (2), (3) ;
SELECT * FROM `면적` ;

-- WITH
CREATE TABLE t1 (from_ int, to_ INT) ;
INSERT INTO t1 VALUES (1,2), (1,100), (2,3), (3,4), (4,1) ;

SET max_recursive_iterations=10 ;

WITH RECURSIVE cte (depth, from_, to_) AS ( 
  SELECT 0,1,1 UNION DISTINCT SELECT depth+1, t1.from_, t1.to_ 
  FROM t1, cte  WHERE t1.from_ = cte.to_ 
) 
SELECT * FROM cte ;

-- WITH 2
WITH recursive num AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM num WHERE n < 10000 
)
SELECT n FROM num ;

-- WITH 3 
DROP TABLE if EXISTS t1 ;
CREATE TABLE t1 (a int, b VARCHAR(200)) ;

INSERT INTO t1 VALUES 
(1,'A'), (1, 'Z'), (2, 'C'), (3,'D'), (4,'A') ;

WITH t AS (SELECT a FROM t1 WHERE b >= 'c') 
SELECT * FROM t1, t WHERE t1.a = t.a ; 

SELECT * FROM 
t1 AS t1, 
(SELECT a FROM t1 WHERE b >= 'c') AS t
WHERE t1.a = t.a ; 

-- Merge
CREATE TABLE ins_duplicate (id INT PRIMARY KEY, animal VARCHAR(30)) ;
INSERT INTO ins_duplicate VALUES 
(1,'Aardvark'), (2,'Cheetah'), (3,'Zebra') ;

INSERT INTO ins_duplicate VALUES (4,'Gorilla') 
ON DUPLICATE KEY UPDATE animal='Gorilla' ;

INSERT INTO ins_duplicate VALUES (1,'Antelope') ; -- ERROR

INSERT INTO ins_duplicate VALUES (1,'Antelope') 
ON DUPLICATE KEY UPDATE animal='Antelope' ;

SELECT * FROM ins_duplicate ;

-- Window Function
-- LAG
DROP TABLE t1 ;

CREATE TABLE t1 
(pk int primary KEY, 
  a int, b int, c char(10),
  d decimal(10, 3), e REAL
) ;

INSERT INTO t1 VALUES
( 1, 0, 1,    'one',    0.1,  0.001),
( 2, 0, 2,    'two',    0.2,  0.002),
( 3, 0, 3,    'three',  0.3,  0.003),
( 4, 1, 2,    'three',  0.4,  0.004),
( 5, 1, 1,    'two',    0.5,  0.005),
( 6, 1, 1,    'one',    0.6,  0.006),
( 7, 2, NULL, 'n_one',  0.5,  0.007),
( 8, 2, 1,    'n_two',  NULL, 0.008),
( 9, 2, 2,    NULL,     0.7,  0.009),
(10, 2, 0,    'n_four', 0.8,  0.010),
(11, 2, 10,   NULL,     0.9,  NULL) 
 ;

SELECT pk, 
  LAG(pk) OVER (ORDER BY pk) AS l,
  LAG(pk,1) OVER (ORDER BY pk) AS l1,
  LAG(pk,2) OVER (ORDER BY pk) AS l2,
  LAG(pk,0) OVER (ORDER BY pk) AS l0,
  LAG(pk,-1) OVER (ORDER BY pk) AS lm1,
  LAG(pk,-2) OVER (ORDER BY pk) AS lm2
FROM t1 ;

-- LEAD

SELECT pk, 
  LEAD(pk) OVER (ORDER BY pk) AS l,
  LEAD(pk,1) OVER (ORDER BY pk) AS l1,
  LEAD(pk,2) OVER (ORDER BY pk) AS l2,
  LEAD(pk,0) OVER (ORDER BY pk) AS l0,
  LEAD(pk,-1) OVER (ORDER BY pk) AS lm1,
  LEAD(pk,-2) OVER (ORDER BY pk) AS lm2 
FROM t1 ;

-- RANK
CREATE TABLE student(course VARCHAR(10), mark int, name varchar(10)) ;

INSERT INTO student VALUES 
('Maths', 60, 'Thulile'),
('Maths', 60, 'Pritha'),
('Maths', 70, 'Voitto'),
('Maths', 55, 'Chun'),
('Biology', 60, 'Bilal'),
('Biology', 70, 'Roger') ;

SELECT 
RANK() OVER (PARTITION BY course ORDER BY mark DESC) AS rank, 
DENSE_RANK() OVER (PARTITION BY course ORDER BY mark DESC) AS dense_rank, 
ROW_NUMBER() OVER (PARTITION BY course ORDER BY mark DESC) AS row_num, 
course, mark, name 
FROM student ORDER BY course, mark DESC ;

SELECT RANK() OVER () AS rank FROM student ; -- ERROR
SELECT RANK() OVER (PARTITION BY course) AS rank FROM student ; -- ERROR
SELECT RANK() OVER (ORDER BY course) AS rank FROM student ;
SELECT RANK() OVER (PARTITION BY course ORDER BY mark) AS rank FROM student ;

SELECT ROW_NUMBER() rno, c.* FROM countries c ; -- ERROR
SELECT ROW_NUMBER() over() AS rno, c.* FROM countries c ;
SELECT ROW_NUMBER() over( ORDER BY country_id) AS rno, c.* FROM countries c ;
SELECT ROW_NUMBER() over( ORDER BY NAME ) AS rno, c.* 
FROM countries c ORDER BY country_id ;

select r.name, sum(area)
from countries 
inner join regions r using (region_id)
group by r.name ;

select r.name, sum(AREA) over( PARTITION BY r.name )
from countries 
inner join regions r using (region_id) ;

-- windows function 2
CREATE TABLE sale
( id INT AUTO_INCREMENT PRIMARY KEY ,
  seller_name VARCHAR(255 ), sale_value INT 
) ;

INSERT INTO sale( seller_name, sale_value )
VALUES 
( 'Alice', 12000 ),
( 'Mili', 25000 ),
( 'Stef', 7000 ) ;

SELECT * FROM sale ;
SELECT seller_name, sale_value,
LAG(sale_value) OVER(ORDER BY sale_value) as previous_sale_value
FROM sale ;

SELECT seller_name, sale_value,
LEAD(sale_value) OVER(ORDER BY sale_value) as next_sale_value
FROM sale ;

-- compare annual sale amounts across years.
CREATE TABLE annual_sale
(
	YEAR INT PRIMARY KEY ,
	total_sale int
) ;

INSERT INTO annual_sale
VALUES
( 2015, 23000 ),
( 2016, 25000 ),
( 2017, 34000 ),
( 2018, 32000 ),
( 2019, 33000 ) ; 

SELECT * FROM annual_sale ;

SELECT  year, total_sale as current_total_sale,
   LAG(total_sale) OVER(ORDER BY year) AS previous_total_sale,
   total_sale - LAG(total_sale) OVER(ORDER BY year) AS difference
FROM annual_sale ;

-- employee
CREATE TABLE employee
( employee_id INT , YEAR INT , QUARTER INT , bonus INT ) ;

INSERT INTO employee VALUES
( 1,	2017,	1,	100 ),
( 1,	2017,	2,	250 ),
( 1,	2017,	3,	60 ),
( 1,	2017,	4,	20 ),
( 1,	2018,	1,	80 ),
( 1,	2018,	2,	80 ),
( 1,	2018,	3,	0 ),
( 1,	2018,	4,	0 ),
( 1,	2019,	1,	0 ),
( 1,	2019,	2,	100 ),
( 1,	2019,	3,	0 ),
( 1,	2019,	4,	150 ) ;

SELECT year, quarter,
LAG(bonus,4) OVER(ORDER BY year,quarter) AS previous_bonus,
bonus AS current_bonus,
LEAD(bonus,4) OVER(ORDER BY year,quarter) AS next_bonus 
FROM employee
WHERE employee_id=1 ;

-- product
DROP TABLE product ;

CREATE TABLE sale_product( product_id INT , MONTH INT, COUNT INT ) ;

INSERT INTO sale_product VALUES
( 1,	1,	125 ),
( 1,	2,	135 ),
( 1,	3,	NULL ),
( 1,	4,	90 ) ;

INSERT INTO sale_product VALUES
( 2,	1,	150 ),
( 2,	2,	100 ),
( 2,	3,	185 ),
( 2,	4,	190 ) ;

SELECT product_id, MONTH,
LAG(COUNT, 1) OVER( ORDER BY MONTH ) AS previous_count,
count AS current_count,
count - LAG(count,1) OVER( ORDER BY MONTH ) AS difference
FROM sale_product WHERE product_id = 1 ;

SELECT product_id, month,
  LAG(count,1) OVER(PARTITION BY product_id ORDER BY month) AS previous_count,
  count AS current_count,
  count - LAG(count,1) OVER(PARTITION BY product_id ORDER BY month) AS difference
FROM sale_product ;

-- 과제
DROP TABLE DATA CASCADE ;

CREATE TABLE DATA
(
	WITH recursive num AS (
	    SELECT 1 AS n
	    UNION ALL
	    SELECT n + 1 FROM num WHERE n < 10000 
	)
	SELECT n FROM num 
) ;

ALTER TABLE DATA
ADD COLUMN n2 INT ;

UPDATE DATA SET n2 = n WHERE TRUE ;
UPDATE DATA SET n2 = n2 + 1 WHERE TRUE ;

SELECT * FROM DATA ORDER BY n DESC ;

-- Create Function
DROP FUNCTION if EXISTS CalcValue ;

CREATE FUNCTION CalcValue( starting_value INT )  
RETURNS INT DETERMINISTIC  
BEGIN  
   DECLARE total_value INT ;  
   SET total_value = 0 ;  
   label1: WHILE total_value <= 3000 DO  
     SET total_value = total_value + starting_value ;  
   END WHILE label1 ;  
   RETURN total_value ;  
END ;

SELECT CalcValue( 10 ) FROM DUAL ;

-- my text function
select CONCAT(
substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', rand()*36+1, 1),
substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', rand()*36+1, 1),
substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', rand()*36+1, 1),
substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', rand()*36+1, 1),
substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', rand()*36+1, 1),
substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', rand()*36+1, 1),
substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', rand()*36+1, 1),
substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', rand()*36+1, 1)
) as RANDOM_TEST ;

DROP FUNCTION if EXISTS MY_TEXT ;

CREATE FUNCTION MY_TEXT( n INT )  
RETURNS VARCHAR(200) 
BEGIN

DECLARE t_all VARCHAR(200) ;
DECLARE idx INT ; 
DECLARE c VARCHAR(1) ;
DECLARE alpha VARCHAR( 255 ) ;

SET alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789' ; 

SET idx = 0 ; 
SET t_all = '' ;

WHILE idx < n DO  
   SET c = SUBSTRING( alpha, rand()*LENGTH(alpha)+1, 1) ; 
   SET t_all = CONCAT( t_all, c ) ;
   SET idx = idx + 1 ; 
END WHILE ;  

RETURN t_all ;

END ;

SELECT my_text( 10 ) , my_text( 20 ) FROM DUAL ;

-- random data
SELECT UUID() FROM DUAL ;

SELECT (FLOOR(1 + RAND()*100 )) AS no FROM DUAL ;

SELECT (FLOOR(1 + RAND()*100 )) AS no FROM countries ;

SELECT COUNT(*) FROM countries ; 
SELECT RAND() FROM countries ;

SELECT (NOW() - INTERVAL FLOOR(RAND() * 200) DAY) as randDate FROM DUAL ;

UPDATE DATA SET N2 = 1 WHERE TRUE ;
UPDATE DATA SET N2 = (FLOOR(1 + RAND()*100 )) WHERE TRUE ;

SELECT * FROM DATA ;

-- NVL
SELECT NVL(10, 20) FROM DUAL ;
SELECT NVL(NULL, 20) FROM DUAL ;

-- TRANSACTION
UPDATE DATA SET N2 = 1 WHERE TRUE ;
SELECT * FROM DATA ;

START TRANSACTION ;

UPDATE DATA SET N2 = 3 WHERE TRUE ;
SELECT * FROM DATA ;

ROLLBACK ; -- 취소 

COMMIT ; -- 트랜잭션 완료 


