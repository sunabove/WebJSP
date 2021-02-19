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
		String a = request.getParameter("a");
		String b = request.getParameter("b");
		
		if (a == null) { a = "0"; }
		if (b == null) { b = "0"; }
		
		// double numA = 1;
		Double numA = null ;
		Double numB = null ;
		
		try {		
			numA = Double.parseDouble(a);
		} catch ( Exception e ) {
			//numA = 0;
		}
		numB = Double.parseDouble(b);
		
		double result = numA + numB ;
		
		System.out.println( "result = " + result );
	%>
	
	<form>
		a = <input type="number" name="a" step="any" value="<%=a%>"/> <br/>
		b = <input type="number" name="b" step="any" value="<%=b%>"/> <br/><br/>
		<input type="submit" value="더하기" />
		<br/><br/>
		합 = <input type="number" value="<%=result%>"/>
	</form>
	
</body>
</html>