<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<c:set var="a" value="${ param.a }" />
<c:set var="b" value="${ param.b }" />
<c:set var="operator" value="${ param.operator }" /> 

<c:if test="${ empty a and empty b }" >
	<c:set var="c" value="" />
</c:if>

<c:if test="${ operator == '+' }" >
	<c:set var="c" value="${ a + b }" />
</c:if>
<c:if test="${ operator == '-' }" >
	<c:set var="c" value="${ a - b }" />
</c:if>
<c:if test="${ operator == '*' }" >
	<c:set var="c" value="${ a * b }" />
</c:if>
<c:if test="${ operator == '/' }" >
	<c:set var="c" value="${ a / b }" />
</c:if>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사칙 연산</title>
</head>
<body>

<h1>두 수의 연산</h1>

<form>
	a = <input type="number" step="any" name="a" value="${ a }" size=3 /> <br/><br/>
	b = <input type="number" step="any" name="b" value="${ b }" size=3 /> <br/><br/>
	o = <select name="operator">
			<option value="+" ${ operator eq '+' ? 'selected' : '' } >+</option>
			<option value="-" ${ operator eq '-' ? 'selected' : '' } >-</option>
			<option value="*" ${ operator eq '*' ? 'selected' : '' } >*</option>
			<option value="/" ${ operator eq '/' ? 'selected' : '' } >/</option>
	     </select> 
	     <br/><br/>
	c = <input type="number" step="any"         value="${ c }" size=3 readonly></input> <br/><br/>
	<input type="submit" value="계산해주세요." />
</form>

</body>
</html>
