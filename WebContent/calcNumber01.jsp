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
		String operator = request.getParameter( "operator" );
		
		System.out.println( "operator = " + operator );
		
		if (a == null) { a = "0"; }
		if (b == null) { b = "0"; }
		
		// double numA = 1;
		Double numA = null ;
		Double numB = null ;
		
		try {		
			numA = Double.parseDouble(a);
		} catch ( Exception e ) {
			numA = 0.0;
		}
		
		try {		
			numB = Double.parseDouble(b);
		} catch ( Exception e ) {
			numB = 0.0;
		}
		
		
		Double result = null ;
		
		if( operator == null ) {
			// do nothing
		} else if( operator.equalsIgnoreCase( "+" ) ) {
			result = numA + numB ;
		} else if( operator.equalsIgnoreCase( "-" ) ) {
			result = numA - numB ;
		} else if( operator.equalsIgnoreCase( "*" ) ) {
			result = numA * numB ;
		} else if( operator.equalsIgnoreCase( "/" ) ) {
			result = numA / numB ;
		}
		
		System.out.println( "result = " + result );
	%>
	
	<form>
		<input type="number" name="a" step="any" value="<%=a%>"/>
		<select name="operator" >
			<option value="+">+</option>
			<option value="-">-</option>
			<option value="*">*</option>
			<option value="/">/</option>
		</select>
		<input type="number" name="b" step="any" value="<%=b%>"/> <br/><br/>
		<input type="submit" value="계산해 주세요." />
		<br/><br/>
		결과 = <input type="number" value="<%=result%>"/>
	</form>
	
</body>
</html>