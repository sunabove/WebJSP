drop table employee ;

CREATE TABLE employee (
  id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY ,
  first_name VARCHAR2(200) ,
  last_name VARCHAR2(200) ,
  email VARCHAR2(200) ,
  age INT ,
  phone_no VARCHAR2(200)
) ;

drop table my_user ;
CREATE TABLE my_user (
  id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY ,
  name VARCHAR2(200) NOT NULL ,
  passwd VARCHAR2(200),
  phone_no VARCHAR2(200)
) ;

select * from employee ;
select * from my_user ;