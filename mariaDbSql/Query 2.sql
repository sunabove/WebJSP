-- cte
with largest_economies as (
    select country_id, gdp 
    FROM country_stats
    WHERE year = 2018
    order by gdp desc
	 limit 10
)
SELECT name, gdp
from countries 
inner join largest_economies using (country_id) ;

-- withoud cte
SELECT name, gdp
from countries 
inner JOIN ( 
	select country_id, gdp 
    FROM country_stats
    WHERE year = 2018
    order by gdp desc
	 limit 10
) as largest_economies using (country_id) ;

select name, gdp
from ( 
    select country_id, gdp 
    from country_stats
    where year = 2018
    order by gdp desc limit 10
) t 
inner join countries using (country_id) ;

-- union
select vip_id as name, 'vip' as TYPE from vips   
union       
select guest_id as NAME, 'guest' AS type from guests ;

select vip_id , 'vip' from vips   
union       
select guest_id , 1 from guests ;

select guest_id , 1 from guests 
union
select vip_id , 2 from vips ;

select vip_id , 'vip' from vips   
union       
select guest_id , 1 , 2 from guests ; -- Error

select name from guests
union
select name from vips ;

select name from guests
union distinct
select name from vips ; 

select name from guests
union all
select name from vips ;

-- intersect
select name from guests
intersect 
select name from vips
;

( select name from guests )
intersect 
( select name from vips )
;

-- except
select name from guests
except
select name from vips ;

-- insert
create table contacts(
    id int auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    full_name varchar(101) as (concat(first_name, ' ', last_name)) virtual,
    phone varchar(100),
    contact_group varchar(50) default 'General',
    primary key(id)
) ;

DROP TABLE contacts ;

create table if not exists contacts(
    id int auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    full_name varchar(101) 
        as (concat(first_name, ' ', last_name)) virtual,
    phone varchar(100),
    contact_group varchar(50) default 'General',
    primary key(id)
) ;

insert into contacts(first_name, last_name, phone)
values('John','Doe','(408)-934-2443') ;

insert into contacts(first_name, last_name, phone, contact_group)
values('Jane','Doe','(408)-456-8934','Leads') ;

insert into contacts(first_name, last_name, phone, contact_group)
values('Roberto','carlos','(408)-242-3845',DEFAULT);

insert into contacts(first_name, last_name, phone )
values('Roberto','carlos','(408)-242-3845');

insert into contacts
set first_name = 'Jonathan', last_name = 'Van' ; -- 표준 문법은 아님.

select LAST_INSERT_ID() ;

SELECT * FROM contacts WHERE id = LAST_INSERT_ID() ;

-- insert multiple rows
insert into contacts(first_name, last_name, phone, contact_group)
values
('James','Smith','(408)-232-2352','Customers'),
('Michael','Smith','(408)-232-6343','Customers'),
('Maria','Garcia','(408)-232-3434','Customers') ;

SELECT * FROM contacts ;
SELECT * FROM contacts WHERE id >= LAST_INSERT_ID() ;

-- Insert Into Select
create table small_countries(
    country_id int primary key,
    name varchar(50) not null,
    area decimal(10,2) not NULL 
) ;

insert into small_countries (country_id,name,AREA)
select country_id, name, area from countries
where area < 50000 ;

SELECT * FROM small_countries ;

-- insert into select 2
DROP TABLE region_areas ;

create table region_areas(
    region_name varchar(100) not null,
    region_area decimal(15,2) not null,
    primary key(region_name)
) ;

insert into region_areas(region_name, region_area)
select regions.name, sum(area)
from countries inner join regions using (region_id)
group by regions.name ;

SELECT * FROM region_areas ORDER BY 2 ;

-- update

SELECT * FROM contacts ;

SELECT * FROM contacts WHERE id = 1 ;

update contacts
set last_name = 'Smith'
where id = 1 ;

update  contacts
set phone = REPLACE( phone,'(408)','(510)' )
where contact_group = 'Customers' ;

update contacts 
set phone = replace(phone,'-',' ') ;

update contacts 
set phone = replace(phone,' ','-') ;

update contacts 
set phone = replace(phone,'-',' ')
WHERE id = ( SELECT MAX(id) FROM contacts ) ;

-- delete
delete from contacts
where id = 1 ;

delete from contacts
where last_name = 'Smith' ;

delete from contacts WHERE TRUE ; -- warning 이 나오지 않음.

delete from contacts WHERE 1 = 1 ;  -- warning 이 나오지 않음.

SELECT * FROM contacts ;

-- create database
create database crm ;
alter database crm character set = 'latin1' collate = 'latin1_swedish_ci' ;

-- show database
show databases 
where `database` not in 
('information_schema',
'mysql',
'performance_schema');

