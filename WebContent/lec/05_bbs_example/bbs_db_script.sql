-- Hello

-- drop tables 
DROP TABLE if EXISTS db_file_log ;
DROP TABLE if EXISTS db_file ;
DROP TABLE if EXISTS article_reply ;
DROP TABLE if EXISTS article ;
DROP TABLE if EXISTS board ;

DROP TABLE if EXISTS user_access_log ;
DROP TABLE if EXISTS USER ;
DROP TABLE if EXISTS CODE ;
DROP TABLE if EXISTS SYS_PROP ;

-- sys prop

CREATE TABLE SYS_PROP (
   prop_key  VARCHAR(255) ,
   VALUE     VARCHAR(255) ,
	value_int INT ,
	value_dbl DOUBLE ,
	PRIMARY KEY ( prop_KEY, VALUE )  
) ;

-- code

CREATE TABLE CODE ( 
	p_code_id   VARCHAR(255) ,
	code_id     VARCHAR(255) PRIMARY key ,
	text_value  VARCHAR(255),
	num_value   DOUBLE,
	ord INT 
) ;

-- user

CREATE TABLE USER (
	user_id        INT PRIMARY KEY AUTO_INCREMENT ,
	user_name      VARCHAR(255) NOT NULL,
	email          VARCHAR(255) NOT NULL ,
	passwd         VARCHAR(255) ,
	phone_no       VARCHAR(255) ,
	last_login_dt  TIMESTAMP  ,
	last_logout_dt TIMESTAMP ,
	role_code_id   VARCHAR(255) NOT NULL DEFAULT 1
) ; 

-- insert user
INSERT INTO user( user_name, email , passwd ) VALUES
( 'admin', 'admin@gmail.com', 'admin' ) ,
( 'john', 'john@gmail.com', 'admin' ) ;

-- SELECT * FROM user ;

-- user access log

CREATE TABLE user_access_log (
	user_access_log_id INT PRIMARY KEY AUTO_INCREMENT ,
	user_id            INT REFERENCES USER(user_id) ,
	login_dt           TIMESTAMP ,
	logout_dt          TIMESTAMP  
) ; 

-- board

CREATE TABLE board(
	board_id INT PRIMARY KEY AUTO_INCREMENT ,
	board_user_id INT REFERENCES user( user_id ),
	board_name VARCHAR( 255 ) UNIQUE ,
	up_dt TIMESTAMP ,
	deleted INT NOT NULL DEFAULT 0	
) ;

-- insert board
INSERT INTO board ( board_name, board_user_id )
VALUES( 'Notice' , 1 ), ( 'Free' , 2 ) ;

SELECT * FROM board ;

-- article
CREATE TABLE article (
	board_id INT REFERENCES board( board_id ) , 
	article_id INT PRIMARY KEY AUTO_INCREMENT ,
	article_user_id INT REFERENCES user( user_id ) , 
	is_notice INT NOT NULL DEFAULT 0 ,
	title VARCHAR(255) ,
	content text ,
	content_type VARCHAR(255) NOT NULL DEFAULT 'txt',
	view_count INT NOT NULL DEFAULT 0,
	up_dt TIMESTAMP ,
	deleted INT NOT NULL DEFAULT 0
) ;

-- insert sample article data

INSERT INTO article( board_id , article_user_id, is_notice, title, content ) VALUES
( 1, 1, 1, 'abcd', 'abcd efg' ) ,
( 1, 2, 1, 'abcd def', 'abcd efg gjgi' ) ,
( 1, 2, 0, 'abcd asdf', 'sd absd cd efg' ) , 
( 1, 1, 0, 'abcd asdf asdf', 'sd abcd efg' ) , 

( 1, 2, 0, 'abcd as sdfdf', 'sd abcd efg' ) , 
( 1, 1, 0, 'ab asdf cd asdf', 'ssd d abcd efg' ) , 
( 1, 2, 0, 'adsf abc adsfd asdf', 'sd abcsdfd efsdf g' ) , 
( 1, 1, 0, 'wecf abcd asdf', 'sd absdf cd efg' ) , 
( 1, 1, 0, 'qer abcd asdf asdf', 'sd abcd efg' ) , 

