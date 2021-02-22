<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<c:set var="a" value="${ param.a }" />
<c:set var="operator" value="${ param.operator }" />
<c:set var="b" value="${ param.b }" />

<c:set var="id" value="${ param.id }" /> 
<c:set var="selId" value="${ param.selId }" />  

<c:set var="doCalc" value="${ empty param.id }" /> 

<c:if test="${ empty operator }" >
	<c:set var="operator" value="+" /> 
</c:if>

<c:if test="${ empty doCalc }" >
	<c:set var="c" value="${ '' }" />
</c:if>

<c:if test="${ not empty doCalc }" >
	<c:if test="${ operator eq '+' }" >
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
</c:if> 

<!-- create db connection -->
<sql:setDataSource var="myDb" driver = "org.mariadb.jdbc.Driver"
   url = "jdbc:mariadb://localhost:3306/MY_SCHEMA"
   user = "MY_USER"  password = "admin"/>
   
<!-- create table -->
<sql:update dataSource="${myDb}" var="upNo">
  CREATE TABLE if not exists MY_CALC_SUN ( 
	  id INT PRIMARY KEY AUTO_INCREMENT ,
	  a VARCHAR(200) NOT NULL default '' ,
	  operator VARCHAR(200) NOT NULL default '+',
	  b VARCHAR(200) NOT NULL default '' ,
	  c VARCHAR(200) 
  )
</sql:update>

<c:if test="${ not empty doCalc and ( not empty a or not empty b ) }" >
	<!-- DB에 해당 연산 기록을 추가한다. -->
	<sql:update dataSource="${myDb}" var="upNo">
		INSERT INTO MY_CALC_SUN( a, operator, b, c ) VALUES ( ?, ?, ?, ? )
		<sql:param> ${ a }</sql:param>
		<sql:param> ${ operator }</sql:param>
		<sql:param> ${ b }</sql:param>
		<sql:param> ${ c }</sql:param>
	</sql:update>
	
	<c:if test="${ 0 < upNo }" >
		<h3> A record is inserted. </h3>
	</c:if>
</c:if>

<c:if test="${ not empty id }" >
	<!-- DB에서 id에 해당 연산 기록을 가져온다. -->
	<sql:query dataSource="${myDb}" var="result">
	   SELECT id, a, operator, b, c FROM MY_CALC_SUN WHERE id = NVL( ?, ? )
	   <sql:param>${ id }</sql:param>
	   <sql:param>${ selId }</sql:param>  
	</sql:query> 
	
	<c:forEach var="row" items="${result.rows}">
		<c:set var="a" value="${ row.a }" />
		<c:set var="operator" value="${ row.operator }" />
		<c:set var="b" value="${ row.b }" />
		<c:set var="c" value="${ row.c }" />
	</c:forEach>	
</c:if>

<!-- DB에서 이전 연산 기록을 모두 가져온다. -->
<sql:query dataSource="${myDb}" var="result">
   SELECT id, a, operator, b, c FROM MY_CALC_SUN order by ID desc  
</sql:query>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사칙 연산</title>
</head>
<body>

<h1>두 수의 연산</h1>

<form>
	History 
	<!-- 이전 기록 출력 -->
	<select name="id" onchange="submit();">
		<option value="" ></option>
		<c:forEach var="row" items="${result.rows}">	
			<option value="${ row.id }" ${ id eq row.id or selId eq row.id ? 'selected' : '' }>
				${ row.a } ${ row.operator } ${ row.b } = ${ row.c }
			</option>
		</c:forEach>
	</select>
	<br/><br/>
</form>

<form>	
	a = <input type="number" step="any" name="a" id="a" value="${ a }" size=3 /> <br/><br/>
	o = <select name="operator" id="operator" >
			<option value="+" ${ operator == '+' ? 'selected' : '' } >+</option>
			<option value="-" ${ operator eq '-' ? 'selected' : '' } >-</option>
			<option value="*" ${ operator eq '*' ? 'selected' : '' } >*</option>
			<option value="/" ${ operator eq '/' ? 'selected' : '' } >/</option>
	     </select> 
	     <br/><br/>
	b = <input type="number" step="any" name="b" id="b" value="${ b }" size=3 /> <br/><br/>
	c = <input type="number" step="any"         value="${ c }" size=3 readonly></input> <br/><br/>
	<c:if test="${ not empty param.selId or not empty param.id }" >
	    <input type="hidden" name="selId" value="${ empty param.selId ? param.id : param.selId }" />
	</c:if>
	<input type="submit" value="계산하기" />
</form>

</body>
</html>