-- create table
DROP TABLE projects ;

create table projects(
    project_id int auto_increment,
    project_name varchar(255) not null,
    begin_date date,
    end_date date,
    cost decimal(15,2) not null,
    created_at timestamp default CURRENT_TIMESTAMP ,
    
    primary key(project_id)
) ;

create table projects(
    project_id int auto_increment,
    project_name varchar(255) not null,
    begin_date date,
    end_date date,
    cost decimal(15,2) not null,
    created_at timestamp default CURRENT_TIMESTAMP ,
    
    primary key(project_id, project_name )
) ; -- 흔하지 않는 경우 

create table projects(
    project_id int primary key auto_increment,
    project_name varchar(255) not NULL,
    begin_date date,
    end_date date,
    cost decimal(15,2) not null,
    created_at timestamp default current_timestamp 
) ;

INSERT INTO projects( project_id ) VALUES ( 1 ) ; -- 에러 발생
INSERT INTO projects( project_name, cost ) VALUES ( 'abc', 10.2 ) ; 

create table projects(
    project_id int primary key auto_increment,
    project_name varchar(255) NOT NULL DEFAULT 'my_project' ,
    begin_date DATE ,
    end_date DATE ,
    cost decimal(15,2) NOT NULL DEFAULT '12.34' ,
    created_at timestamp DEFAULT current_timestamp 
) ;

INSERT INTO projects( project_id ) VALUES ( 1 ) ;
SELECT * FROM projects ;

-- create table 2

DROP TABLE milestones ;

create table milestones(
    milestone_id int AUTO_INCREMENT ,    
	 project_id INT ,
    
	 milestone varchar(255) NOT NULL ,
    start_date date NOT NULL ,
    end_date date NOT NULL ,
    completed bool DEFAULT FALSE ,
    
	 primary key(milestone_id, project_id),    
	 foreign key(project_id) references projects(project_id)
) ; 

create table milestones(
    milestone_id int AUTO_INCREMENT ,    
	 project_id INT REFERENCES projects(project_id),
    
	 milestone varchar(255) NOT NULL ,
    start_date date NOT NULL ,
    end_date date NOT NULL ,
    completed bool DEFAULT FALSE ,
    
	 primary key(milestone_id, project_id) 
) ; 

INSERT INTO milestones( project_id , milestone, start_date, end_date) 
VALUES( 1, 'my_milestone', current_date(), CURRENT_DATE() );

INSERT INTO milestones( project_id , milestone, start_date, end_date) 
VALUES( 2, 'my_milestone', current_date(), CURRENT_DATE() ); -- ERROR

INSERT INTO projects( project_id ) VALUES ( 2 ) ;

INSERT INTO milestones( project_id , milestone, start_date, end_date) 
VALUES( 2, 'my_milestone', current_date(), CURRENT_DATE() ) ; 

SELECT * FROM milestones ;

SELECT * FROM projects ;

-- storage engine
show ENGINES ;

-- alter table
DROP TABLE customers ;

create table customers(
    id int PRIMARY KEY AUTO_INCREMENT ,
    
	 name varchar(255) not null,
    created_at timestamp default current_timestamp,
    is_active bool not null default false 
) ;

alter table customers
add email varchar(255) NOT NULL ;

alter table customers
add phone varchar(15),
add address varchar(255) ;

alter table customers 
modify phone varchar(20) not NULL ;

alter table customers 
modify email varchar(255),
modify address varchar(255) after NAME ;

alter table customers
change column address office_address varchar(255) not NULL ;

alter table customers
drop column office_address ;

describe customers ;

alter table customers 
rename to clients ; 

describe clients ;

-- drop table
DROP TABLE a ;
CREATE TABLE a( a INT ) ;
DESCRIBE a ;

-- show tables
SHOW TABLES  ;
show full TABLES ;
show full TABLES like 'country%' ;

show full TABLES where table_type = 'base table' ;
show full TABLES where table_type = 'view' ;

-- truncate table
DROP TABLE items ;
create table items (
    id int primary key auto_increment ,
    name varchar(255) not null
) ;

DROP PROCEDURE load_items ;

delimiter $$

create procedure load_items(in row_count int)
begin
    declare counter int default 0;
    declare str varchar(255) default '';

    while counter < row_count do
       set str = concat('Item #',counter);
       set counter = counter + 1;

       insert into items(name)
       values(str);
    end while;
END$$

delimiter ;

call load_items(1000) ;

SELECT * FROM items ;

TRUNCATE TABLE items ; -- delete 보다 효과적으로 모든 레코드 삭제 
TRUNCATE TABLE items WHERE 1 = 1  ;  -- ERROR

-- primary key
create table if not exists products(
    product_code varchar(18) primary key,
    product_name varchar(50) not null
) ;
 