( 1, 2, 0, 'gwerf abcd as sdfdf', 'sd abcd efg' ) , 
( 1, 1, 0, 'sd jytt ab asdf cd asdf', 'ssd d abcd efg' ) , 
( 1, 2, 0, 'ldfgxc adsf abc adsfd asdf', 'sd abcsdfd efsdf g' ) , 
( 1, 1, 0, 'wexdf sdfsd cf abcd asdf', 'sd absdf cd efg' ) , 
( 1, 2, 0, 'abcd asdf', 'sd absd cd efg' ) , 

( 1, 1, 0, 'abcd asdf asdf', 'sd abcd efg' ) , 
( 1, 2, 0, 'abcd as sdfdf', 'sd abcd efg' ) , 
( 1, 1, 0, 'ab asdf cd asdf', 'ssd d abcd efg' ) , 
( 1, 2, 0, 'adsf abc adsfd asdf', 'sd abcsdfd efsdf g' ) , 
( 1, 1, 0, 'wecf abcd asdf', 'sd absdf cd efg' ) , 

( 1, 1, 0, 'qer abcd asdf asdf', 'sd abcd efg' ) , 
( 1, 2, 0, 'gwerf abcd as sdfdf', 'sd abcd efg' ) , 
( 1, 1, 0, 'sd jytt ab asdf cd asdf', 'ssd d abcd efg' ) , 
( 1, 2, 0, 'ldfgxc adsf abc adsfd asdf', 'sd abcsdfd efsdf g' ) , 
( 1, 1, 0, 'wexdf sdfsd cf abcd asdf', 'sd absdf cd efg' ) , 

( 1, 2, 0, 'gwerf abcd as sdfdf', 'sd abcd efg' ) , 
( 1, 1, 0, 'sd jytt ab asdf cd asdf', 'ssd d abcd efg' ) , 
( 1, 2, 0, 'ldfgxc adsf abc adsfd asdf', 'sd abcsdfd efsdf g' ) , 
( 1, 1, 0, 'wexdf sdfsd cf abcd asdf', 'sd absdf cd efg' ) , 
( 1, 2, 0, 'abcd asdf', 'sd absd cd efg' ) , 

( 1, 1, 0, 'abcd asdf asdf', 'sd abcd efg' ) , 
( 1, 2, 0, 'abcd as sdfdf', 'sd abcd efg' ) , 
( 1, 1, 0, 'ab asdf cd asdf', 'ssd d abcd efg' ) , 
( 1, 2, 0, 'adsf abc adsfd asdf', 'sd abcsdfd efsdf g' ) , 
( 1, 1, 0, 'wecf abcd asdf', 'sd absdf cd efg' ) , 

( 1, 1, 0, 'qer abcd asdf asdf', 'sd abcd efg' ) , 
( 1, 2, 0, 'gwerf abcd as sdfdf', 'sd abcd efg' ) , 
( 1, 1, 0, 'sd jytt ab asdf cd asdf', 'ssd d abcd efg' ) , 
( 1, 2, 0, 'ldfgxc adsf abc adsfd asdf', 'sd abcsdfd efsdf g' ) , 
( 1, 1, 0, 'wexdf sdfsd cf abcd asdf', 'sd absdf cd efg' ) , 

( 2, 1, 1, 'abcd', 'abcd efg' ) ,
( 2, 2, 1, 'abcd def', 'abcd efg gjgi' ) ,
( 2, 1, 0, 'abcd asdf', 'sd absd cd efg' ) , 
( 2, 2, 0, 'abcd asdf asdf', 'sd abcd efg' ) , 

( 2, 1, 0, 'abcd as sdfdf', 'sd abcd efg' ) , 
( 2, 2, 0, 'ab asdf cd asdf', 'ssd d abcd efg' ) , 
( 2, 1, 0, 'adsf abc adsfd asdf', 'sd abcsdfd efsdf g' ) , 
( 2, 2, 0, 'wecf abcd asdf', 'sd absdf cd efg' ) ,
( 2, 2, 0, 'wecf abcd asdf', 'sd absdf cd efg' ) ,

