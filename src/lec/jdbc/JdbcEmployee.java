package lec.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class JdbcEmployee {

	public static void main(String[] args) throws Exception {
		var out = System.out; 
		
		out.println( "Hello ..." );
		
		Class.forName("org.mariadb.jdbc.Driver");

		String url = "jdbc:mariadb://localhost:3306/MY_SCHEMA";

		Connection conn = DriverManager.getConnection(url, "MY_USER", "admin");		
		
		Statement stmt = conn.createStatement();
		
		// drop table using statement
		int upNo = stmt.executeUpdate( "DROP TABLE if exists EMPLOYEE" );
		
		if( upNo >= 1 ) {
			out.println( "Employee tabled is deleted." );
		} else {
			out.println( "Employee tabled is not deleted." );
		}
		
		// creatte table using statement
		String sql = """
					CREATE TABLE employee ( 
					  id int PRIMARY KEY AUTO_INCREMENT ,
					  first_name VARCHAR(200) ,
					  last_name VARCHAR(200) ,
					  email VARCHAR(200) ,
					  phone_no VARCHAR(200)
					) ;				
				""";
		
		upNo = stmt.executeUpdate( sql );
		
		if( upNo >= 1 ) {
			out.println( "Employee tabled is created." );
		} else {
			out.println( "Employee tabled is not created." );
		}
		
		// insert a record using statement
		sql = "INSERT INTO employee(first_name, email) VALUES( 'john', 'john@google.com' )" ;
		upNo = stmt.executeUpdate( sql );
		
		if( upNo >= 1 ) {
			out.println( "Employee record is inserted." );
		} else {
			out.println( "Employee tabled is not inserted." );
		}
		
		// insert record using prepared statement		
		sql = "INSERT INTO employee(first_name, email) VALUES( ?, ? )" ;
		
		PreparedStatement pst = conn.prepareStatement( sql );
		String [][] records = { { "brown", "brown@gmail.com" }, { "jane", "jane@gmail.com" } }; 
		
		for( var record : records ) {
			var idx = 1; // Index starts from one.
			for( var c : record ) {
				pst.setString( idx ++, c );
			}
			upNo = pst.executeUpdate();
			if( upNo >= 1 ) {
				out.println( "Employee record is inserted. ");
			} else {
				out.println( "Employee tabled is not inserted." );
			}
		}
		
		// query using prepared statement
		sql = "SELECT first_name, email FROM employee where 1 = ?";
		pst = conn.prepareStatement( sql );
		var idx = 1 ;
		pst.setInt( idx ++, 1 );
		ResultSet rs = pst.executeQuery();
		out.println( "Query Result..." );
		while( rs.next() ) {
			idx = 1;
			String firstName = rs.getString( idx ++ );
			String email = rs.getString( idx ++ );
			out.println( String.format( "first_name = %s, email = %s", firstName, email) );
		}
		
		// clear resources
		rs.close();
		pst.close();
		stmt.close();		
		conn.close(); 
		
		out.println( "Good bye!" );		
	} 
}