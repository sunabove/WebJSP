<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "org.mariadb.jdbc.Driver" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<!DOCTYPE html>
<html>
   <head>
   		<meta charset="UTF-8" />
      	<title>EMPLOYEE TABLE</title>
   </head>

   <body>
   	  <!-- create db connection -->
      <sql:setDataSource var="myDb" driver = "org.mariadb.jdbc.Driver"
         url = "jdbc:mariadb://localhost:3306/MY_SCHEMA"
         user = "MY_USER"  password = "admin"/>
         
      <!-- drop table -->
      <sql:update dataSource="${myDb}" var="upNo">
      		DROP TABLE if exists EMPLOYEE
      </sql:update>
      
      <c:if test="${ upNo eq 0 }" >
      	<h3> Table is dropped. </h3>
      </c:if>
      <c:if test="${ upNo eq 1 }" >
      	<h3> Table is not dropped. </h3>
      </c:if>
      
      <!-- create table -->
      <sql:update dataSource="${myDb}" var="upNo">
      		CREATE TABLE employee ( 
			  id INT PRIMARY KEY AUTO_INCREMENT ,
			  first_name VARCHAR(200) NOT NULL ,
			  last_name VARCHAR(200) ,
			  email VARCHAR(200) NOT NULL ,
			  age INT ,
			  phone_no VARCHAR(200)
			)
      </sql:update>
      
      <c:if test="${ upNo eq 0 }" >
      	<h3> Table is created. </h3>
      </c:if>
      <c:if test="${ upNo eq 1 }" >
      	<h3> Table is not created. </h3>
      </c:if>
      
      <!-- insert record -->
      <sql:update dataSource="${myDb}" var="upNo">
      		INSERT INTO employee(first_name, email, age ) VALUES( 'john', 'john@google.com', 18 )
      </sql:update>
      
      <c:if test="${ upNo eq 0 }" >
      	<h3> A record is not inserted. </h3>
      </c:if>
      <c:if test="${ upNo eq 1 }" >
      	<h3> A record is inserted. </h3>
      </c:if>
      
      <sql:update dataSource="${myDb}" var="upNo">
      		INSERT INTO employee(first_name, email, age ) VALUES( ?, ?, ? )
      		<sql:param>Brown</sql:param>
      		<sql:param>brown@google.com</sql:param>
      		<sql:param>20</sql:param>
      </sql:update>
      
      <c:if test="${ upNo eq 0 }" >
      	<h3> A record is not inserted. </h3>
      </c:if>
      <c:if test="${ upNo eq 1 }" >
      	<h3> A record is inserted. </h3>
      </c:if>
      
      <c:set var="records" value="${[ [ 'Test', 'test@gmail.com', 20 ], [ 'jane', 'jane@gmail.com', 22 ] ] }" />
      
      <c:forEach var="record" items="${ records }" >
      	  <sql:update dataSource="${myDb}" var="upNo">
      		INSERT INTO employee(first_name, email, age ) VALUES( ?, ?, ? )
      		<sql:param> ${ record[0] } </sql:param>
      		<sql:param> ${ record[1] } </sql:param>
      		<sql:param> ${ record[2] } </sql:param>
      	  </sql:update>
      	  
      	  <c:if test="${ upNo eq 0 }" >
	      	<h3> A record is not inserted. </h3>
	      </c:if>
	      <c:if test="${ upNo eq 1 }" >
	      	<h3> A record is inserted. </h3>
	      </c:if> 
      </c:forEach>
      
 
 	  <!-- select table -->
      <sql:query dataSource="${myDb}" var="result">
         SELECT id, first_name, last_name, email, age from EMPLOYEE where 1 = ?
         <sql:param>1</sql:param>
      </sql:query>
 
      <table border="1" width="100%">
         <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>EMAIL</th>
            <th>Age</th>
         </tr>
         
         <c:forEach var="row" items="${result.rows}">
            <tr>
               <td><c:out value = "${row.id}"/></td>
               <td><c:out value = "${row.first_name}"/></td>
               <td><c:out value = "${row.last_name}"/></td>
               <td><c:out value = "${row.email}"/></td>
               <td><c:out value = "${row.age}"/></td>
            </tr>
         </c:forEach>
      </table>
 
   </body>
</html>