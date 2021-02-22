<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*, java.io.*, java.sql.*"%>
<%@ page import="org.apache.ibatis.jdbc.ScriptRunner"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- create db connection -->
<sql:setDataSource var="myDb" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://localhost:3306/MY_SCHEMA" user="MY_USER"
	password="admin" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>BBS 데이터베이스 초기화</title>
</head>

<body>

	<h2>BBS 데이터베이스 초기화</h2>

	<%
	if (true) {
		//Registering the Driver
		Class.forName("org.mariadb.jdbc.Driver");

		//Getting the connection
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/MY_SCHEMA", "MY_USER", "admin");

		out.println("<h3>Connection established.</h3>");
		
		//Initialize the script runner
		ScriptRunner sr = new ScriptRunner(conn);
		//Creating a reader object
		
		String path = "/DEV/Workspace/WebJSP/WebContent/lec/05_bbs_example/bbs_db_script.sql";
		BufferedReader reader = new BufferedReader(new FileReader(path));
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream(); 
		PrintWriter logWriter = new PrintWriter( new PrintStream(baos, true, "utf8" )  );	
		//Running the script
		sr.setLogWriter(logWriter);
		sr.runScript(reader); 
		logWriter.flush();
		
		out.println( "<pre>" );
		out.println( baos.toString() );
		out.println( "</pre>" );
		
		reader.close();
	}
	%>

</body>
</html>