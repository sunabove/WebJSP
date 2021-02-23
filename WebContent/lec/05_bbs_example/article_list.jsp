<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>게시물 목록</title>
</head>

<body>
	<!-- create db connection -->
	<sql:setDataSource var="myDb" driver="org.mariadb.jdbc.Driver"
		url="jdbc:mariadb://localhost:3306/MY_SCHEMA" user="MY_USER"
		password="admin" />

	<!-- select table -->
	<sql:query dataSource="${myDb}" var="result">
        SELECT ROW_NUMBER() OVER( ORDER BY a.article_id ) AS rno ,  
        b.board_id, article_id, article_user_id, board_name, user_name, 
		title, content, view_count, a.up_dt
		FROM  
		( SELECT NVL( ?, 1 ) board_id ) AS p
		LEFT JOIN board b ON ( p.board_id = b.board_id )
		LEFT JOIN article a ON ( b.board_id = a.board_id ) 
		LEFT JOIN user u ON( a.article_user_id = u.user_id )
         <sql:param value="${ 1 }" />
	</sql:query>

	<table border="1" cellspacing="0" width="100%">

		<colgroup>
			<!-- No -->
			<col width="10%"/>
			<!-- Title -->
			<col width=""/>
			<!-- Writer -->
			<col width="10%"/>
			<!-- Up date -->
			<col width="20%"/>
			<!-- View count -->
			<col width="10%"/>			
		</colgroup>

		<thead>
			<tr>
				<th colspan="100%" align="left">
					<select>
						<option>Notice</option>
					</select>
				</th>
			</tr>
			<tr>
				<th align="left" colspan="2" >
					총 123,456건 
				</th>
				<th colspan="2" align="right">
					<input type="text" value="" width="100%"/>
				</th>
				<th align="left">
					<input type="button" value="검색" width="100%"/>
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
			<c:forEach var="row" items="${result.rows}">
				<tr>
					<td align="right">${row.rno}</td>
					<td>${row.title}</td>
					<td align="center">${row.user_name}</td>
					<td align="center"><fmt:formatDate value="${ row.up_dt }"
							pattern="yyyy-MM-dd hh:mm:ss" /></td>
					<td align="right">${row.view_count}</td>
				</tr>
			</c:forEach>
		</tbody>

		<tfoot>
			<tr>
				<td colspan="100%">&nbsp;</td>
			</tr>
		</tfoot>


	</table>

</body>
</html>