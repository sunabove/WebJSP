<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
​
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
​
	<%
	// 박 보람 작성 
	
	String n1 = request.getParameter( "n1" );
	String n2 = request.getParameter( "n2" );


	System.out.println( "a = " + n1);
	
	Integer sum = null ;
	
	if (n1 != null && n2 != null) {
		sum = Integer.parseInt(n1) + Integer.parseInt(n2) ; 
	} else {
	}
	
	%>
	
	
	<h1> 덧셈 결과 : <%= null == sum ? "" : sum %></h1>
	
	<form>
		n1 : <input type="number" name="n1" step="any" value="<%= n1 %>" />
		<br/><br/>
		n2 : <input type="number" name="n2" step="any" value="<%= n2 %>" />
		<br/><br/>
		<input type="submit" value="더하기" />
	</form>
​
</body>
</html>