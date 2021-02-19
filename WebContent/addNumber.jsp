<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	// Java 코드 , 서버단에서 실행됩니다.
	
	String a = request.getParameter( "a" );
	System.out.println( "a = " + a );
	
	%>
	
	<form>
		<input type="number" name="a" value="<%= a %>" />
		<input type="submit" />
	</form>

</body>
</html>