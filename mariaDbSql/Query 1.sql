SELECT NAME FROM countries ;

SELECT NAME, AREA, national_day FROM countries ;

select country_id, name, area, national_day, country_code2,
    country_code3, region_id
FROM countries ;

SELECT * FROM countries ;

SELECT NOW() ;
SELECT NOW() FROM DUAL ;
SELECT NOW() FROM countries ;
SELECT NOW(), DATE_ADD(NOW() , interval 1 DAY ) FROM DUAL ;

SELECT NAME, area FROM (
  SELECT country_id, NAME, area FROM countries LIMIT 5 
  ) AS a ;

-- order by  
SELECT country_id, NAME, area FROM countries LIMIT 5 ; 

SELECT NAME, area FROM countries ORDER BY NAME ; 
SELECT NAME, area FROM countries ORDER BY NAME ASC ; 
SELECT NAME, area FROM countries ORDER BY 1 ; 
SELECT NAME, area FROM countries ORDER BY 1 ASC ; 
SELECT NAME, area FROM countries ORDER BY NAME DESC ; 

SELECT NAME, national_day FROM countries ORDER BY national_day ASC ;

SELECT NAME, AREA, region_id FROM countries 
WHERE region_id = 2 AND AREA > 200000
ORDER BY NAME ;

SELECT NAME, AREA, region_id FROM countries 
WHERE region_id = 2 OR AREA > 200000
ORDER BY NAME ;

SELECT NAME, country_code2 FROM countries
WHERE country_code2 IN ( 'US', 'FR', 'JP' ) 
ORDER BY NAME ;

SELECT NAME, country_code2 FROM countries
WHERE country_code2 = 'US' OR country_code2 = 'FR'
 OR country_code2 = 'JP' 
ORDER BY NAME ;

SELECT NAME, country_code2 FROM countries
WHERE country_code2 IN ( 'US' ) 
ORDER BY NAME ;

SELECT NAME, country_code2 FROM countries
WHERE country_code2 = 'US'
ORDER BY NAME ;

-- wildcard
SELECT NAME FROM countries WHERE NAME LIKE 'J%' ;
SELECT NAME FROM countries WHERE NAME = 'J%' ; -- 안 먹힘.

SELECT NAME FROM countries WHERE NAME LIKE '_____' ;
SELECT NAME FROM countries WHERE LENGTH( NAME ) = 5 ;

SELECT NAME FROM countries WHERE NAME LIKE '_____%' ;
SELECT NAME FROM countries WHERE LENGTH( NAME ) >= 5 ;

SELECT NAME, LENGTH( NAME ) 
FROM countries WHERE LENGTH( NAME ) >= 5 
ORDER BY 2 ;

SELECT NAME, LENGTH( NAME ) AS name_length 
FROM countries WHERE LENGTH( NAME ) >= 5 
ORDER BY 2 ;

SELECT NAME AS n, LENGTH( NAME ) AS name_length 
FROM countries WHERE LENGTH( NAME ) >= 5 
ORDER BY 2 ;

-- distinct
SELECT year FROM country_stats ORDER BY year ;
SELECT DISTINCT YEAR FROM country_stats ORDER BY YEAR ;
SELECT DISTINCT YEAR, population FROM country_stats ORDER BY YEAR ;
SELECT * FROM country_stats ;

SELECT national_day FROM countries ORDER BY 1 ;
SELECT DISTINCT national_day FROM countries ORDER BY 1 ;

-- between
SELECT NAME, AREA FROM countries 
WHERE AREA BETWEEN 1566500 AND 2780400
ORDER BY AREA ;

SELECT NAME, AREA FROM countries 
WHERE ( AREA BETWEEN 1566500 AND 2780400 ) 
ORDER BY AREA ;

SELECT NAME, AREA FROM countries 
WHERE AREA >= 1566500 AND AREA <= 2780400
ORDER BY AREA ;

SELECT NAME, AREA FROM countries 
WHERE 1566500 <= AREA AND AREA <= 2780400
ORDER BY AREA ;

-- between 2
SELECT NAME, national_day FROM countries
WHERE national_day BETWEEN '1945-08-17' AND '1953-11-09' 
ORDER BY national_day ;

SELECT NAME, national_day FROM countries
WHERE national_day NOT BETWEEN '1945-08-17' AND '1953-11-09' 
ORDER BY national_day ;

