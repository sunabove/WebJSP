drop table prac1;
drop table prac2; 
create table prac1( c1 INT) ;
create table prac2( c1 INT) ;

DELIMITER $$

DROP PROCEDURE IF EXISTS loopInsert$$ 

CREATE PROCEDURE loopInsert()
BEGIN

	DECLARE i INT DEFAULT 1;
	WHILE i <= 10000 DO 
		INSERT INTO prac1 (c1) VALUES (i);
		SET i = i + 1;
	END WHILE;
END$$

DELIMITER $$ ;

CALL loopInsert() ;

select * from prac1 ;

insert into prac2(c1) select c1 + 1 from prac1 ;
select * from prac2 ;