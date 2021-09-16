<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!-- create db connection -->
<sql:setDataSource var="myDb" driver="oracle.jdbc.driver.OracleDriver" url="jdbc:oracle:thin:@localhost:1521:orcl" user="john" password="a" scope="application" />

<c:if test="${ not empty param.first_name }" >
	<c:catch var="myerror">
		<sql:update dataSource="${myDb}" var="upNo">
	      	INSERT INTO employee(first_name, last_name, email, age ) VALUES( ?, ?, ?, ? )
	      	<sql:param>${param.first_name}</sql:param>
	      	<sql:param>${param.last_name}</sql:param> 
			<sql:param> abc@google.com </sql:param>
			<sql:param value="20" /> 
		</sql:update>
	</c:catch>
</c:if>

<!-- select table -->
<sql:query dataSource="${myDb}" var="result">
       SELECT id, first_name, last_name, email, age, up_dt from EMPLOYEE where 1 = ?
       <sql:param>1</sql:param>
</sql:query>

<!DOCTYPE html>
<html>
<body>
    ${myerror}

	<h2>HTML Forms</h2>

	<form>
		<select name="staff">
			<option value="1" ${param.staff eq 1 ? 'selected':'' }>교수</option>
			<option value="2" ${param.staff eq 2 ? 'selected':'' }>학생</option>
			<option value="3" ${param.staff eq 3 ? 'selected':'' }>조교</option>
		</select> <br /> <label for="fname">First name:</label><br> <input type="text" name="first_name" value="${param.first_name}"><br> <label for="lname">Last name:</label><br> <input type="text" name="last_name" value="${param.last_name}"><br> <br>

		<textarea name="my_text">${param.my_text}</textarea>
		<input type="submit" value="Submit">
	</form>

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
				<td>${row.id}</td>
				<td>${row.first_name}</td>
				<td>${row.last_name}</td>
				<td>${row.email}</td>
				<td>${row.age}</td>
				<td>${ row.up_dt }</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>