-- IN
SELECT NAME, country_code2 FROM countries
WHERE country_code2 IN ( 'US', 'FR', 'JP' ) 
ORDER BY NAME ;

SELECT NAME, country_code2 FROM countries
WHERE country_code2 NOT IN ( 'US', 'FR', 'JP' ) 
ORDER BY NAME ;

-- LIKE
SELECT NAME FROM countries WHERE NAME LIKE '_n%'
ORDER BY NAME ;

SELECT NAME FROM countries WHERE NAME LIKE '%state%'
ORDER BY NAME ;

-- LIMIT
countries
SELECT NAME FROM countries ORDER BY NAME LIMIT 5 ;
SELECT NAME FROM countries LIMIT 5 ORDER BY NAME ; -- 안 됨.

SELECT country_id, NAME FROM countries ORDER BY NAME LIMIT 10  ;
SELECT country_id, NAME FROM countries ORDER BY NAME LIMIT 10 OFFSET 5 ;
SELECT country_id, NAME FROM countries ORDER BY NAME LIMIT 5, 10 ; -- offset, limit
SELECT country_id, NAME FROM countries ORDER BY NAME LIMIT 1 ; -- 한건만 조회

-- NULL
SELECT 0 IS NULL , '' IS NULL , NULL IS NULL FROM DUAL ;
SELECT 0 = NULL , '' = NULL , NULL = NULL FROM DUAL ;

SELECT 0 IS NOT NULL , '' IS NOT NULL , NULL IS NOT NULL FROM DUAL ;

SELECT NAME, national_day FROM countries WHERE national_day IS NULL ;

SELECT NAME, national_day FROM countries WHERE national_day = NULL ;

SELECT NAME, national_day FROM countries WHERE national_day IN ( NULL ) ;

SELECT NAME, national_day FROM countries WHERE national_day IS NOT NULL ;

SELECT NAME, national_day FROM countries WHERE national_day <> NULL ;

SELECT NAME, national_day FROM countries WHERE national_day NOT IN ( NULL ) ;

-- inner join
SELECT * FROM guests ; 
SELECT * FROM vips ;

SELECT g.guest_id, g.name, v.vip_id, v.name
FROM guests g INNER JOIN vips v 
ON v.name = g.name ;

SELECT g.guest_id, g.name, v.vip_id, v.name
FROM guests g INNER JOIN vips v 
ON g.name = v.name ;

SELECT guest_id, g.name AS n , vip_id, v.name n2
FROM guests AS g INNER JOIN vips AS v 
ON g.name = v.name ;

SELECT guest_id, name, vip_id
FROM guests AS g INNER JOIN vips AS v 
ON g.name = v.name ; -- Error

-- inner join
SELECT guest_id, g.name AS guest_name, vip_id, v.name AS vip_name
FROM guests AS g INNER JOIN vips AS v 
ON g.name = v.name ;

SELECT guest_id, g.name AS guest_name, vip_id, v.name AS vip_name
FROM guests AS g JOIN vips AS v 
ON g.name = v.name ;

-- left join
SELECT guest_id, g.name AS guest_name, vip_id, v.name AS vip_name
FROM guests AS g LEFT JOIN vips AS v 
ON g.name = v.name ;


SELECT guest_id, g.name AS guest_name, vip_id, v.name AS vip_name
FROM guests AS g LEFT OUTER JOIN vips AS v 
ON g.name = v.name ;  -- left join 과 동일 

-- right join
select g.guest_id, g.name, v.vip_id, v.name
from guests g right join vips v
on v.name = g.name ;	

select g.guest_id, g.name, v.vip_id, v.name
from vips v left join guests g
on v.name = g.name ;	-- right join 과 동일 

select g.guest_id, g.name, v.vip_id, v.name
from vips v left outer join guests g
on v.name = g.name ;

-- cross join / cross product
SELECT g.guest_id, g.name, v.vip_id, v.name 
FROM guests g CROSS JOIN vips v ;

SELECT g.guest_id, g.name, v.vip_id, v.name 
FROM guests g, vips v ; -- cross join 동일 

SELECT g.guest_id, g.name, v.vip_id, v.name 
FROM guests g, vips v WHERE g.name = v.name ; -- inner join 과 동일 

-- inner join using
select c.name country, r.name region
from countries c inner join regions r 
on r.region_id = c.region_id ;

select c.name country, r.name region
from countries c inner join regions r 
using ( region_id) ;

