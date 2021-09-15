<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 

<%@ page import = "java.util.*"%>

<sql:setDataSource var="snapshot" scope="request" 
	driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://localhost:3306/XCLICK_DEPLOY3_LARGE_DATA"
	user="XCLICK_DEPLOY3" password="admin" />

