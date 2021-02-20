package lec.mapper;

import lombok.*;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter
@Setter
@ToString

public class Employee implements java.io.Serializable {
	private String id ;
	private String firstName ;
	private String lastName ;
	private String phoneNo;
	
	public void testLog() {
		this.log.debug( "Here, I am!");
	}

	public static void main(String[] args) {
		Employee emp = new Employee();
		
		String empId = emp.getId() ; 
		
		System.out.println( "Hello World!" );
		System.out.println( "empId = " + empId );
		System.out.println( "toString 1 = " + emp.toString() );
		
		emp.testLog();
	}

}
