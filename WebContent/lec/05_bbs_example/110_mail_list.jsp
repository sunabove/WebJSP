<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="valid" value="${true}" />

<c:if test="${ empty sessionScope.userid }">
	<%-- 로그인 세션 체크 --%>
	<c:set var="valid" value="${false}" />
	<c:redirect url="100_user_login.jsp">
	</c:redirect>
</c:if>

<sql:query dataSource="${snapshot}" var="mailList">
	<%-- 메일 목록 조회 --%>
	
	SELECT 
	  ( FLOOR( rno/row_cnt ) + 1) AS pno,
	  a.*
	FROM 
	( SELECT 
		  ROW_NUMBER() OVER(ORDER BY INSTR( tm.title, srch_keyword ), tm.RCVDATE ) rno , 
		  tm.mailid AS mailid , 
		  tu.userid, tu.name, tm.title ,tms.simplecontent AS content ,
		  tm.RCVUSERID, tm.RCVDATE, tmr.rcvtype , 
		  row_cnt 
	  FROM 
		  ( SELECT 
		  	NVL(?, 10) AS row_cnt , 
		  	NVL(?, '') AS srch_keyword ,
		  	''
		  	FROM dual 
		  ) AS param , 
		  t_user tu
		  LEFT JOIN t_mail tm 
		  		ON ( tu.userid = tm.rcvUserId 
		  			AND tu.name = NVL( ?, tu.name ) 
		  		)
		  LEFT JOIN t_mail_rcvinfo tmr ON tm.MAILID = tmr.mailid
		  LEFT JOIN t_mail_simplecontent tms ON tm.MAILID = tms.mailid
	  WHERE 1 = 1 
		  AND tm.mailid IS NOT NULL 
		  AND ( LENGTH( srch_keyword ) = 0 OR SIGN( INSTR( tm.title, srch_keyword ) ) = 1 )
	  ORDER BY INSTR( tm.title, srch_keyword ), tm.RCVDATE 
	  LIMIT 0, 10
	) AS a 
	<sql:param value="${param.row_count }"/> <%-- row count --%>
	<sql:param value="${param.srch_keyword}"  /> <%-- srch keyworkd --%>
	<sql:param value="${sessionScope.username}" />			
</sql:query>

<html lang="ko" >
<head>
<title>메일 목록 ${pageContext.request.servletPath} ${ sessionScope.userid }</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width">

<link rel="shortcut icon" type="image/x-icon" href="https://cpwebassets.codepen.io/assets/favicon/favicon-aec34940fbc1a6e787974dcd360f2c6b63348d4b1f4e06c77743096d55480f33.ico">

<link href="./rsc/style_01.css" rel="stylesheet" media="" data-href="https://fonts.googleapis.com/css?family=Roboto:400,100,300,500" >
<link href="./rsc/style_02.css" rel="stylesheet" media="" data-href="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css">
<link href="./rsc/style_03.css" rel="stylesheet" media="" data-href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
<link href="./rsc/style_04.css" rel="stylesheet" > 

<script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>

<script src="https://cpwebassets.codepen.io/assets/common/stopExecutionOnTimeout-157cd5b220a5c80d4ff8e0e70ac069bffd87a61252088146915e8726e5d9f147.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="./rsc/js_000_common.js" ></script>
<script src="./rsc/js_110_mail_list.js" ></script>

</head>

<body>
	<aside id="sidebar" class="nano has-scrollbar">
		<div class="nano-content" tabindex="0" style="right: -17px;">
			<div class="logo-container">
				<span class="logo glyphicon glyphicon-envelope"></span>웹메일
			</div>
			<a class="compose-button"> ${sessionScope.username } </a>
			<menu class="menu-segment">
				<ul>
					<li class="active"><a href="#">받은 메일함<span> (43)</span></a></li>
					<li><a href="#">Important</a></li>
					<li><a href="#">Sent</a></li>
					<li><a href="#">Drafts</a></li>
					<li><a href="#">Trash</a></li>
				</ul>
			</menu> 
			<div class="bottom-padding"></div>
		</div>
		<div class="nano-pane">
			<div class="nano-slider" style="height: 433px; transform: translate(0px, 0px);"></div>
		</div>
	</aside>
	<main id="main">
		<div class="overlay"></div>
		<header class="header">
			<div class="search-box">
				<form >
					<input placeholder="검색 ..." type="text" name="srch_keyword" value="${ param.srch_keyword }"/>
					<span class="icon glyphicon glyphicon-search"></span>
				</form>
			</div>
			<h1 class="page-title">
				<a class="sidebar-toggle-btn trigger-toggle-sidebar">
				<span class="line"></span><span class="line"></span><span class="line"></span><span class="line line-angle1"></span><span class="line line-angle2"></span></a>
				받은 메일함<a><span class="icon glyphicon glyphicon-chevron-down"></span>
				</a>
			</h1>
		</header>
		<div class="action-bar">
			<ul>
				<li><a class="icon circle-icon glyphicon glyphicon-chevron-down"></a></li>
				<li><a class="icon circle-icon glyphicon glyphicon-refresh"></a></li>
				<li><a class="icon circle-icon glyphicon glyphicon-share-alt"></a></li>
				<li><a class="icon circle-icon red glyphicon glyphicon-remove"></a></li>
				<li><a class="icon circle-icon red glyphicon glyphicon-flag"></a></li>
			</ul>
		</div>
		<div id="main-nano-wrapper" class="nano has-scrollbar">
			<div class="nano-content" tabindex="0" style="right: -17px;">
				<ul class="message-list">
					<!-- mail list -->
					<c:forEach var="row" items="${mailList.rows}">
			            <li class="green-dot unread"  title="${row.rno} ${ row.mailid }"
			            	mailid="${row.mailid}"
			            	onclick="loadMailView( this );" 
			            >
							<div class="col col-1">
								<span class="dot"></span>
								<div class="checkbox-wrapper" >
									<input type="checkbox" id="chk2" > 
									<label for="chk2" class="toggle"></label>
								</div>
								<p class="title"> 
									${ row.title } 
								</p>
								<div class="star-star-toggle glyphicon glyphicon-star-empty"></div>
							</div>
							<div class="col col-2">
								<div class="subject" style="overflow:hidden; text-overflow: ellipsis;" >
									${ row.content }  
								</div>
								<div class="date" 
									title="<fmt:formatDate pattern='HH:mm:ss' value='${row.rcvDate}' />"
								> 
									<fmt:formatDate pattern="yyyy-MM-dd" value="${row.rcvDate}" />
								</div>
							</div>
						</li>
			         </c:forEach>					
					<!-- // mail list -->	
				</ul>
				
				<a href="#" class="load-more-link">
					 <span aria-hidden="true">&laquo;</span>
					 <span>1</span> &nbsp; 
					 <span>2</span> &nbsp;
					 <span>3</span> &nbsp;
					 <span>4</span> &nbsp;
					 <span>5</span> &nbsp;
					 <span>6</span> &nbsp;
					 <span>7</span> &nbsp;
					 <span>8</span> &nbsp;
					 <span>9</span> &nbsp;
					 <span aria-hidden="true">&raquo;</span>
				</a>
			</div>
			<div class="nano-pane">
				<div class="nano-slider" style="height: 213px; transform: translate(0px, 0px);"></div>
			</div>
		</div>
			
	</main>
	
	<div id="message">
		<h1> empty </h1>
		<br/>
		<h2> Ajax call is required to show the mail contents </h2>
	</div>

</body>
</html>