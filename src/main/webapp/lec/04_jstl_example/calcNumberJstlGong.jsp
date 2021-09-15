<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "d" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "e" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "f" uri = "http://java.sun.com/jsp/jstl/core" %>

<c:set var="a" value="${ param.a }" />
<c:set var="b" value="${ param.b }" /> 
	
<c:set var="c" value="${ param.a + param.b }"/>
<c:set var="d" value="${ param.a - param.b }"/>
<c:set var="e" value="${ param.a * param.b }"/>
<c:set var="f" value="${ param.a / param.b }"/>

 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calculation of Two Numbers</title>
</head>
<body>

<h1>Sum of Two Numbers</h1>

<form>
	<c:out value='${ a }'/> <br/><br/>
	<c:out value='${ b }'/> <br/><br/>

	a = <input type="number" step="any" name="a" value="<c:out value='${ a }'/>" size=3 /> <br/><br/>

	b = <input type="number" step="any" name="b" value="${ b }" size=3 /> <br/><br/>
	
	[ + ] = <input type="number" step="any"          value=<c:out value='${ c }'/> size=3 readonly></input> <br/><br/>
	[ - ] = <input type="number" step="any"          value=<c:out value='${ d }'/> size=3 readonly></input> <br/><br/>   
	[ * ] = <input type="number" step="any"          value=<c:out value='${ e }'/> size=3 readonly></input> <br/><br/>   
	[ / ] = <input type="number" step="any"          value=<c:out value='${ f }'/> size=3 readonly></input> <br/><br/>   
	   
	    <input type="submit" value="Sum" />
	    
	
</form>

</body>
</html>