( 2, 2, 0, 'wecf abcd asdf', 'sd absdf cd efg' ) ,
( 2, 2, 0, 'wertwer ab asdf cd asdf', 'ssd d abcd efg' ) , 
( 2, 1, 0, 'ffff adsf abc adsfd asdf', 'sd abcsdfd efsdf g' ) , 
( 2, 2, 0, 'jlkjl joij wecf abcd asdf', 'sd absdf cd efg' ) ,

( 2, 2, 0, 'pqwf wecf abcd asdf', 'sd absdf cd efg' ) ,
( 2, 2, 0, 'fwerr3e wecf abcd asdf', 'sd absdf cd efg' ) ,
( 2, 2, 0, 'wecf abcd asdf', 'sd absdf cd efg' ) , 
( 2, 2, 0, 'wecf abcd asdf', 'sd absdf cd efg' ) ,
( 2, 2, 0, 'wertwer ab asdf cd asdf', 'ssd d abcd efg' ) ,

( 2, 1, 0, 'abcd as sdfdf', 'sd abcd efg' ) , 
( 2, 2, 0, 'ab asdf cd asdf', 'ssd d abcd efg' ) , 
( 2, 1, 0, 'adsf abc adsfd asdf', 'sd abcsdfd efsdf g' ) , 
( 2, 2, 0, 'wecf abcd asdf', 'sd absdf cd efg' ) ,
( 2, 2, 0, 'wecf abcd asdf', 'sd absdf cd efg' ) ,

( 2, 2, 0, 'wecf abcd asdf', 'sd absdf cd efg' ) ,
( 2, 2, 0, 'wertwer ab asdf cd asdf', 'ssd d abcd efg' ) , 
( 2, 1, 0, 'ffff adsf abc adsfd asdf', 'sd abcsdfd efsdf g' ) , 
( 2, 2, 0, 'jlkjl joij wecf abcd asdf', 'sd absdf cd efg' ) ,
( 2, 2, 0, 'pqwf wecf abcd asdf', 'sd absdf cd efg' ) ,

( 2, 2, 0, 'fwerr3e wecf abcd asdf', 'sd absdf cd efg' ) ,
( 2, 2, 0, 'wecf abcd asdf', 'sd absdf cd efg' ) ,
( 2, 2, 0, 'wecf abcd asdf', 'sd absdf cd efg' ) ,
( 2, 2, 0, 'wertwer ab asdf cd asdf', 'ssd d abcd efg' )

;

SELECT * FROM article ;

SELECT b.board_id, article_id, article_user_id, board_name, user_name, 
title, content, view_count, a.up_dt
FROM  
( SELECT NVL( NULL, 1 ) board_id ) AS p
LEFT JOIN board b ON ( p.board_id = b.board_id )
LEFT JOIN article a ON ( b.board_id = a.board_id ) 
LEFT JOIN user u ON( a.article_user_id = u.user_id )
;  

-- Lee Dong Su Code

-- article_replay

CREATE TABLE ARTICLE_REPLY (
	ARTICLE_ID		INT	REFERENCES ARTICLE( article_id ),
	REPLY_USER_ID 	INT REFERENCES user ( user_id ),
	REPLY_ID 		INT PRIMARY KEY AUTO_INCREMENT ,
	CONTENT 			VARCHAR(255) NOT NULL  ,
	UP_DT				TIMESTAMP DEFAULT NOW()
) ;

-- db_file

CREATE TABLE DB_FILE (
	FILE_ID		INT PRIMARY KEY AUTO_INCREMENT ,
	GUBUN_CODE	VARCHAR(255),
	FILE_NO		INT ,
	FILE_NAME 	VARCHAR(255),
	FILE_PATH 	VARCHAR(255),
	CONTENT 	   BLOB ,
	UP_USER_ID 	INT REFERENCES user ( user_id ) ,
	UP_DT 		TIMESTAMP ,
	DELETED 	   INT NOT NULL DEFAULT 0
) ;

-- db_file_log
CREATE TABLE DB_FILE_LOG(
	FILE_LOG_ID	INT PRIMARY KEY,
	FILE_ID		INT REFERENCES DB_FILE ( FILE_ID ),
	USER_ID		INT REFERENCES user ( user_id ),
	FILE_SIZE 	INT NOT NULL default 0 ,
	IP_ADDR 		VARCHAR(255) ,
	DNLD_RESULT INT NOT NULL DEFAULT 0
);

-- Good bye!
