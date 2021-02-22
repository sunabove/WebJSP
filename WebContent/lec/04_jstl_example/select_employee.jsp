<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
      	<h3> A table is dropped. </h3>
      </c:if> 
      
      <!-- create table -->
      <sql:update dataSource="${myDb}" var="upNo">
      		CREATE TABLE employee ( 
			  id INT PRIMARY KEY AUTO_INCREMENT ,
			  first_name VARCHAR(200) NOT NULL ,
			  last_name VARCHAR(200) ,
			  email VARCHAR(200) NOT NULL ,
			  age INT ,
			  phone_no VARCHAR(200),
			  up_dt TIMESTAMP NOT NULL default NOW()
			)
      </sql:update>
      
      <c:if test="${ upNo eq 0 }" >
      	<h3> A table is created. </h3>
      </c:if> 
      
      <!-- insert record -->
      <sql:update dataSource="${myDb}" var="upNo">
      		INSERT INTO employee(first_name, email, age, up_dt ) VALUES( 'john', 'john@google.com', 18, NOW() )
      </sql:update>
      
      <c:if test="${ upNo eq 0 }" >
      	<h3> A record is not inserted. </h3>
      </c:if>
      <c:if test="${ upNo eq 1 }" >
      	<h3> A record is inserted. </h3>
      </c:if>
      
      <jsp:useBean id="now" class="java.util.Date" />
      
      <sql:update dataSource="${myDb}" var="upNo">
      		INSERT INTO employee(first_name, email, age, up_dt ) VALUES( ?, ?, ?, ? )
      		<sql:param>Brown</sql:param>
      		<sql:param>brown@google.com</sql:param>
      		<sql:param value="20" />
      		<sql:dateParam value="${ now }" />
      </sql:update>
      
      <c:if test="${ upNo eq 0 }" >
      	<h3> A record is not inserted. </h3>
      </c:if>
      <c:if test="${ upNo eq 1 }" >
      	<h3> A record is inserted. </h3>
      </c:if>
      
      <c:forTokens var="record" delims=";" items="Test, test@gmail.com, 20; jane, jane@gmail.com, 22"  >
      	  <c:set var="item" value="${fn:split( record, ',' )}" />
      	  
      	  <sql:update dataSource="${myDb}" var="upNo">
      		INSERT INTO employee(first_name, email, age, up_dt ) VALUES( ?, ?, ?, ? )
      		<sql:param value="${ item[0] }" />
      		<sql:param value="${ item[1] }" />
      		<sql:param value="${ item[2] }" />
      		<sql:param value="${ now }" />
      	  </sql:update>
      	  
      	  <c:if test="${ upNo eq 0 }" >
	      	<h3> A record is not inserted. </h3>
	      </c:if>
	      <c:if test="${ upNo eq 1 }" >
	      	<h3> A record is inserted. </h3>
	      </c:if> 
      </c:forTokens>
      
 
 	  <!-- select table -->
      <sql:query dataSource="${myDb}" var="result">
         SELECT id, first_name, last_name, email, age, up_dt from EMPLOYEE where 1 = ?
         <sql:param>1</sql:param>
      </sql:query>
 
      <table border="1" width="100%">
         <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>EMAIL</th>
            <th>Age</th>
            <th>Up Date</th>
         </tr>
         
         <c:forEach var="row" items="${result.rows}">
            <tr>
               <td> ${row.id} </td>
               <td> ${row.first_name} </td>
               <td> ${row.last_name} </td>
               <td> ${row.email} </td>
               <td> ${row.age} </td>
               <td> <fmt:formatDate value="${ row.up_dt }" pattern="yyyy-MM-dd hh:mm:ss"/> </td>
            </tr>
         </c:forEach>
      </table>
 
   </body>
</html>