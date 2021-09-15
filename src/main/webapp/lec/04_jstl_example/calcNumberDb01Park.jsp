<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<c:set var="a" value="${ param.a }" />
<c:set var="b" value="${ param.b }" /> 
<c:set var="o" value="${ param.o }" /> 
<c:set var="c" value="0" />
<c:if test="${a.matches('[0-9]+') && b.matches('[0-9]+') && o ne null }">
<c:choose>
    <c:when test = "${o eq '+' }">
    	<c:set var="c" value="${a+b}" />
    </c:when>
    <c:when test = "${o eq '-' }">	
   		<c:set var="c" value="${a-b}" />
	</c:when>
	<c:when test = "${o eq '*' }">
    	<c:set var="c" value="${a*b}" />
	</c:when>
	<c:when test = "${o eq '/' }">
    	<c:set var="c" value="${a/b}" />
	</c:when>
</c:choose>
</c:if>

<sql:setDataSource var="myDb" driver = "org.mariadb.jdbc.Driver"
         url = "jdbc:mariadb://localhost:3306/MY_SCHEMA"
         user = "MY_USER"  password = "admin"/>

<!-- create table -->
<sql:update dataSource="${myDb}" var="upNo">
  CREATE TABLE if not exists my_calc (
	id INT PRIMARY KEY AUTO_INCREMENT ,
	num1 int NOT NULL ,
	num2 int NOT NULL,
	op VARCHAR(200) NOT NULL
  )
</sql:update>
         
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sum of Two Numbers</title>
</head>
<body>

<h1>Sum of Two Numbers</h1>


<sql:query dataSource="${myDb}" var="result">
         SELECT id, num1, op, num2 from my_calc 
      </sql:query>
 
      <table border="1" width="50%">
         <tr>
            <th>ID</th>
            <th>num1</th>
            <th>op</th>
            <th>num2</th>
            <th>  </th>
         </tr>
         
         <c:forEach var = "row" items = "${result.rows}">
            <tr>
               <td><c:out value = "${row.id}"/></td>
               <td><c:out value = "${row.num1}"/></td>
               <td><c:out value = "${row.op}"/></td>
               <td><c:out value = "${row.num2}"/></td>
               <td><a href="?a=${row.num1}&o=${row.op eq '+' ? '%2B' :  row.op}&b=${row.num2}">다시 실행.</a></td>
            </tr>
         </c:forEach>
      </table>	
<hr/>
<form>



	<input type="number" step="any" name="a" value="${a}" size=3 /> 
	<select name="o" >
			<option value="+" ${ o eq '+' ? 'selected' : '' } >+</option>
			<option value="-" ${ o eq '-' ? 'selected' : '' } >-</option>
			<option value="*" ${ o eq '*' ? 'selected' : '' } >*</option>
			<option value="/" ${ o eq '/' ? 'selected' : '' } >/</option>
	</select>
	<input type="number" step="any" name="b" value="${ b }" size=3 /> 
	
	<c:if test="${a.matches('[0-9]+') && b.matches('[0-9]+') && o ne null }">
		= ${c}
		<sql:update dataSource="${myDb}" var="upNo">
      		INSERT INTO my_calc(num1, num2, op) VALUES( ${a}, ${b}, '${o}' )
      	</sql:update>
     </c:if>
	
	<br/>
	
	
	<input type="submit" value="계산" />
	
	<br/>
</form>

	
     <c:if test="${a ne null && !a.matches('[0-9]+')}">
	 	a 오류.
	 </c:if>
	 <c:if test="${b ne null && !b.matches('[0-9]+')}">
	 	b 오류.
	 </c:if>


</body>
</html>
