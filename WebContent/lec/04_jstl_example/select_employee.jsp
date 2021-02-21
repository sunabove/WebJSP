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
      	<title>SELECT Operation</title>
   </head>

   <body>
      <sql:setDataSource var = "snapshot" driver = "org.mariadb.jdbc.Driver"
         url = "jdbc:mariadb://localhost:3306/MY_SCHEMA"
         user = "MY_USER"  password = "admin"/>
 
      <sql:query dataSource = "${snapshot}" var = "result">
         SELECT id, first_name, last_name, email, age from EMPLOYEE;
      </sql:query>
 
      <table border="1" width="100%">
         <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>EMAIL</th>
            <th>Age</th>
         </tr>
         
         <c:forEach var = "row" items = "${result.rows}">
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