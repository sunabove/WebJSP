package lec.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class JdbcExample01 {

	public static void main(String[] args) throws Exception {
		System.out.println( "Hello ..." );
		
		Class.forName("org.mariadb.jdbc.Driver");

		String url = "jdbc:mariadb://localhost:3306/MY_SCHEMA";

		Connection con = DriverManager.getConnection(url, "MY_USER", "admin");

		PreparedStatement stmt = null;
		
		con.close(); 
		
		System.out.println( "Good bye!" );		
	} 
}