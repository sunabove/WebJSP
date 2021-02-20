package lec.jdbc;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.InternetAddress;

import lec.SysProps;

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