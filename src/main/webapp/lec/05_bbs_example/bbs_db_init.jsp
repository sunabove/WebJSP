<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*, java.io.*, java.sql.*"%>
<%@ page import="org.apache.ibatis.jdbc.ScriptRunner"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
		Class.forName("oracle.jdbc.driver.OracleDriver");

		//Getting the connection
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "john", "a");

		out.println("<h3>Connection established.</h3>");
		
		//Initialize the script runner
		ScriptRunner scriptRunner = new ScriptRunner(conn);
		
		//Creating a reader object		
		// scipt file 
		// C:\DEV\Workspace\WebJSP\src\main\webapp\lec\05_bbs_example
		String path = "/DEV/Workspace/WebJSP/src/main/webapp/lec/05_bbs_example/bbs_db_script_oracle.sql";
		
		BufferedReader reader = new BufferedReader(new FileReader(path));
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream(); 
		PrintWriter logWriter = new PrintWriter( new PrintStream(baos, true, "utf-8" )  );
		
		//Running the script
		scriptRunner.setLogWriter(logWriter); 
		scriptRunner.runScript(reader); 
		
		logWriter.flush();
		
		out.println( "<pre>" );
		out.println( baos.toString( "utf-8" ) );
		out.println( "</pre>" );
		
		reader.close();
		
		out.println("<h3>The database is initialized sucessfully.</h3>");
	}
	%>

</body>
</html>