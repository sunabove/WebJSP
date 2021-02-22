-- Hello

DROP TABLE if exists cricketer ;

CREATE TABLE if not exists cricketer (
   First_Name VARCHAR(255),
   Last_Name VARCHAR(255),
   Date_Of_Birth date,
   Place_Of_Birth VARCHAR(255),
   Country VARCHAR(255)
);

insert into cricketer values('Shikhar', 'Dhawan', DATE('1981-12-05'), 'Delhi', 'India');
insert into cricketer values('Jonathan', 'Trott', DATE('1981-04-22'), 'CapeTown', 'SouthAfrica');
insert into cricketer values('Kumara', 'Sangakkara', DATE('1977-10-27'), 'Matale', 'Srilanka');
insert into cricketer values('Virat', 'Kohli', DATE('1988-11-05'), 'Delhi', 'India');
insert into cricketer values('Rohit', 'Sharma', DATE('1987-04-30'), 'Nagpur', 'India');

select * from cricketer;

-- Good bye!