insert into products(product_code, product_name)
values('xg-2019','xgadget of 2019') ;

SELECT * FROM products ;

insert into products(product_code, product_name)
values('xg-2019','xgadget of 2019-q2') ; -- ERROR

show indexes from products ; -- index 조회 

create table categories(
    category_id int AUTO_INCREMENT PRIMARY KEY ,
    name varchar(50) not null 
) ;

insert into categories(name)
VALUES ('Gadgets'), ('Accessories') ;

create table product_categories(
    product_code varchar(18),
    category_id int,
    primary key(product_code, category_id)
) ;

-- foreign key

create table gadget_types(
    type_id int AUTO_INCREMENT PRIMARY KEY ,
    name varchar(100) NOT NULL  
) ;

insert into gadget_types(name)
VALUES
('Entertainment'),
('Computing'),
('Communication'),
('Lifestyle'),
('Cameras') ;

SELECT * FROM gadget_types ;

DROP TABLE gadgets ;

create table gadgets(
	 gadget_id int AUTO_INCREMENT PRIMARY KEY ,
	 gadget_name varchar(100) not null,
	 type_id int,
	 constraint my_fk_type
	 foreign key(type_id) references gadget_types(type_id)
) ;

create table gadgets(
	 gadget_id int AUTO_INCREMENT PRIMARY KEY ,
	 gadget_name varchar(100) not NULL ,
	 type_id INT , 
	 foreign key(type_id) references gadget_types(type_id)
) ;

insert into gadgets(gadget_name,type_id)
VALUES
('Amazon Kindle',1),
('Apple iPod',1),
('Audio Highway Listen Up',1),
('Apple iPad',2),
('MicroSD',2),
('Apple iPhone',3),
('BlackBerry 6210',3),
('Pager',3),
('Air Taser Model 34000',4),
('Credit Card',4),
('Zippo',4),
('Casio G-Shock DW-5000C',4),
('Nikon F',5),
('Canon EOS 5D Mark II',5) ;

delete from gadget_types where type_id = 1 ; -- ERROR

alter table gadgets drop constraint my_fk_type ;

alter table gadgets add constraint fk_type 
foreign key(type_id) references gadget_types(type_id)
on delete set NULL 
on update set NULL ;

delete from gadget_types where type_id = 1 ;

update gadget_types set type_id = 20 where type_id = 2 ;

delete from gadgets where type_id is NULL ;

alter table gadgets drop constraint fk_type ;

alter table gadgets add constraint fk_type 
foreign key(type_id) references gadget_types(type_id)
on delete CASCADE  
on update CASCADE ;

delete from gadget_types where type_id = 3 ;

update gadget_types set type_id = 40 where type_id = 4 ;

SELECT * FROM gadget_types ;
SELECT * FROM gadgets ;
SELECT * FROM gadgets WHERE type_id = 1 ;

-- check constraint
DROP TABLE classes ;

create table classes(
    class_id int AUTO_INCREMENT PRIMARY KEY ,
    class_name varchar(255) not null,
    student_count INT CHECK( student_count > 0 ) 
) ;

insert into classes(class_name, student_count)
values('MariaDB for Developers',0) ; -- ERROR

insert into classes(class_name, student_count)
values('MariaDB for Developers', 1 );

insert into classes(class_name, student_count)
values('MariaDB for Developers',100) ;

drop table classes ;

create table classes(
    class_id int AUTO_INCREMENT PRIMARY KEY ,
    class_name varchar(100) not null,
    begin_date date not null,
    end_date date not null,
    student_count int,
    
    constraint positive_student_count 
        check(student_count > 0),
    constraint valid_date
        check(end_date >= begin_date) 
) ;

alter table classes
add constraint valid_begin_date 
check(begin_date >= '2019-01-01') ;

insert into classes(class_name, student_count, begin_date, end_date )
values('MariaDB for Developers', 1, '2018-01-01', '2020-01-01' ) ; -- ERROR

insert into classes(class_name, student_count, begin_date, end_date )
values('MariaDB for Developers', 1, '2021-01-02', '2019-02-01' ) ; -- ERROR

insert into classes(class_name, student_count, begin_date, end_date )
values('MariaDB for Developers', 1, '2019-01-02', '2020-02-01' ) ;

SELECT * FROM classes ;

-- unique constraint

DROP TABLE locations ;

create table locations(
    location_id int AUTO_INCREMENT PRIMARY KEY ,
    name varchar(255),
    phone VARCHAR(255) not null UNIQUE ,
    
    latitude dec(9,6) not NULL ,
    longitude dec(9,6) not NULL ,
    
    UNIQUE( latitude, longitude ) 
) ;

