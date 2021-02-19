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
		// Java Coding
		// Java 코드는 서버에서 실행된다.
		String myName = "John";
		
		// String out ; -- Error 
	
		for (int i = 0; i < 10; i++) {
			String text = "<h1> Hello ... Good Morning ! </h1>";
			out.write(text);
		}
	%>

</body>
</html>