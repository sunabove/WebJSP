WITH recursive num AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM num WHERE n < 10 
)
SELECT n FROM num ;

DROP TABLE if EXISTS t  ;

CREATE TABLE t 
(
	WITH recursive num AS (
	    SELECT 1 AS n
	    UNION ALL
	    SELECT n + 1 FROM num WHERE n < 10 
	)
	SELECT n FROM num 
) ;

SELECT * FROM t ;

DESCRIBE t ; 