package lec.list;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Data
@Slf4j
public class Employee {

	private String empId;
	private String firstName;
	private String lastname;
	private String phoneNo;
	private java.util.Date birthDate;

}