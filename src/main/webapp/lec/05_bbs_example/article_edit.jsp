<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%-- start of logic --%>

<%-- 세션 체크 기능이 필요 없으면 삭제하여야 합니다. --%>
<c:if test="${ empty sessionScope.userId }">
	<%-- 로그인 세션 체크 / 미로그인시 로그인 페이지로 이동한다. --%>
	<c:redirect url="user_login.jsp">
	</c:redirect>
</c:if>
<%-- // 세션 체크 기능이 필요 없으면 삭제하여야 합니다. --%>

<!-- 데이터베이스 연결 -->
<sql:setDataSource var="myDb" driver="oracle.jdbc.driver.OracleDriver" 
	url="jdbc:oracle:thin:@localhost:1521:orcl" user="john" password="a" scope="application" />

<c:set var="board_id" value="${ empty param.board_id ? 1 : param.board_id }" />

<jsp:useBean id="now" class="java.util.Date" />
	
<sql:query var="board" dataSource="${myDb}" >
	select board_name from board where board_id = ? 
	<sql:param>${ board_id }</sql:param>
</sql:query>

<c:forEach var="row" items="${board.rows}">
	<c:set var="boardName" value="${ row.board_name }" />
</c:forEach>

<c:set var="articleId" value="${ param.article_id }" />
<c:set var="articleTitle" value="${ param.title }" />
<c:set var="articleContent" value="${ param.content }" />

<c:if test="${ empty articleId  and ( not empty articleTitle and not empty articleContent ) }" >
	<sql:transaction dataSource="${myDb}"  >
		<sql:update var="upNo" >
			INSERT INTO article( board_id, article_user_id, title, content ) VALUES
			( ?, ?, ?, ? )
			<sql:param>${ board_id }</sql:param>
			<sql:param>${ userId }</sql:param>
			<sql:param>${ articleTitle }</sql:param>
			<sql:param>${ articleContent }</sql:param>
		</sql:update>
		
		<sql:query var="lastId" >
		    SELECT MAX(article_id) as last_id FROM article where board_id = ?
		    <sql:param>${ board_id }</sql:param> 
		</sql:query >
		
		<h1>article inserted.</h1>
	
		<c:forEach var="row" items="${lastId.rows}">
			<c:set var="articleId" value="${ row.last_id }" />
		</c:forEach>
		
		<h1>article id = ${ articleId }</h1>
		
	</sql:transaction>
</c:if>

<c:if test="${ not empty articleId and ( not empty articleTitle and not empty articleContent ) }" >
	<sql:update var="upNo" dataSource="${myDb}" >
		UPDATE article SET
		title  = ? ,
		content = ?
		WHERE article_id = ?
		<sql:param>${ articleTitle }</sql:param>
		<sql:param>${ articleContent }</sql:param>
		<sql:param>${ articleId }</sql:param>
	</sql:update>
</c:if>

<%-- end of of logic --%>
	
<!DOCTYPE html>
<html lang="ko">
<head>
<title>글쓰기</title>
<meta charset="utf-8">
</head>
<body style="max-width: 600px; margin: auto; text-align: center;">

<h3> 글쓰기 </h3>

<form>
<table border="1" width="100%" cellspacing="1">
	<colgroup>
		<col width="40"/>
		<col/> 
		
		<col/>
		<col/>
		
		<col width="50"/>
	</colgroup>
	
	<thead>
		<tr>
			<th colspan="2" align="left"><font size="2"> * 게시판 : ${ boardName } </font>
			</th>
			<th colspan="3" align="right">
				<font size="2">
					* ${userName} 님
					&nbsp;
					* <a href="user_logout.jsp">로그 아웃</a>
					&nbsp;&nbsp;
					* 총 접속자 :
						<fmt:formatNumber value="${ applicationScope.totalConnCount }" pattern="#,###" /> 
					  명
					&nbsp;
				</font>
			</th>  
		</tr> 
	</thead>
	
	<tbody>
		<tr>
			<td colspan="2" align="left">
				<input type="button" value="이전 글" /> 
				<input type="button" value="다음 글" />
			</td>
			<td colspan="3" align="right">
				<input type="button" value="목록" />
			</td>
		</tr>
		
		<tr>
			<td align="left">
				<input type="text" value="* 제목" disabled size="4" />
			</td>
			<td colspan="2" align="left">
				<input type="text" name="title" value="${ articleTitle }" size="36" />
			</td>
			<td colspan="2" align="right">
				<input type="text" disabled size="14" value="작성일 : <fmt:formatDate value='${ now }' pattern='yyyy-MM-dd' />" />
			</td>
		</tr>
		
		<tr>
			<td align="left">
				<input type="text" value="* 작성자" disabled size="4" />
			</td>
			<td colspan="4" align="left">
				<input type="text" value="${ userName }" size="5" disabled />
			</td>
		</tr>
		
		<tr>
			<td colspan="100%">
				<textarea name="content" style="width: 99%; height: 200px;">${ articleContent }</textarea>
			</td>
		</tr>
		
		<tr>
			<td colspan="1" align="left" >
				<input type="text" size="4" value="* 댓글" disabled />
			</td>
			<td colspan="3" align="left" >
				<input type="text" size="80"/>
			</td>
			<td align="right">
				<input type="button" value="등록" />
			</td>
		</tr> 
	</tbody>
	
	<tfoot>
		<tr>
			<td colspan="100%" align="center">
				<input type="hidden" name="board_id" value="${ param.board_id }" />
				<input type="hidden" name="article_id" value="${ articleId }" />
				<input type="submit" value="저장" /> 
				<input type="button" value="취소" />
				&nbsp;&nbsp;
				<input type="button" value="삭제" />
			</td>
		</tr>
	</tfoot>
	
</table>
</form>

</body>
</html>
