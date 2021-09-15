<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%-- logic --%>

<c:if test="${ not empty param.userId and not empty param.passwd }">
	<%-- 로그인 처리 --%>

	<!-- 데이터베이스 연결 -->
	<sql:setDataSource var="myDb" driver="oracle.jdbc.driver.OracleDriver" 
		url="jdbc:oracle:thin:@localhost:1521:orcl" user="john" password="a" scope="application" />

	<!-- DB에서 이름과 암호가 동일한 유저의 존재 여부를 체크한다. -->
	<sql:query dataSource="${ myDb }" var="result">
	   SELECT user_id, user_name 
	   FROM 
	   (select ? p_user_name, ? p_passwd FROM DUAL ) p,
	   users u  
	   WHERE 1 = 1
	   AND p_user_name IN ( u.user_name, u.email ) 
	   AND u.passwd = p_passwd  
	   <sql:param value="${param.userId}" />
		<sql:param value="${param.passwd}" />
	</sql:query>

	<c:set var="userId" scope="session" value="" />
	<c:set var="userName" scope="session" value="" />

	<%-- 로그인 정보를 세션에 저장한다. --%>
	<c:forEach var="row" items="${result.rows}">
		<c:set var="userId" scope="session" value="${row.user_id}" />
		<c:set var="userName" scope="session" value="${row.user_name}" />
	</c:forEach>

	<c:if test="${ not empty sessionScope.userId }">
		<%-- 로그인 성공하면, 목록 화면으로 이동 --%>
		
		<%-- 박보람 로그인시마다, 총접자수를 1씩 증가시킨다. --%>
		<c:if test="${ empty totalConnCount}">
			<c:set var="totalConnCount" value="0" scope="application" />
		</c:if>
		<c:set var="totalConnCount" value="${ applicationScope.totalConnCount + 1 }" scope="application" />

		<c:redirect url="article_list.jsp">
		</c:redirect>
	</c:if>
</c:if>

<%-- // logic --%>

<html lang="ko">
<head>
<title>로그인 페이지</title>
<meta charset="UTF-8">
</head>

<body style="max-width: 400px; margin: auto; text-align: center;">

<br/><br/>
<h2>로그인</h2>

<form>
	<table border="0" width="100%" cellspacing="1">
		<colgroup>
			<col align="center"/>
			<col/> 
		</colgroup>
		<tr>
			<td colspan="100%">* 아이디</td> 
		</tr>
		
		<tr>
			<td colspan="100%" align="left">
				<input type="text" name="userId" id="userId" value="${ param.userId }" size="50">				
			</td>
		</tr> 
		
		<tr>
			<td>* 비밀번호</td>
			<td align="left">
				<a href="#">비밀번호를 잊어버리셨습니까?</a>
			</td>
		</tr>
		
		<tr>
			<td colspan="100%" align="left">
				<input type="password" name="passwd" id="passwd" value="" size="50">
			</td>
		</tr>
		
		<tr>
			<td colspan="100%" align="center">
				<input type="submit" value="   로그인   ">
			</td>
		</tr>
		
	</table> 
</form>

<form>
	<input type="submit" value=" 회원가입 "> <br/><br/>
</form>

</body>
</html>
