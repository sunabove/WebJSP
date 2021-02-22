package lec.jdbc;

import java.sql.*; 

public class JdbcEmployee {

	public static void main(String[] args) throws Exception {
		var out = System.out; 
		
		out.println( "Hello ..." );
		
		// Driver 등록, 어떤 DBMS를 사용할 것인지를 설정한다.
		
		Class.forName("org.mariadb.jdbc.Driver");

		// Create a database connection by using user name and password
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/MY_SCHEMA", "MY_USER", "admin");		
		
		Statement stmt = conn.createStatement();
		
		// drop table using statement
		int upNo = stmt.executeUpdate( "DROP TABLE if exists EMPLOYEE" );
		
		if( upNo == 0 ) {
			out.println( "\nEmployee tabled is dropped." );
		}
		
		// creatte table using statement
		String sql = """
					CREATE TABLE employee ( 
					  id INT PRIMARY KEY AUTO_INCREMENT ,
					  first_name VARCHAR(200) NOT NULL ,
					  last_name VARCHAR(200) ,
					  email VARCHAR(200) NOT NULL ,
					  age INT ,
					  phone_no VARCHAR(200) , 
					  up_dt TIMESTAMP DEFAULT now() 
					)			
				""";
		
		upNo = stmt.executeUpdate( sql );
		
		if( upNo == 0 ) {
			out.println( "Employee tabled is created." );
		}
		
		// insert a record using statement
		sql = "INSERT INTO employee(first_name, email, age) VALUES( 'john', 'john@google.com', 18 )" ;
		upNo = stmt.executeUpdate( sql );
		
		if( upNo >= 1 ) {
			out.println( "Employee record is inserted." );
		} else {
			out.println( "Employee tabled is not inserted." );
		}
		
		// insert record using prepared statement		
		sql = "INSERT INTO employee(first_name, email, age) VALUES( ?, ?, ? )" ;
		
		PreparedStatement pst = conn.prepareStatement( sql );
		
		Object [][] records = { { "brown", "brown@gmail.com", 20 }, { "jane", "jane@gmail.com", 22 } }; 
		
		for( var record : records ) {
			var idx = 1; // index starts from one.
			for( var c : record ) {
				if( c instanceof String ) { 
					pst.setString( idx ++, "" + c );
				} else if ( c instanceof Integer ) {
					pst.setInt(idx, (int) c);
				} 
			}
			upNo = pst.executeUpdate();
			
			if( upNo >= 1 ) {
				out.println( "Employee record is inserted. ");
			} else {
				out.println( "Employee tabled is not inserted." );
			}
		}
		
		// query using prepared statement, 재사용이 편리한 문장
		sql = "SELECT first_name, email, age FROM employee where 2 = ? ";
		pst = conn.prepareStatement( sql );
		
		var idx = 1 ; // index 1 부터 시작 .
		pst.setInt( idx ++, 2 );
		
		ResultSet rs = pst.executeQuery();
		
		out.println( "\nQuery Result ..." );
		
		while( rs.next() ) {
			idx = 1; // index 1 부터 시작 .
			
			String firstName = rs.getString( idx ++ );
			String email = rs.getString( idx ++ );
			Integer age = rs.getInt( "age" );
			
			out.println( String.format( "first_name = %s, email = %s, age = %s", firstName, email, age) );
		}
		
		// clear resources
		rs.close();
		pst.close();
		stmt.close();		
		conn.close(); 
		
		out.println( "\nGood bye!" );		
	} 
}