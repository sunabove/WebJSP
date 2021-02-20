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

public class CheckMailInsertDb {

	public static void main(String[] args) throws Exception {
		System.out.println( "Hello ..." );
		
		CheckMailInsertDb checkMailInsertDb = new CheckMailInsertDb();
		checkMailInsertDb.receiveEmail();
		
		System.out.println( "Good bye!" );		
	}

	public void receiveEmail() throws Exception {
		SysProps sysProps = new SysProps();

		String uname = sysProps.getProperty("mail.id");
		String password = sysProps.getProperty("mail.password");
		String host = "pop.gmail.com";

		// Set property values
		Properties propvals = new Properties();
		propvals.put("mail.pop3.host", host);
		propvals.put("mail.pop3.port", "995");
		propvals.put("mail.pop3.ssl.enable", "true");		
		propvals.put("mail.pop3.starttls.enable", "true");

		Session emailSessionObj = Session.getDefaultInstance(propvals);
		// Create POP3 store object and connect with the server
		Store storeObj = emailSessionObj.getStore("pop3s");
		storeObj.connect(host, uname, password);
		// Create folder object and open it in read-only mode
		Folder emailFolderObj = storeObj.getFolder("INBOX");
		emailFolderObj.open(Folder.READ_ONLY);
		// Fetch messages from the folder and print in a loop
		Message[] messages = emailFolderObj.getMessages();
		
		System.out.println( "Message Len = " + messages.length);

		this.insertIntoDb( messages, uname );
		 
		// Now close all the objects
		emailFolderObj.close(false);
		storeObj.close();	
	}

	public void insertIntoDb(Message[] messages, String rcvUserId ) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");

		String url = "jdbc:mariadb://localhost:3306/XCLICK_DEPLOY3_LARGE_DATA";

		Connection con = DriverManager.getConnection(url, "XCLICK_DEPLOY3", "admin");

		PreparedStatement stmtTmail = null;
		PreparedStatement stmtContent = null ;
		
		int idx = 0 ; 
		for (Message message : messages ) {
			String mailId = java.util.UUID.randomUUID().toString() ;; 
			int msgNo = message.getMessageNumber();
			
			Object from = message.getFrom()[0];
			
			if( from instanceof InternetAddress) {	
				from = ((InternetAddress) from).getAddress();
			}
			
			Object to = message.getRecipients(Message.RecipientType.TO)[0];			
			if( to instanceof InternetAddress) {	
				to = ((InternetAddress) to).getAddress();
			}
			
			String subject = message.getSubject(); 
			java.util.Date rcvDate = message.getReceivedDate();
			
			String contentType = message.getContentType();
			String content = "" ;
			
			System.out.println("----------------------------");
			System.out.println("CONTENT-TYPE: " + contentType );

			// check if the content is plain text
			if (message.isMimeType("text/plain")) {
				System.out.println("This is plain text");
				System.out.println("---------------------------");
				content = "" + message.getContent();
			}else if(message.isMimeType("multipart/*")) {
				// check if the content has attachment				
				System.out.println("This is a Multipart");
				System.out.println("---------------------------");
				content = "" ; 
				Multipart mp = (Multipart) message.getContent();
				for (int i = 0, iLen = mp.getCount(); i < iLen; i++) { 
					content += "" + mp.getBodyPart( i ); 
				}
			} else {
				Object o = message.getContent();
				if (o instanceof String) {
					System.out.println("This is a string");
					System.out.println("---------------------------");
					content = (String) o;
				} else if (o instanceof InputStream) {
					System.out.println("This is just an input stream");
					System.out.println("---------------------------");
					InputStream is = (InputStream) o;
					content = "" ; 
					int c;
					while ((c = is.read()) != -1) {
						content += c; 
					}
				} else {
					System.out.println("This is an unknown type");
					System.out.println("---------------------------");
					content = "" + o;
				}
			}
			
			System.out.println("Printing individual messages");
			System.out.println("No: " + (idx + 1 ));
			System.out.println("Message No: " + msgNo );
			System.out.println("Mail Id: " + mailId );
			System.out.println("Email Subject: " + subject );
			System.out.println("From: " + from );
			System.out.println("To: " + to );
			System.out.println("RcvDate: " + rcvDate );
			System.out.println("Content: " + content );
			
			if( true ) { 
				// 받은 메일
				if( stmtTmail == null ) {
					String sql = "";
					sql += "INSERT INTO T_MAIL( MAILID, TITLE, MAILSIZE, RCVDATE, RCVUSERID) values " ; 
					sql += "( ?, ?, ?, ?, ? )";
					stmtTmail = con.prepareStatement(sql);
				}
				
				PreparedStatement stmt = stmtTmail ;
				int i = 1 ; 
				stmt.setString(i++, mailId);
				stmt.setString(i++, subject);
				stmt.setInt(i++, ("" + content).length() );
				if( rcvDate == null ) {
					stmt.setNull(i++, java.sql.Types.TIMESTAMP);
				} else {
					stmt.setDate(i++, new java.sql.Date( rcvDate.getTime() ) );
				}				
				stmt.setString(i++, "" + from );				
				
				int upNo = stmt.executeUpdate();
				System.out.println(upNo + " records inserted.");
				System.out.println();
			}
			
			if( true ) {
				// 본문 내용 추가 // T_MAIL_SIMPLECONTENT
				
				if( stmtContent == null ) {
					String sql = "";
					sql += "INSERT INTO T_MAIL_SIMPLECONTENT ( ";
					sql += " MAILID, SIMPLECONTENT, REGDATE, CHGDATE, REGUSERID, CHGUSERID " ; 
					sql += " ) values ( ";
					sql += " ?, ?, NOW(), NOW(), " ;
					sql += " ( SELECT MIN(id) FROM user WHERE name = ? ) ," ;
					sql += " ( SELECT MIN(id) FROM user WHERE name = ? ) ," ;
					sql += " ) ";
					stmtContent = con.prepareStatement(sql);
				}
				PreparedStatement stmt = stmtContent ;
				int i = 1 ; 
				stmt.setString(i++, mailId);
				stmt.setString(i++, content );
				stmt.setString(i++, rcvUserId );
				stmt.setString(i++, rcvUserId );
				
				int upNo = stmt.executeUpdate();
				System.out.println(upNo + " records inserted.");
				System.out.println();
			}
			
			idx ++ ; 
		}
		
		con.close(); 
		
	}
}