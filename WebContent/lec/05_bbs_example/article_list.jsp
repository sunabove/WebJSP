<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%-- start of logic --%>

<c:if test="${ empty sessionScope.userId }">
	<%-- 로그인 세션 체크 / 미로그인시 로그인 페이지로 이동한다. --%>
	<c:redirect url="user_login.jsp">
	</c:redirect>
</c:if>

<!-- create database connection -->
<sql:setDataSource var="myDb" driver="org.mariadb.jdbc.Driver" 
	url="jdbc:mariadb://localhost:3306/MY_SCHEMA" user="MY_USER" password="admin" />
	
<c:set var="board_id" value="${ param.board_id }" />
	
<!-- board list -->
<sql:query dataSource="${myDb}" var="boardList">
       SELECT board_id, board_name
	FROM board WHERE DELETED = 0
	ORDER BY board_id
</sql:query>

<!-- article list -->
<sql:query dataSource="${myDb}" var="articleList">
    SELECT ROW_NUMBER() OVER( ORDER BY a.article_id ) AS rno ,  
    b.board_id, article_id, article_user_id, board_name, user_name, 
	title, content, view_count, a.up_dt
	FROM  
	( SELECT NVL( ?, 1 ) board_id, NVL( ?, '' ) as srch_keyword ) AS p
	LEFT JOIN board b ON ( p.board_id = b.board_id )
	LEFT JOIN article a ON ( b.board_id = a.board_id ) 
	LEFT JOIN user u ON( a.article_user_id = u.user_id )
	WHERE b.deleted = 0 AND a.deleted = 0 AND 0 < INSTR( title, srch_keyword )
	
	LIMIT ?, ? 
	
    <sql:param value="${ board_id }" />
    <sql:param value="${ param.srch_keyword }" />
    
    <sql:param value="${ empty param.page_no ? 0 : (param.page_no -1)*10 }" />
    <sql:param value="${ empty param.row_cnt ? 10 : ( param.row_cnt + 0 ) }" />
</sql:query>

<!-- article total count -->
<sql:query dataSource="${myDb}" var="articleTotalCountRs">
    SELECT COUNT(*) as cnt
	FROM 
	( SELECT NVL( ?, 1 ) board_id, NVL( ?, '' ) as srch_keyword ) AS p
	LEFT JOIN article a ON( p.board_id = a.board_id )
	WHERE		
	a.deleted = 0 AND 0 < INSTR( title, srch_keyword )
	
    <sql:param value="${ board_id }" />
    <sql:param value="${ param.srch_keyword }" />
</sql:query>

<c:forEach var="row" items="${articleTotalCountRs.rows}">
	<c:set var="articleTotalCount" value="${ row.cnt }" />
</c:forEach>

<%-- end of logic --%>	

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>게시물 목록</title>
</head>

<body>
	<table border="1" cellspacing="0" width="100%">

		<colgroup>
			<!-- No -->
			<col width="5%"/>
			<!-- Title -->
			<col width=""/>
			<!-- Writer -->
			<col width="10%"/>
			<!-- Up date -->
			<col width="150"/>
			<!-- View count -->
			<col width="7%"/>			
		</colgroup>

		<thead>
			<tr>
				<th colspan="100%" align="left">
					<form>
						&nbsp; 
						<font size="2"> 게시판</font>	 
						&nbsp;					
						<select name="board_id" onchange="submit();">
							<c:forEach var="row" items="${boardList.rows}">
								<option value="${ row.board_id }" ${ row.board_id == board_id ? 'selected' : '' } >
									${ row.board_name }
								</option>
							</c:forEach>
						</select>
						
						&nbsp;&nbsp;
						
						<font size="2">
							* 접속자명 : ${userName}
							&nbsp;&nbsp;
							* <a href="user_logout.jsp">로그 아웃</a>
							* 총 접속자 :
								<fmt:formatNumber value="${ articleTotalCount }" pattern="#,###" /> 
							  명
							&nbsp;
						</font>
					</form>
				</th>
			</tr>
			
			<tr>
				<th align="left" colspan="2" >
					&nbsp;
					<font size="2"> 
					   총 <fmt:formatNumber value="${ articleTotalCount }" pattern="#,###" /> 건 
					</font>					 
				</th>
				<th colspan="3" align="right">
					<form>
						<nobr>					
							<input type="text" name="srch_keyword" value="${ param.srch_keyword }" size="30"/>
							<input type="submit" value="검색" width="100%"/>
						</nobr>
					</form>					
				</th>
			</tr>
			
			<tr>
				<th>No.</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>

		<tbody>
			<c:forEach var="row" items="${articleList.rows}">
				<tr>
					<td align="right">${row.rno}</td>
					<td>${row.title}</td>
					<td align="center">${row.user_name}</td>
					<td align="center">
						<fmt:formatDate value="${ row.up_dt }" pattern="yyyy-MM-dd hh:mm:ss" />
					</td>
					<td align="right">${row.view_count}</td>
				</tr>
			</c:forEach>
		</tbody>

		<tfoot>
			<tr>
				<td colspan="100%" align="center">
					<c:set var="page_no" value="${ empty param.page_no ? 1 : param.page_no }" />
					<c:set var="row_cnt" value="${ empty param.row_cnt ? 10 : param.row_cnt }" />
					
					<c:forEach var="i" begin="${ page_no < 2 ? 1 : page_no - 1 }" 
									   end="${ (articleTotalCount mod 10) + 1 }" step="1" varStatus ="status">
						<a href="#" onclick="page_no.value=${i}; page_form.submit();">${i}</a> &nbsp;
					</c:forEach> 
					 
					<form id="page_form" >
						<input type="hidden" name="page_no" id="page_no" value="${ page_no }"/>
						<input type="hidden" name=row_cnt   id="row_cnt" value="${ row_cnt }"/>
						<input type="hidden" name="srch_keyword" value="${ param.srch_keyword }" />
					</form>
				</td>
			</tr>
		</tfoot>
		
	</table>

</body>
</html>