<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<c:set var="a" value="${ param.a }" />
<c:set var="b" value="${ param.b }" /> 

<c:set var="c" value="${ a + b }" />

<c:if test="${ empty a and empty b }" >
	<c:set var="c" value="" />
</c:if>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sum of Two Numbers</title>
</head>
<body>

<h1>Sum of Two Numbers</h1>

<form>
	<c:out value='${ a }'/> <br/><br/>
	a = <input type="number" step="any" name="a" value="<c:out value='${ a }'/>" size=3 /> <br/><br/>
	a2 = <input type="number" step="any"         value="${ a }" size=3 /> <br/><br/>
	b = <input type="number" step="any" name="b" value="${ b }" size=3 /> <br/><br/>
	c = <input type="number" step="any"          value="${ a + b }" size=3 readonly></input> <br/><br/>
	c2 = <input type="number" step="any"         value="${ c }" size=3 readonly></input> <br/><br/>
	    <input type="submit" value="Sum" />
</form>

</body>
</html>
