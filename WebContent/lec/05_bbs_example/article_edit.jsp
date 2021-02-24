<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%-- start of logic --%>

<%-- 세션 체크 기능이 필요 없으면 삭제하여야 합니다. --%>
<c:if test="${ empty sessionScope.userId }">
	<%-- 로그인 세션 체크 / 미로그인시 로그인 페이지로 이동한다. --%>
	<c:redirect url="user_login.jsp">
	</c:redirect>
</c:if>
<%-- // 세션 체크 기능이 필요 없으면 삭제하여야 합니다. --%>

<!-- 데이터베이스 연결 -->
<sql:setDataSource var="myDb" driver="org.mariadb.jdbc.Driver" 
	url="jdbc:mariadb://localhost:3306/MY_SCHEMA" user="MY_USER" password="admin" />
	
<!DOCTYPE html>
<html lang="ko">
<head>
<title>글쓰기</title>
<meta charset="utf-8">
</head>
<body>

<h3> Hello, World! </h3>

</body>
</html>