select c.name country, r.name region, t.name continent
from countries c
inner join regions r using (region_id)
inner join continents t using (continent_id) ;

-- outer join using
select NAME, year, gdp 
from countries c
left join country_stats s ON s.country_id = c.country_id ; 

select NAME, year, gdp 
from countries c
left join country_stats s USING ( country_id );

select c.name country, r.name region, t.name continent
from countries c
left join regions r using (region_id)
left join continents t using (continent_id) ;

-- group by
SELECT region_id , country_id FROM countries ORDER BY 1, 2 ;
SELECT region_id, COUNT( country_id ) FROM countries GROUP BY region_id ORDER BY 1 ; 
SELECT region_id, COUNT( country_id ) FROM countries ORDER BY 1 ; -- 표준 문법에서 벗어남. 

SELECT region_id, COUNT(country_id), country_id FROM countries GROUP BY region_id ORDER BY 1 ; -- 표준 문법에서 어긋남
SELECT region_id, COUNT(country_id), country_id FROM countries GROUP BY region_id, country_id ORDER BY 1 ; -- 표준 문법
SELECT region_id, country_id, COUNT(country_id) FROM countries GROUP BY region_id, country_id ORDER BY 1 ; -- 표준 문법

SELECT COUNT(*) FROM countries ; -- table record counting
SELECT COUNT(country_id) FROM countries ; -- table record counting

select regions.name region, sum(area) region_area
from countries inner join regions using (region_id)
group by regions.name
order BY region_area DESC ;

select regions.name region, sum(area) region_area
from countries inner join regions using (region_id) 
order BY region_area DESC ; -- 표준에서 벗어남.

select regions.name region, min(area) smallest_country_area, max(area) largest_country_area
from countries inner join regions using (region_id)
group by regions.name order by regions.name;
   
-- having
select regions.name region, count(country_id) country_count
from countries inner join regions using (region_id)
group by regions.name
having count(region_id) > 10
order by country_count DESC ;

select regions.name region, count(country_id) country_count
from countries inner join regions using (region_id)
group by regions.name 
order by country_count DESC ;

select regions.name region, count(country_id) country_count
from countries inner join regions using (region_id)
group by regions.name 
WHERE country_count > 10 
order by country_count DESC ; -- 잘못됨.

SELECT * FROM ( 
	select regions.name region, count(country_id) country_count
	from countries inner join regions using (region_id)
	group by regions.name 
) AS a 
WHERE country_count > 10 
order by country_count DESC ; 

select regions.name region, count(country_id) country_count, sum(area) area
from countries inner join regions using (region_id)
group BY regions.name
HAVING count(region_id) > 10 and area > 1000000
order by area desc, country_count DESC ;

-- subquery

select country_id, area from countries where area > 5000000 ;

select country_id, name, AREA from countries where country_id in (12,15,31,38,42,182,224) ; 

select country_id, name, AREA from countries 
where country_id IN ( select country_id from countries where area > 5000000 ) ; 

select country_id, name, AREA from countries where area > 5000000 ; 

select country_id, name, AREA from countries 
where country_id IN ( select country_id, name from countries where area > 5000000 ) ; -- ERROR

-- subquery normalization
select country_id, name, AREA from countries 
where country_id IN ( select country_id from countries where area > 5000000 ) ; 

SELECT c1.country_id, NAME, c1.AREA 
from countries c1 
LEFT JOIN ( select country_id, area from countries where area > 5000000 ) c2 
USING( country_id )
WHERE c1.area = c2.area ;

-- subquery 3
select max(AREA) from countries ; 

SELECT * from countries where area = ( select max(area) from countries ) ;

SELECT * FROM 
countries 
INNER join ( select max(AREA) AS area from countries ) max_c
USING( AREA ) ;

-- bad subquey example

SELECT c.* from countries AS c ; 

SELECT c.*, ( select max(AREA) from countries ) AS max_area 
from countries AS c ; -- 권장되지 않음.

-- subquery 4
select avg(population), avg(gdp) from country_stats where year = 2018 ;

select NAME from country_stats
inner join countries using (country_id)
where year = 2018 
AND (population, gdp) > ( select avg(population), avg(gdp) from country_stats where year = 2018)
order by NAME ;

-- subquery 5
select avg(region_area)
from (
    select sum(area) region_area
    from countries
    group by region_id
) t ;

SELECT AVG( area ) FROM countries ;
--