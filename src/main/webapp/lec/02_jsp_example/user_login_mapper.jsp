<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.*, java.util.*, java.sql.*"%>
<%@ page import="org.apache.ibatis.io.Resources"%>
<%@ page import="org.apache.ibatis.session.*"%>
<%@ page import="oracle.jdbc.driver.OracleDriver"%>

<%@ page import="lec.mapper.*"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
InputStream inputStream = Resources.getResourceAsStream("mybatis-config.xml");
SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

SqlSession sess = sqlSessionFactory.openSession();

UserMapper mapper = sess.getMapper(UserMapper.class);

String name = request.getParameter("name");
String passwd = request.getParameter("passwd");

User temp = new User();
temp.setName(name);
temp.setPasswd(passwd);

User user = mapper.logIn(temp);

System.out.println("user = " + user);

boolean logInSuccess = (user != null);

System.out.println("logInSuccess = " + logInSuccess);

request.setAttribute("logInSuccess", logInSuccess);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="container">
		<br />
		<h2>웹 메일 시스템 로그인</h2>
		<c:if test="${ not logInSuccess }">
			<form method="post">
				<div class="form-group">
					<label for="email">아이디:</label> <input type="text"
						class="form-control" id="email" placeholder="아이디를 입력하세요."
						name="name" />
				</div>
				<div class="form-group">
					<label for="pwd">패스워드:</label> <input type="password"
						class="form-control" id="pwd" placeholder="패스워드를 입력하세요."
						name="passwd" />
				</div>
				<div class="form-group form-check">
					<label class="form-check-label"> <input
						class="form-check-input" type="checkbox" name="remember" />
						Remember me
					</label>
				</div>
				<button type="submit" class="btn btn-primary">로그인</button>
			</form>
		</c:if>

		<c:if test="${ logInSuccess }">
			<br />
			<h4>웹 메일 시스템에 오신 것을 환영합니다.</h4>
			<div class="container">
				<h2>Growing Spinners</h2>
				<p>
					Use the
					<code>.spinner-grow</code>
					class if you want the spinner/loader to grow instead of "spin":
				</p>

				<div class="spinner-grow text-muted"></div>
				<div class="spinner-grow text-primary"></div>
				<div class="spinner-grow text-success"></div>
				<div class="spinner-grow text-info"></div>
				<div class="spinner-grow text-warning"></div>
				<div class="spinner-grow text-danger"></div>
				<div class="spinner-grow text-secondary"></div>
				<div class="spinner-grow text-dark"></div>
				<div class="spinner-grow text-light"></div>
			</div>
		</c:if>

	</div>

</body>
</html>
