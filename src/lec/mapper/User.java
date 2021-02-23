package lec.mapper;

import lombok.*;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter
@Setter
@ToString

public class User implements java.io.Serializable {
	private static final long serialVersionUID = -704899523852130939L;
	
	private String id ;
	private String name;
	private String passwd;
	private String phoneNo;	
	
	public static void main(String[] args) {
		User user = new User();
		
		String userId = user.getId() ; 
		
		System.out.println( "Hello World!" );
		System.out.println( "userId = " + userId );
		System.out.println( "toString 1 = " + userId.toString() );
	}

}