insert into locations(name, phone) values('The White House','202-456-1111') ;
insert into locations(name, phone) values('1600 Pennsylvania Avenue NW','202-456-1111') ; -- ERROR

insert into locations(name, phone, latitude, longitude)
values('Eiffel Tower','+33 892 70 12 39', 48.858093, 2.294694) ;

insert into locations(name, phone, latitude, longitude)
values('Unknown Lake','+33 892 70 30 30',48.858093, 2.594694) ;

insert into locations(name, phone, latitude, longitude)
values('The New Eiffel Tower','+33 892 70 12 39', 48.858093, 2.294694) ; -- ERROR

SELECT * FROM locations ; 

-- Not Null

create table courses(
    course_id int AUTO_INCREMENT PRIMARY KEY ,
    course_name varchar(100) NOT NULL ,
    summary varchar(255)  
) ;

insert into courses(course_name) VALUES( NULL ) ; -- ERROR

insert into courses(course_name) VALUES( 'my course' ) ;

update courses set summary = 'N/A' where summary is NULL ;

alter table courses modify summary varchar(255) not NULL ;

insert into courses(course_name) VALUES( 'my course 2' ) ; -- ERROR

alter table courses modify summary varchar(255) ;

insert into courses(course_name) VALUES( 'my course 2' ) ;

DESCRIBE courses ;

show create table courses ;

SELECT * FROM courses ;

-- view

DROP TABLE country_details ; -- ERROR
DROP VIEW country_details_view ; 

CREATE OR REPLACE VIEW country_details_view AS 
select c.name country, r.name region, t.name continent, area
from countries c
inner join regions r using (region_id)
inner join continents t using (continent_id)
WHERE 1 = 1 
order by country ; 

select * from country_details_view ;

select c.name country, r.name region, t.name continent, area
from countries c
inner join regions r using (region_id)
inner join continents t using (continent_id)
order by country  ; 

-- create view 2

create or replace view country_info ( country, region, continent, AREA ) 
AS select countries.name , regions.name , continents.name , area
from countries
inner join regions using (region_id)
inner join continents using (continent_id) ;

create or replace view country_info AS 
select countries.name AS country , regions.name AS region , continents.name AS continent , area
from countries
inner join regions using (region_id)
inner join continents using (continent_id) ;

SELECT * FROM country_info ;

-- create view 3

create view continent_areas AS
select continent, sum(area) total_area
from country_info
group BY continent ;

SELECT * FROM continent_areas ;

-- create view 4
create or replace view areas as
select continents.name continent, regions.name region, sum(area) total_area
from countries
inner join regions using (region_id)
inner join continents using (continent_id)
group by region, continent ;  

SELECT * FROM areas ;

-- trigger
create table country_reports select * from country_stats ;

SELECT * FROM country_reports ;
DESCRIBE country_reports  ;

CREATE TABLE backup_country_stats select * from country_stats ;
SELECT * FROM backup_country_stats ;

create table population_logs(
    log_id int AUTO_INCREMENT PRIMARY KEY ,
    country_id int not null,
    year int not null,
    old_population int not null,
    new_population int not null,
    updated_at timestamp default current_timestamp 
) ;

-- create trigger
create or replace trigger before_country_reports_update 
before update on country_reports
for each row
insert into population_logs( country_id, year, old_population, new_population )
values( old.country_id, old.year, old.population, new.population ) ;

select * from country_reports
where country_id = 100 and year = 2018 ;

select * from population_logs ;

update country_reports
set population = 1352617399
WHERE country_id = 100 and year = 2018 ;

-- index
SELECT * from countries where name = 'France' ; 

EXPLAIN select * from countries where name = 'France' ; -- 실행 계획 

create index country_name on countries( NAME ) ; -- 인덱스 생성

EXPLAIN select * from countries where name = 'France' ; -- 실행 계획 

DROP INDEX country_name ON countries ; -- 인덱스 삭제 

EXPLAIN select * from countries where name = 'France' ; -- 실행 계획 

-- index test
WITH recursive num AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM num WHERE n < 10 
)
SELECT n FROM num ;

DROP TABLE if EXISTS t ;

CREATE TABLE t 
(
	WITH recursive num AS (
	    SELECT 1 AS n
	    UNION ALL
	    SELECT n + 1 FROM num WHERE n < 1000000 
	)
	SELECT n FROM num 
) ;

SELECT * FROM t ;
SELECT COUNT(*) FROM t ;

SELECT * FROM t WHERE n = 1 ;

describe SELECT * FROM t WHERE n = 1 ;

DROP INDEX if EXISTS t_n ON t ;

CREATE INDEX t_n ON t(n) ; -- index 생성 

SELECT * FROM t WHERE n = 1 ;

describe SELECT * FROM t WHERE n = 1 ;

DESCRIBE t ; 

