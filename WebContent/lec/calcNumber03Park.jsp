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
	
		String err = null ;
		String a = request.getParameter("a");
		String b = request.getParameter("b");
		String operator = request.getParameter( "operator" );
		
		if( operator == null ) {
			operator = "+";
		}
		
		System.out.println( "operator = " + operator );
		
		if (a == null) { a = "0"; }
		if (b == null) { b = "0"; }
		
		Double numA = null ;
		Double numB = null ;
		
		try {		
			numA = Double.parseDouble(a);
		} catch ( Exception e ) {
			numA = 0.0;
			err = "A 연산자가 잘못된 값입니다." ;
		}
		
		try {		
			numB = Double.parseDouble(b);
		} catch ( Exception e ) {
			numB = 0.0;
			err = "B 연산자가 잘못된 값입니다." ;
		}		
		
		Double result = null ;
		
		if( err != null || operator == null ) {
			// do nothing
		} else if( operator.equalsIgnoreCase( "+" ) ) {
			result = numA + numB ;
		} else if( operator.equalsIgnoreCase( "-" ) ) {
			result = numA - numB ;
		} else if( operator.equalsIgnoreCase( "*" ) ) {
			result = numA * numB ;
		} else if( operator.equalsIgnoreCase( "/" ) ) {
			if ( numB == 0){
				err = "B 연산자가 0이면 나눗셈을 할 수 없습니다." ;
			}else{
				result = numA / numB ;}
		}
		
		System.out.println( "result = " + result );
	%>
	
	<form>
		<input type="number" name="a" step="any" value="<%=a%>"/>
		
		<select name="operator" > 
			<option value="+" <%= "+".equalsIgnoreCase( operator ) ? "selected" : "" %> > + </option>
			<option value="-" <%= "-".equalsIgnoreCase( operator ) ? "selected" : "" %> > - </option>
			<option value="*" <%= "*".equalsIgnoreCase( operator ) ? "selected" : "" %> > * </option>
			<option value="/" <%= "/".equalsIgnoreCase( operator ) ? "selected" : "" %> > / </option>
		</select>
		
		<input type="number" name="b" step="any" value="<%=b%>"/> <br/><br/>
		<input type="submit" value="계산해 주세요." />
		<br/><br/>
		
		<p <%= err == null ? "style=\'visiblity: hidden;\'" : "" %>> 에러 메시지 : <%= err == null ? "" : err %> </p>
		결과 = <input type="number" value="<%=result%>"/>
	</form>
	
</body>

</html>