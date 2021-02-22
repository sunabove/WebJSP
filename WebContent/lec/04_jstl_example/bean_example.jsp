<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>JSP Bean Example</title>
</head>
<body>

	<jsp:useBean id="myBean" class="lec.bean.MyBean" />
	
	${ myBean.name } </br>
	
	${ myBean.name = 'Good' } <br/>
	
	${ myBean.name } 
</body>
</html>
