<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:if test="${ not empty param.name and not empty param.passwd }">	
	<%-- 로그인 처리 --%>
	
	<sql:setDataSource var="myDb" driver="org.mariadb.jdbc.Driver" 
		url="jdbc:mariadb://localhost:3306/MY_SCHEMA" user="MY_USER" password="admin" />
	
	<sql:query dataSource = "${ myDb }" var="result">
	   SELECT user_id, user_name 
	   FROM 
	   (select ? user_name, ? passwd FROM DUAL ) as p,
	   user u  
	   WHERER 1 = 1
	   AND p.user_name IN ( u.user_name, u.email ) 
	   AND u.passwd = p.passwd 
	   LIMIT 1
	   <sql:param value="${param.id}"/>
	   <sql:param value="${param.passwd}"/>
	</sql:query> 
	
	<c:set var="userId" 	scope="session" value="" />
	<c:set var="userName" 	scope="session" value="" />
	
	<c:forEach var="row" items="${result.rows}">
	    <c:set var="userId" 	scope="session" value="${row.user_id}" />
	    <c:set var="userName" 	scope="session" value="${row.user_name}" />
	</c:forEach> 
	
	<c:if test="${ not empty sessionScope.userId }"> 
		<%-- 로그인 성공하면, 목록 화면으로 이동 --%>
		
		<c:redirect url="article_list.jsp">
		</c:redirect> 
	</c:if>
</c:if>

<html lang="ko" >
<head>
<title>로그인 페이지</title>
<meta charset="UTF-8">
</head>

<body> 

	<center>
	</center>	 
 
</body>
</html>
