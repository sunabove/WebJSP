package web;

import javax.persistence.Column;
import javax.persistence.Id;

import lombok.*;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter
@Setter
@ToString

public class User implements java.io.Serializable {
	private String id ;
	private String name;
	private String phoneNo;
	private String passwd;
	
	// test 
	
	public static void main(String[] args) {
		User user = new User();
		
		String userId = user.getId() ; 
		
		System.out.println( "Hello World!" );
		System.out.println( "userId = " + userId );
		System.out.println( "toString 1 = " + userId.toString() );
	}

}
